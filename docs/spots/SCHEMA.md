# SPOTS 2027 — Canonical Schema (Access → Postgres)

Version: 0.1.0
Last Updated: 2026-06-05
Source: `SPOTS2027.MDB` (Jet4, 114 tables) → reference DDL at `/mnt/documents/SPOTS2027_schema.sql`.

This is the **single source of truth** for the target Postgres schema. Lovable updates this file whenever a table is added, renamed, or its type/constraint contract changes. The Build Plan page at `/build-plan` references this work.

---

## 1. Conventions (apply to every table unless noted)

| Concern | Access (legacy) | Postgres (target) |
| --- | --- | --- |
| Primary keys | Mostly missing or `AutoNumber` | `id BIGSERIAL PRIMARY KEY` (or composite where natural) — always explicit |
| Tenant column | `studio SMALLINT` on most tx tables | `studio_id UUID REFERENCES studios(id) NOT NULL` |
| Booleans | `BOOLEAN NOT NULL` defaulting to false | `BOOLEAN NOT NULL DEFAULT false` |
| Soft delete | `deleted BOOLEAN` + `datedeleted` + `deletedby` + parallel `(deleted records)` shadow tables | Single `deleted_at TIMESTAMPTZ NULL` + partial indexes; shadows dropped |
| Audit fields | `update INTEGER` + ad-hoc `lastupdateuser` / `lastupdatedate` | `created_at`, `updated_at TIMESTAMPTZ NOT NULL DEFAULT now()` + `legacy_rowversion INTEGER` retained for delta-sync |
| Timestamps | `TIMESTAMP WITHOUT TIME ZONE` | `TIMESTAMPTZ` (UTC) |
| `sessionnumber` | `VARCHAR(2)` with values like `"01"`, `"RT"` | Keep as `TEXT` — do NOT coerce to integer |
| Customer name | `s_firstname/s_lastname VARCHAR(4)` + `firstname/lastname VARCHAR(50)` | Coalesce into single `first_name`, `last_name`; preserve abbrev as `short_first`, `short_last` |
| Payment card data | `creditcardnumber`, `ccsecuritycode`, `expirationdate`, `creditcardtype` | **NOT migrated.** Replaced by `payment_method_token TEXT` referencing Stripe/Paddle |
| Image paths | 4 separate path columns | Keep `raw_path`, `full_path`, `full_orig_path`, `thumb_path` — but resolved against Supabase Storage buckets, not local FS |
| Case | Mixed (`ImageProperties`, `Default_ExportImagesData`) | All lowercase snake_case |
| RLS | None | Enabled on every public table; tenant filter via `has_studio_access(auth.uid(), studio_id)` SECURITY DEFINER fn |

### GRANT block (mandatory after each `CREATE TABLE public.<t>`)

```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON public.<t> TO authenticated;
GRANT ALL ON public.<t> TO service_role;
```

---

## 2. Table inventory (114 source → ~70 target)

Legend — Action: `KEEP` (1:1 migrate), `RENAME` (column/case fixes), `SPLIT` (decompose), `MERGE` (fold into another), `DROP` (do not migrate), `DEFER` (template/template-utility, revisit in Phase 8).

### 2.1 Core domain

| # | Access table | Action | Target table | Notes |
|---|---|---|---|---|
| 1 | `Customers` | RENAME | `customers` | Coalesce names; strip card fields; soft-delete normalize |
| 2 | `Sessions` | RENAME | `sessions` | PK `session_id`; `sessionnumber` TEXT; tenant via `studio_id` |
| 3 | `Appointments` | KEEP | `appointments` | Has PK; index `(studio_id, appointment_date)` |
| 4 | `Orders` | RENAME | `orders` | PK `order_id`; FK `customer_id`, `studio_id`, `user_id` |
| 5 | `OrderDetails` | KEEP | `order_details` | FK `order_id`; preserve `unit_color`, `unit_size`, `order_item_id` |
| 6 | `OrderDetailsComments` | KEEP | `order_detail_comments` | FK `(order_id, order_detail_id)` |
| 7 | `OrderDetailsNonAuto` + `OrderDetailsNonAutoText` | MERGE | `order_details_freeform` | Join into one row per detail |
| 8 | `OrderItems` + `OrderItemType` | KEEP | `order_items`, `order_item_types` | Lookup pair |
| 9 | `OrderPayments` | KEEP | `order_payments` | Strip card fields; add `payment_method_token` |
| 10 | `PoseOrders` | KEEP | `pose_orders` | Composite PK `(customer_id, session_number, pose_no)` |
| 11 | `SessionPayments` | KEEP | `session_payments` | Strip card fields |
| 12 | `SessionItems` | KEEP | `session_items` | FK `session_id` |
| 13 | `SessionDetail` | KEEP | `session_details` | FK `session_id` |
| 14 | `SessionStatus` + `SessionStatusLegend` | KEEP | `session_statuses`, `session_status_legend` | Lookup pair |
| 15 | `DepositPayments` | KEEP | `deposit_payments` | Strip card fields |
| 16 | `MiscPaymentTypes` | KEEP | `misc_payment_types` | Has `SERIAL` PK |
| 17 | `Shipping` + `ShippingMethods` | KEEP | `shipping`, `shipping_methods` | Lookup pair |
| 18 | `FilmRolls` | KEEP | `film_rolls` | PK `roll_number` |

### 2.2 Image / media

| # | Access table | Action | Target table | Notes |
|---|---|---|---|---|
| 19 | `ImageProperties` | RENAME | `image_properties` | Composite PK `(customer_id, session_number, pose)`; path columns mapped to bucket keys |
| 20 | `PoseSettings` | RENAME | `pose_settings` | Non-destructive edits; composite PK `(customer_id, session_number, pose_no)` |
| 21 | `Default_ExportImagesData` | RENAME | `export_image_presets` | Drives Edge-Function derivative sizes |
| 22 | `CustomerComposites` + `…Borders` + `…Pages` + `…Utility` | KEEP (4 tables) | `customer_composites*` | FK chain on `customer_id` |

### 2.3 Tenant / org

| # | Access table | Action | Target | Notes |
|---|---|---|---|---|
| 23 | `Studios` | RENAME | `studios` | New UUID `id`; keep legacy `studio_no` SMALLINT for import; printers/paths kept |
| 24 | `StudiosDefault` | KEEP | `studio_defaults` | 1:1 with studios |
| 25 | `Schools` | RENAME | `schools` | FK `studio_id`; appointment-card text fields kept |
| 26 | `Schools (deleted records)` | DROP | — | Folded into `schools.deleted_at` |
| 27 | `Users` | SPLIT | `profiles` + `user_roles` | Auth via Lovable Cloud; never store password column; roles in separate table per security rule |
| 28 | `AccessLevels` | RENAME | `access_levels` | Lookup |
| 29 | `Photographers` | KEEP | `photographers` | Has PK |
| 30 | `PhotographerBreaks` | KEEP | `photographer_breaks` | FK `photographer_id` |

### 2.4 Scheduling

| # | Access table | Action | Target | Notes |
|---|---|---|---|---|
| 31 | `BlockedTimes` | KEEP | `blocked_times` | FK `studio_id` |
| 32 | `OffDays` | KEEP | `off_days` | FK `studio_id` |
| 33 | `DayLabels` + `LabeledDays` | KEEP | `day_labels`, `labeled_days` | Lookup pair |
| 34 | `Events` | KEEP | `events` | Standalone |
| 35 | `ShootList` | KEEP | `shoot_list` | |

### 2.5 Lookups / lists

| # | Access table | Action | Target | Notes |
|---|---|---|---|---|
| 36 | `Lists` | KEEP | `lists` | 7,134 rows — seed migration |
| 37 | `CustomerLists` + `CustomerListData` | KEEP | `customer_lists`, `customer_list_data` | |
| 38 | `Background`, `BoysAttire`, `GirlsAttire`, `Colors`, `IDSymbols` | KEEP (5 tables) | `bg_options`, `boys_attire`, `girls_attire`, `colors`, `id_symbols` | Pure lookups |
| 39 | `ResitReasons`, `RetouchStatus`, `Retouchers`, `PrintingLabs`, `ProcessSteps`, `Reports` | KEEP (6 tables) | snake_case equivalents | Pure lookups |
| 40 | `EmailSetups` | KEEP | `email_setups` | |
| 41 | `SystemSettings` | KEEP | `system_settings` | Key/value |

### 2.6 Templates / overlays (DEFER until UI phase)

| # | Access tables | Action | Notes |
|---|---|---|---|
| 42 | `Std*` family (`StdNodes`, `StdOverlayTemplates*`, `StdSportsMatesTemplates*`, `StdPackages*`, `StdTemplates`) | DEFER | 16 tables — overlay/template engine. Migrate in Phase 8 once UI requirements are pinned. |
| 43 | `Ox*` family (`OxFileSetDefXML`, `OxTemplates`, `OxTemplatesAttXML`, `tmpOxTemplatesAttXML`) | DEFER | XML payloads — likely move to Storage bucket `templates/` with metadata row |

### 2.7 Actions / audit

| # | Access table | Action | Target | Notes |
|---|---|---|---|---|
| 44 | `Actions` | KEEP | `actions` | FK `order_id` |
| 45 | `ActionItems` | KEEP | `action_items` | |
| 46 | `ActionsMissing` | MERGE | `actions` | Add `is_missing BOOLEAN` |
| 47 | `Actions (deleted records) 2`, `… 21` | DROP | — | Shadows |
| 48 | `TrackCustomerChanges`, `TrackStaticTableChanges` | KEEP | `audit_customer_changes`, `audit_static_table_changes` | Useful for sync conflict diagnostics |

### 2.8 E-commerce / import

| # | Access table | Action | Target | Notes |
|---|---|---|---|---|
| 49 | `ECommImportFiles`, `ECommLists` | KEEP | `ecomm_import_files`, `ecomm_lists` | |
| 50 | `SimplePhotoImportFiles`, `SimplePhotoLists`, `SimplePhotoXMLLists` | KEEP | `simple_photo_*` | |
| 51 | `CustSchID`, `CustSchID1` | MERGE | `customer_school_xref` | Pick later one as authoritative |

### 2.9 Drop list (no migration)

| Pattern | Tables | Reason |
|---|---|---|
| Access bookkeeping | `Name AutoCorrect Save Failures`, `Paste Errors` | Access UI artifacts |
| Temp / scratch | `Temp_*` (8 tables), `temp_*` (1), `tmp*` (4) | Report scratchpads |
| Missing shadows | `OrdersMissing`, `OrderPaymentsMissing`, `PoseOrdersMissing` | Reconstruct via FK checks instead |
| Deleted shadows | All `… (deleted records)…` variants | Replaced by `deleted_at` |
| Duplicate XRef | `CustSchID1` after merge | See row 51 |

---

## 3. Canonical field mappings — critical tables

### `customers`
| Postgres column | Type | Source | Rule |
|---|---|---|---|
| `id` | `BIGSERIAL PK` | new | — |
| `legacy_customer_id` | `INTEGER UNIQUE` | `customerid` | required for FK reconciliation |
| `school_id` | `UUID FK schools(id)` | `schoolid` via lookup | |
| `studio_id` | `UUID FK studios(id) NOT NULL` | derived (school → studio) | tenant |
| `first_name`, `last_name` | `TEXT` | `coalesce(firstname, s_firstname)` etc. | trim, NULL if empty |
| `short_first`, `short_last` | `VARCHAR(4)` | `s_firstname/s_lastname` | preserved for legacy reports |
| `gender` | `CHAR(1)` | `gender` | check (`'M','F','X',NULL`) |
| `address`, `city`, `state`, `zip`, `phone`, `email`, `notes` | TEXT | direct | |
| `student_id` | `TEXT` | `studentid` | |
| `co_customer_id` | `INTEGER` | `cocustomerid` | re-cast from VARCHAR(50) where numeric |
| `season` | `TEXT` | `season` | |
| `photographed` | `BOOLEAN DEFAULT false` | `photographed` | |
| `misc1`,`misc2`,`misc3` | `TEXT` | direct | |
| `current_status` | `SMALLINT FK session_statuses` | `currentstatus` | |
| `legacy_rowversion` | `INTEGER` | `update` | sync cursor |
| `created_at`, `updated_at` | `TIMESTAMPTZ` | best-of(`datedeleted`, `update`) → fallback `now()` | |
| `deleted_at` | `TIMESTAMPTZ` | iff `deleted=true` then `datedeleted` | partial idx |
| `deleted_by` | `BIGINT FK profiles(id)` | `deletedby` | |

Indexes: `(studio_id, last_name, first_name)`, `(school_id)`, `(legacy_customer_id)`, partial `WHERE deleted_at IS NULL`.

### `sessions`
PK `id BIGSERIAL`; UNIQUE `(legacy_customer_id, session_number)`; FK `customer_id`, `studio_id`, `photographer_id`, `user_id`. Money cols `NUMERIC(15,2)`. `session_number TEXT`. Drop `update` → `legacy_rowversion`. Strip nothing else.

### `image_properties`
PK `(customer_id, session_number, pose)`; FK `customer_id`. Path columns become Storage keys:
- `raw_path` → bucket `raw/{studio_id}/{customer_id}/{session_number}/{pose}.{ext}`
- `full_path` → bucket `full/...`
- `full_orig_path` → bucket `full-orig/...`
- `thumb_path` → bucket `thumb/...`

Dimensions `(width, height, thmb_width, thmb_height)` kept as INTEGER. `rotate180 BOOLEAN`, `rotate_step SMALLINT`. `include BOOLEAN DEFAULT true`.

### `pose_settings`
Composite PK `(customer_id, session_number, pose_no)`. All adjustments stay INTEGER/SMALLINT; non-destructive — applied by Edge Function at export time.

### `orders` + `order_details`
- `orders.id BIGSERIAL`, UNIQUE `(studio_id, order_number)`; strip web-order card fields; `order_total NUMERIC(15,2)`.
- `order_details.id BIGSERIAL`, FK `order_id`. Add CHECK `units >= 0`, `line_total = units * unit_cost * (1 - discount)` (computed column).

### `pose_orders`
Composite PK `(customer_id, session_number, pose_no)`. Quantity columns (`qty1..qty10`, `temp8..temp10`) preserved for legacy parity but flagged as **migration-only**; new UI should write to a normalized `pose_order_lines(pose_order_id, slot, qty)` table — added in Phase 8 once UI confirms slot semantics.

### `studios`
- `id UUID PK DEFAULT gen_random_uuid()`
- `legacy_studio_no SMALLINT UNIQUE NOT NULL` (replaces every `studio SMALLINT` FK during import)
- All path/printer columns kept verbatim for satellite-mode parity
- `salestaxrate REAL`
- New: `storage_bucket_prefix TEXT NOT NULL` (default = `studio-{legacy_studio_no}`)

### `schools`
- `id UUID PK`, `legacy_school_id INTEGER UNIQUE`
- FK `studio_id UUID NOT NULL`
- `school_path TEXT` kept for legacy resolution; new uploads use `storage_bucket_prefix`

### `profiles` + `user_roles`
Per security rule, roles never live on `profiles`.
```
profiles(id UUID PK = auth.users.id, login TEXT UNIQUE, first_name, last_name, studio_id UUID, created_at)
user_roles(id UUID PK, user_id UUID FK auth.users(id) ON DELETE CASCADE, role app_role NOT NULL, UNIQUE(user_id, role))
```
SECURITY DEFINER fns: `has_role(uuid, app_role)`, `has_studio_access(uuid, uuid)`.

---

## 4. Open questions (resolved before Phase 3 migration)

1. **Multi-studio user mapping** — confirm whether a user belongs to exactly one studio (`profiles.studio_id`) or many (`user_studios` bridge). Default plan: bridge table.
2. **`PoseOrders.qty1..qty10` semantics** — need legend from VBA forms before normalizing.
3. **`Std*` overlay XML payloads** — confirm size; if >100 KB each, move payload to Storage and keep only metadata in DB.
4. **`OxTemplates` retention** — keep or rebuild from scratch in the new UI.

---

## 5. Maintenance protocol

- Every schema change ships in `supabase/migrations/<ts>_<change>.sql`.
- The same PR updates this file: bump version (patch=column tweak, minor=table add/remove, major=convention change), update `Last Updated`, and append an Audit Trail line in `BUILD_PLAN.md`.
- The `/build-plan` page renders `BUILD_PLAN.md` directly — no separate sync step.
