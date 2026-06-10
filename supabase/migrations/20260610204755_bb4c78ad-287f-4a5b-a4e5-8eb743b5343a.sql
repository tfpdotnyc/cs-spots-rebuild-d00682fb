-- ============================================================
-- Phase 3 — SPOTS core migration (14 in-scope tables + auth)
-- ============================================================

-- ---------- ENUMS ----------
CREATE TYPE public.app_role AS ENUM ('admin', 'manager', 'staff');
CREATE TYPE public.session_status_enum AS ENUM ('scheduled','in_progress','complete','cancelled','no_show','retake');
CREATE TYPE public.order_status_enum   AS ENUM ('new','submitted','in_production','shipped','delivered','cancelled','closed');

-- ---------- SHARED TRIGGER FN ----------
CREATE OR REPLACE FUNCTION public.tg_set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql SET search_path = public AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END $$;

-- ============================================================
-- TENANCY: studios, schools
-- ============================================================
CREATE TABLE public.studios (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_studio_no INTEGER UNIQUE,
  name            TEXT NOT NULL,
  spotspath       TEXT,
  storage_bucket_prefix TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.studios TO authenticated;
GRANT ALL ON public.studios TO service_role;
ALTER TABLE public.studios ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.studios FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();

CREATE TABLE public.schools (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_school_id INTEGER,
  studio_id       UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  name            TEXT NOT NULL,
  classof         TEXT,
  schoolpath      TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0,
  UNIQUE (studio_id, legacy_school_id)
);
CREATE INDEX schools_studio_idx ON public.schools(studio_id);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.schools TO authenticated;
GRANT ALL ON public.schools TO service_role;
ALTER TABLE public.schools ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.schools FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();

-- ============================================================
-- IDENTITY: profiles, user_roles, user_studios + helpers
-- ============================================================
CREATE TABLE public.profiles (
  id          UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  email       TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.profiles TO authenticated;
GRANT ALL ON public.profiles TO service_role;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();

CREATE TABLE public.user_roles (
  id      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  role    public.app_role NOT NULL,
  UNIQUE (user_id, role)
);
GRANT SELECT ON public.user_roles TO authenticated;
GRANT ALL ON public.user_roles TO service_role;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

CREATE TABLE public.user_studios (
  user_id   UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  studio_id UUID NOT NULL REFERENCES public.studios(id) ON DELETE CASCADE,
  PRIMARY KEY (user_id, studio_id)
);
GRANT SELECT ON public.user_studios TO authenticated;
GRANT ALL ON public.user_studios TO service_role;
ALTER TABLE public.user_studios ENABLE ROW LEVEL SECURITY;

-- Security-definer helpers (no recursion)
CREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role public.app_role)
RETURNS BOOLEAN LANGUAGE SQL STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT EXISTS (SELECT 1 FROM public.user_roles WHERE user_id = _user_id AND role = _role)
$$;

CREATE OR REPLACE FUNCTION public.has_studio_access(_user_id UUID, _studio_id UUID)
RETURNS BOOLEAN LANGUAGE SQL STABLE SECURITY DEFINER SET search_path = public AS $$
  SELECT public.has_role(_user_id, 'admin')
      OR EXISTS (SELECT 1 FROM public.user_studios WHERE user_id = _user_id AND studio_id = _studio_id)
$$;

-- Auto-create profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$
BEGIN
  INSERT INTO public.profiles (id, email, display_name)
  VALUES (NEW.id, NEW.email, COALESCE(NEW.raw_user_meta_data ->> 'display_name', NEW.email));
  RETURN NEW;
END $$;

CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Policies: tenancy + identity
CREATE POLICY "admin all studios" ON public.studios FOR ALL TO authenticated
  USING (public.has_role(auth.uid(), 'admin')) WITH CHECK (public.has_role(auth.uid(), 'admin'));
CREATE POLICY "members read assigned studios" ON public.studios FOR SELECT TO authenticated
  USING (public.has_studio_access(auth.uid(), id));

CREATE POLICY "studio access schools" ON public.schools FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

CREATE POLICY "self read profile" ON public.profiles FOR SELECT TO authenticated USING (id = auth.uid() OR public.has_role(auth.uid(),'admin'));
CREATE POLICY "self update profile" ON public.profiles FOR UPDATE TO authenticated USING (id = auth.uid()) WITH CHECK (id = auth.uid());
CREATE POLICY "admin manage profiles" ON public.profiles FOR ALL TO authenticated USING (public.has_role(auth.uid(),'admin')) WITH CHECK (public.has_role(auth.uid(),'admin'));

CREATE POLICY "self read roles" ON public.user_roles FOR SELECT TO authenticated USING (user_id = auth.uid() OR public.has_role(auth.uid(),'admin'));
CREATE POLICY "admin manage roles" ON public.user_roles FOR ALL TO authenticated USING (public.has_role(auth.uid(),'admin')) WITH CHECK (public.has_role(auth.uid(),'admin'));

CREATE POLICY "self read user_studios" ON public.user_studios FOR SELECT TO authenticated USING (user_id = auth.uid() OR public.has_role(auth.uid(),'admin'));
CREATE POLICY "admin manage user_studios" ON public.user_studios FOR ALL TO authenticated USING (public.has_role(auth.uid(),'admin')) WITH CHECK (public.has_role(auth.uid(),'admin'));

-- ============================================================
-- LOOKUPS: accesslevels, lists
-- ============================================================
CREATE TABLE public.accesslevels (
  id          SMALLINT PRIMARY KEY,
  description TEXT NOT NULL
);
GRANT SELECT ON public.accesslevels TO authenticated;
GRANT ALL ON public.accesslevels TO service_role;
ALTER TABLE public.accesslevels ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read accesslevels" ON public.accesslevels FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin write accesslevels" ON public.accesslevels FOR ALL TO authenticated USING (public.has_role(auth.uid(),'admin')) WITH CHECK (public.has_role(auth.uid(),'admin'));

CREATE TABLE public.lists (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  list_name   TEXT NOT NULL,
  item_value  TEXT NOT NULL,
  sort_order  INTEGER,
  is_active   BOOLEAN NOT NULL DEFAULT true,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX lists_name_idx ON public.lists(list_name);
GRANT SELECT ON public.lists TO authenticated;
GRANT ALL ON public.lists TO service_role;
ALTER TABLE public.lists ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read lists" ON public.lists FOR SELECT TO authenticated USING (true);
CREATE POLICY "admin write lists" ON public.lists FOR ALL TO authenticated USING (public.has_role(auth.uid(),'admin')) WITH CHECK (public.has_role(auth.uid(),'admin'));

-- ============================================================
-- CORE TRANSACTIONAL TABLES
-- ============================================================

-- ---------- customers ----------
CREATE TABLE public.customers (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_customer_id INTEGER,
  studio_id         UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  school_id         UUID REFERENCES public.schools(id) ON DELETE SET NULL,
  lastname          TEXT, firstname TEXT, middlename TEXT,
  address1          TEXT, city TEXT, state TEXT, zip TEXT,
  phone             TEXT, cell1 TEXT, cell2 TEXT,
  email1            TEXT, email2 TEXT, email3 TEXT,
  webpw             TEXT,
  misc1 TEXT, misc2 TEXT, misc3 TEXT,
  overlay_text      TEXT,
  company_customer_no TEXT,
  grade             TEXT,
  student_id_1      TEXT, student_id_2 TEXT,
  ids_printed_count INTEGER NOT NULL DEFAULT 0,
  is_retake         BOOLEAN NOT NULL DEFAULT false,
  gender            TEXT,
  proof_due_date    DATE,
  proofbook_front   TEXT, proofbook_back TEXT,
  yb_pose           SMALLINT, aux_pose SMALLINT,
  notes             TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0,
  UNIQUE (studio_id, legacy_customer_id)
);
CREATE INDEX customers_studio_idx ON public.customers(studio_id);
CREATE INDEX customers_school_idx ON public.customers(school_id);
CREATE INDEX customers_name_idx ON public.customers(lastname, firstname);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.customers TO authenticated;
GRANT ALL ON public.customers TO service_role;
ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access customers" ON public.customers FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- sessions ----------
CREATE TABLE public.sessions (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_session_id INTEGER,
  sessionnumber     TEXT NOT NULL,
  customer_id       UUID NOT NULL REFERENCES public.customers(id) ON DELETE CASCADE,
  studio_id         UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  photographer_id   UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  session_by_id     UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  session_type      TEXT,
  session_date      DATE,
  status            public.session_status_enum NOT NULL DEFAULT 'scheduled',
  notes             TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0,
  UNIQUE (customer_id, sessionnumber)
);
CREATE INDEX sessions_studio_idx ON public.sessions(studio_id);
CREATE INDEX sessions_customer_idx ON public.sessions(customer_id);
CREATE INDEX sessions_date_idx ON public.sessions(session_date);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.sessions TO authenticated;
GRANT ALL ON public.sessions TO service_role;
ALTER TABLE public.sessions ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.sessions FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access sessions" ON public.sessions FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- imageproperties ----------
CREATE TABLE public.imageproperties (
  customer_id     UUID NOT NULL REFERENCES public.customers(id) ON DELETE CASCADE,
  session_id      UUID NOT NULL REFERENCES public.sessions(id) ON DELETE CASCADE,
  sessionnumber   TEXT NOT NULL,
  pose            SMALLINT NOT NULL,
  studio_id       UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  rawname         TEXT, fullname TEXT, fullnameorg TEXT, thmbname TEXT,
  raw_key         TEXT, full_key TEXT, thumb_key TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (customer_id, sessionnumber, pose)
);
CREATE INDEX imageproperties_studio_idx ON public.imageproperties(studio_id);
CREATE INDEX imageproperties_session_idx ON public.imageproperties(session_id);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.imageproperties TO authenticated;
GRANT ALL ON public.imageproperties TO service_role;
ALTER TABLE public.imageproperties ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.imageproperties FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access imageproperties" ON public.imageproperties FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- posesettings ----------
CREATE TABLE public.posesettings (
  customer_id   UUID NOT NULL,
  sessionnumber TEXT NOT NULL,
  pose          SMALLINT NOT NULL,
  studio_id     UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  settings      JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (customer_id, sessionnumber, pose),
  FOREIGN KEY (customer_id, sessionnumber, pose) REFERENCES public.imageproperties(customer_id, sessionnumber, pose) ON DELETE CASCADE
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.posesettings TO authenticated;
GRANT ALL ON public.posesettings TO service_role;
ALTER TABLE public.posesettings ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.posesettings FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access posesettings" ON public.posesettings FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- appointments ----------
CREATE TABLE public.appointments (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_appointment_id INTEGER,
  customer_id         UUID NOT NULL REFERENCES public.customers(id) ON DELETE CASCADE,
  studio_id           UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  appointment_at      TIMESTAMPTZ NOT NULL,
  scheduled_by        UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  scheduled_on        TIMESTAMPTZ DEFAULT now(),
  status              TEXT,
  session_type        TEXT,
  notes               TEXT,
  slots               INTEGER,
  not_listed          BOOLEAN NOT NULL DEFAULT false,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion   INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX appointments_studio_idx ON public.appointments(studio_id);
CREATE INDEX appointments_customer_idx ON public.appointments(customer_id);
CREATE INDEX appointments_when_idx ON public.appointments(appointment_at);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.appointments TO authenticated;
GRANT ALL ON public.appointments TO service_role;
ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.appointments FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access appointments" ON public.appointments FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- orders ----------
CREATE TABLE public.orders (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_order_id   INTEGER,
  customer_id       UUID NOT NULL REFERENCES public.customers(id) ON DELETE RESTRICT,
  studio_id         UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  order_by_id       UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  parent_order_id   UUID REFERENCES public.orders(id) ON DELETE SET NULL,
  order_type        TEXT,
  order_date        DATE NOT NULL DEFAULT CURRENT_DATE,
  status            public.order_status_enum NOT NULL DEFAULT 'new',
  is_rush           BOOLEAN NOT NULL DEFAULT false,
  total_amount      NUMERIC(12,2) NOT NULL DEFAULT 0,
  notes             TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX orders_studio_idx ON public.orders(studio_id);
CREATE INDEX orders_customer_idx ON public.orders(customer_id);
CREATE INDEX orders_date_idx ON public.orders(order_date);
CREATE INDEX orders_status_idx ON public.orders(status);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.orders TO authenticated;
GRANT ALL ON public.orders TO service_role;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access orders" ON public.orders FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- orderdetails ----------
CREATE TABLE public.orderdetails (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_order_detail_id INTEGER,
  order_id          UUID NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
  studio_id         UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  item_code         TEXT,
  description       TEXT,
  quantity          INTEGER NOT NULL DEFAULT 1,
  unit_price        NUMERIC(12,2) NOT NULL DEFAULT 0,
  line_total        NUMERIC(12,2) NOT NULL DEFAULT 0,
  pose              SMALLINT,
  comments          TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX orderdetails_order_idx ON public.orderdetails(order_id);
CREATE INDEX orderdetails_studio_idx ON public.orderdetails(studio_id);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.orderdetails TO authenticated;
GRANT ALL ON public.orderdetails TO service_role;
ALTER TABLE public.orderdetails ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.orderdetails FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access orderdetails" ON public.orderdetails FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- orderpayments (NO CARD DATA — token only) ----------
CREATE TABLE public.orderpayments (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_payment_id INTEGER,
  order_id          UUID NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
  studio_id         UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  paid_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  amount            NUMERIC(12,2) NOT NULL,
  payment_method    TEXT,
  payment_method_token TEXT,
  is_deposit        BOOLEAN NOT NULL DEFAULT false,
  notes             TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX orderpayments_order_idx ON public.orderpayments(order_id);
CREATE INDEX orderpayments_studio_idx ON public.orderpayments(studio_id);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.orderpayments TO authenticated;
GRANT ALL ON public.orderpayments TO service_role;
ALTER TABLE public.orderpayments ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.orderpayments FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access orderpayments" ON public.orderpayments FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- sessionpayments (NO CARD DATA — token only) ----------
CREATE TABLE public.sessionpayments (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_payment_id INTEGER,
  session_id        UUID NOT NULL REFERENCES public.sessions(id) ON DELETE CASCADE,
  studio_id         UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  paid_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  amount            NUMERIC(12,2) NOT NULL,
  payment_method    TEXT,
  payment_method_token TEXT,
  is_deposit        BOOLEAN NOT NULL DEFAULT false,
  is_appointment_deposit BOOLEAN NOT NULL DEFAULT false,
  notes             TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  legacy_rowversion INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX sessionpayments_session_idx ON public.sessionpayments(session_id);
CREATE INDEX sessionpayments_studio_idx ON public.sessionpayments(studio_id);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.sessionpayments TO authenticated;
GRANT ALL ON public.sessionpayments TO service_role;
ALTER TABLE public.sessionpayments ENABLE ROW LEVEL SECURITY;
CREATE TRIGGER set_updated_at BEFORE UPDATE ON public.sessionpayments FOR EACH ROW EXECUTE FUNCTION public.tg_set_updated_at();
CREATE POLICY "studio access sessionpayments" ON public.sessionpayments FOR ALL TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id))
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));

-- ---------- actions (audit trail, preserved from SPOTS) ----------
CREATE TABLE public.actions (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  legacy_action_id  INTEGER,
  order_id          UUID REFERENCES public.orders(id) ON DELETE SET NULL,
  action_code       SMALLINT NOT NULL,
  action_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  user_id           UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  studio_id         UUID NOT NULL REFERENCES public.studios(id) ON DELETE RESTRICT,
  extra_id          INTEGER,
  update_flag       INTEGER,
  ybo               BOOLEAN NOT NULL DEFAULT false,
  spotting          BOOLEAN NOT NULL DEFAULT false,
  reprint           BOOLEAN NOT NULL DEFAULT false,
  partial           BOOLEAN NOT NULL DEFAULT false,
  pending_item      TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX actions_order_idx ON public.actions(order_id);
CREATE INDEX actions_studio_idx ON public.actions(studio_id);
CREATE INDEX actions_at_idx ON public.actions(action_at);
CREATE INDEX actions_user_idx ON public.actions(user_id);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.actions TO authenticated;
GRANT ALL ON public.actions TO service_role;
ALTER TABLE public.actions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "studio read actions" ON public.actions FOR SELECT TO authenticated
  USING (public.has_studio_access(auth.uid(), studio_id));
CREATE POLICY "studio write actions" ON public.actions FOR INSERT TO authenticated
  WITH CHECK (public.has_studio_access(auth.uid(), studio_id));
CREATE POLICY "admin manage actions" ON public.actions FOR ALL TO authenticated
  USING (public.has_role(auth.uid(),'admin'))
  WITH CHECK (public.has_role(auth.uid(),'admin'));