# SPOTS 2027 — Entity Map

Version: 0.1.0
Last Updated: 2026-06-05

Grouped ASCII diagrams for the target Postgres schema. PK = primary key, FK = foreign key, ◇ = soft-tenant (`studio_id` on virtually every transactional table).

---

## A. Tenant & Identity

```text
                ┌──────────────────────┐
                │ studios              │
                │  PK id (uuid)        │
                │  legacy_studio_no    │
                │  storage_bucket_pre… │
                └─────────┬────────────┘
                          │ 1
          ┌───────────────┼─────────────────────────┐
          │ N             │ N                       │ N
┌─────────▼─────────┐  ┌──▼────────────────┐  ┌─────▼────────────┐
│ studio_defaults   │  │ schools           │  │ users / profiles │
│  PK id            │  │  PK id            │  │  PK id           │
│  studio_id FK     │  │  legacy_school_id │  │  studio_id FK ◇  │
└───────────────────┘  │  studio_id FK ◇   │  └─────┬────────────┘
                       └──┬────────────────┘        │
                          │ 1                       │ N
                          │ N                       │
                  ┌───────▼──────┐          ┌───────▼────────────┐
                  │ customers    │          │ user_roles         │
                  │  PK id       │          │  user_id FK        │
                  │  school_id FK│          │  role app_role     │
                  │  studio_id ◇ │          └────────────────────┘
                  └──────────────┘
```

`has_studio_access(auth.uid(), studio_id)` (SECURITY DEFINER) gates every RLS policy on tenanted tables.

---

## B. Customer → Session → Image

```text
┌────────────┐  1   N ┌────────────┐  1   N ┌──────────────────────┐
│ customers  ├────────► sessions   ├────────► image_properties     │
│  PK id     │        │  PK id     │        │  PK (customer_id,    │
│  studio_id │        │  session_# │        │      session_number, │
└─────┬──────┘        │  studio_id │        │      pose)           │
      │ 1             │  photog_id │        │  raw/full/thumb keys │
      │               └─────┬──────┘        └──────────┬───────────┘
      │ N                   │ 1                        │ 1
      │                     │ N                        │ 1
┌─────▼──────────┐  ┌───────▼─────────┐       ┌────────▼──────────┐
│ appointments   │  │ session_payments│       │ pose_settings     │
│  studio_id ◇   │  │ session_items   │       │  PK (cust, sess#, │
└────────────────┘  │ session_details │       │      pose_no)     │
                    └─────────────────┘       │  non-destructive  │
                                              └───────────────────┘
```

Storage layout (Phase 6):
```text
raw/{studio_id}/{customer_id}/{session_number}/{pose}.{ext}
full/{studio_id}/...
full-orig/{studio_id}/...
thumb/{studio_id}/...
```

---

## C. Orders & Payments

```text
┌────────────┐ 1  N ┌────────────┐ 1  N ┌──────────────────┐
│ customers  ├──────► orders     ├──────► order_details    │
└────────────┘      │  PK id     │      │  order_id FK     │
                    │  studio_id │      │  order_item_id   │
                    │  user_id   │      └────────┬─────────┘
                    └─────┬──────┘               │ 1
                          │ 1                    │ N
                          │ N                    │
                 ┌────────▼────────┐    ┌────────▼──────────────┐
                 │ order_payments  │    │ order_detail_comments │
                 │  (no card data) │    └───────────────────────┘
                 │  payment_method │
                 │  _token TEXT    │
                 └─────────────────┘

                 ┌────────────────┐    ┌──────────────────┐
                 │ pose_orders    │    │ deposit_payments │
                 │  PK (cust,     │    │  (no card data)  │
                 │      sess#,    │    └──────────────────┘
                 │      pose_no)  │
                 └────────────────┘
```

Lookup chain: `order_items` ← `order_item_types`, `shipping` ← `shipping_methods`, `misc_payment_types`.

---

## D. Scheduling

```text
┌────────────────┐         ┌──────────────────────┐
│ studios        │ 1     N │ photographers        │
└──────┬─────────┘─────────►  studio_id ◇         │
       │ 1                 └──────────┬───────────┘
       │ N                            │ 1
┌──────▼──────────┐  ┌────────────────▼──────────┐
│ blocked_times   │  │ photographer_breaks       │
│ off_days        │  └───────────────────────────┘
│ labeled_days ── │           │
│   day_labels    │           │
└─────────────────┘  ┌────────▼─────────┐
                     │ appointments     │
                     │  customer_id     │
                     │  studio_id ◇     │
                     └──────────────────┘
```

---

## E. Image Pipeline (Phase 6 runtime)

```text
                ┌─────────────────────┐
upload  ───►   │  raw/  bucket        │
                └─────────┬───────────┘
                          │  trigger
                          ▼
              ┌────────────────────────────┐
              │ Edge Function: derive      │
              │   reads export_image_      │
              │   presets (sizes)          │
              │   applies pose_settings    │
              └────┬───────────┬───────────┘
                   │           │
                   ▼           ▼
            ┌──────────┐  ┌──────────┐
            │  full/   │  │  thumb/  │
            └──────────┘  └──────────┘
                   │
        export ───►│
                   ▼
            ┌──────────┐
            │ signed   │
            │ URL      │
            └──────────┘
```

---

## F. Lookups & Reference

```text
lists ── customer_lists ── customer_list_data
backgrounds | colors | boys_attire | girls_attire | id_symbols
resit_reasons | retouch_status | retouchers | printing_labs | process_steps
session_statuses ─ session_status_legend
access_levels
shipping_methods
misc_payment_types
email_setups
system_settings
day_labels
export_image_presets   ◄── drives derivative generator
```

---

## G. Audit & Sync

```text
┌────────────────────┐   ┌────────────────────────┐
│ audit_customer_    │   │ audit_static_table_    │
│   changes          │   │   changes              │
└────────────────────┘   └────────────────────────┘

every tenanted table includes:
  legacy_rowversion INTEGER   (delta-sync cursor for satellites)
  updated_at TIMESTAMPTZ      (latest-write conflict resolution)
  device_id UUID NULL         (added in Phase 7 for offline laptops)
```

---

## H. Deferred — Templates & Overlays (Phase 8)

```text
Std* family (16 tables)        Ox* family (XML payloads)
  StdTemplates                   OxTemplates
  StdNodes                       OxTemplatesAttXML
  StdPackages / Contents         OxFileSetDefXML
  StdOverlayTemplates*           tmpOxTemplatesAttXML
  StdSportsMatesTemplates*

Plan: XML blobs → Supabase Storage bucket `templates/`,
      metadata rows stay in Postgres.
```

---

## Maintenance protocol

Same as `SCHEMA.md`: bump version on any change, update `Last Updated`, append a line in `BUILD_PLAN.md` Audit Trail.
