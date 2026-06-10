# SPOTS — Read Model (Main Screen)

Version: 0.1.0
Last Updated: 2026-06-10
Anchor: `spots_main_screen.JPG` + Database Documenter PDF (`export/meta/documenter.pdf`)
Convention: table names are the Postgres targets from `docs/spots/SCHEMA.md`. Source Access tables in parens where the name differs. Every write-side row also stamps `studio_id`, `updated_at`, and `legacy_rowversion`.

---

## Customer Information panel

**Reads:** `customers`, `schools`, `studios`, `appointments` (next upcoming for this customer)
**Writes:** `customers` (edit), `audit_customer_changes` (delta row per save)
**Derived:** "NYC College of Technology — Class of 2025-2026" header = `schools.name` + `schools.classof`; customer counter at top-left = `count(*) over (...)` within the current navigation set; Total Customers footer = `count(*) from customers where studio_id = current`.

### Action bar

| Button             | Reads                                    | Writes                                                              | Notes |
|--------------------|------------------------------------------|---------------------------------------------------------------------|-------|
| Appointment        | `appointments`                           | `appointments` (create/edit)                                        | Shows "No Appointments Scheduled" when none in future. |
| Add Student        | `schools`, `studios`                     | `customers` (insert), `audit_customer_changes`                      | Allocates next customer # (8-digit, sequential per studio). |
| Transfer Student   | `customers`, `schools`                   | `customers.school_id` (update), `audit_customer_changes`            | Moves customer to a different school/class. |
| Order Overview     | `orders`, `orderdetails`, `orderpayments`| —                                                                   | Read-only summary modal for this customer. |
| Import Images      | `studios.spotspath`, `schools.schoolpath`| `imageproperties` (insert per pose), `posesettings` (default row)   | File system → DB row; pose strip populates after. |
| Print Proofs       | `imageproperties`, `posesettings`        | `actions` (audit row: action=PrintProofs)                           | See Open Question §A.5. |
| Proof Book         | `imageproperties`, `customers.proofbook_*` | `actions`                                                         | See Open Question §A.5. |
| Poses Ordered      | `pose_orders`, `orderdetails`            | —                                                                   | Read-only — shows which poses are on any order. |
| Refresh            | (re-runs current selects)                | —                                                                   | No-op write. |

## Pose strip (1..10 + Next/Prev/Full Page/YB Pose/Aux Pose + Overlay Text)

**Reads:** `imageproperties (customer_id, session_number, pose)`, `posesettings`, file storage keys (`raw/full/thumb`).
**Writes:** `customers.yb_pose` (YB Pose selector), `customers.aux_pose` (Aux Pose selector), `posesettings` (per-pose retouching/crop), `customers.overlay_text`.
**Derived:** thumbnail URL = `storage_bucket_prefix || thmbname`; "CHOOSE YB POSE" badge when `yb_pose IS NULL`.

## Customer fields block

| Field              | Source column                            | Notes |
|--------------------|------------------------------------------|-------|
| Last/First/Middle  | `customers.lastname/firstname/middlename`| Name coalescing rule applied on import. |
| Address1/City/State/Zip | `customers.address1/city/state/zip` | `1`/`2` radio selects which address line. |
| Phone / Cell1 / Cell2 | `customers.phone/cell1/cell2`         |  |
| Email 1/2/3        | `customers.email1/email2/email3`         | Email normalize on import. |
| Web PW             | `customers.webpw`                        | See Open Question §A.1. |
| Misc1/2/3          | `customers.misc1/2/3`                    | Active fields — semantics deferred to quiz (§A.2). |
| Overlay Text       | `customers.overlay_text`                 | See Open Question §A.3. |
| Company Customer # | `customers.company_customer_no`          |  |
| Grade              | `customers.grade`                        |  |
| Student ID 1/2     | `customers.student_id_1/2`               |  |
| # IDs Printed      | `customers.ids_printed_count`            | See Open Question §A.4. |
| Retake flag        | `customers.is_retake`                    |  |
| Proof Due Date     | `customers.proof_due_date`               |  |
| Proof Book Front/Back | `customers.proofbook_front/back`      | Dropdowns; values from `lists`. |
| Female/Male        | `customers.gender`                       |  |
| Clear              | (UI) — clears unsaved field edits        |  |
| Notes              | `customers.notes` (modal)                |  |
| Cust Log           | `audit_customer_changes` (modal)         | Read-only history. |
| Payment History    | `sessionpayments` ∪ `orderpayments`      | Read-only, ordered by date. |

## Session Overview grid

**Reads:** `sessions` joined to `users (photographer_id)` and `lists (session_type)`; aggregates from `sessionpayments` (Deposits, Balance Due) and `lists (session_statuses)` (Status).
**Row shape:** `# (sessionnumber) | Date | Session Type | Session By | Photographer | Deposits | Balance Due | Status`.

| Button              | Reads                       | Writes                                                   | Notes |
|---------------------|-----------------------------|----------------------------------------------------------|-------|
| Add Session         | `lists.session_types`       | `sessions` insert, `actions` (audit)                     |  |
| Edit                | `sessions`                  | `sessions` update, `actions`                             |  |
| Remove              | `sessions`                  | `sessions` soft-delete, `actions`                        | Cascades blocked by FK; see Open Question §B.1. |
| Session Detail      | `sessions`, `session_details` | `session_details` insert/update                        | Item-level session add-ons. |
| Proofs              | `imageproperties`           | `actions`                                                | Launches proof print path. |
| Print Receipt       | `sessions`, `sessionpayments` | `actions`                                              | Print template. |
| Session Payments    | `sessionpayments`           | `sessionpayments` insert (no card data)                  | Method = token only. |
| Appointment Deposit | `appointments`, `sessionpayments` | `sessionpayments` insert tagged as deposit         | See Open Question §B.2. |

## Order Overview grid

**Reads:** `orders` joined to `users (order_by)`, `studios (location)`; aggregates from `orderpayments`; `order_statuses` lookup; `lists.is_rush`.
**Row shape:** `# (orderid) | Date | Order Type | Order By | Location | Deposits | Balance Due | Status | Rush`.

| Button         | Reads                                | Writes                                                | Notes |
|----------------|--------------------------------------|-------------------------------------------------------|-------|
| Add Order      | `order_items`, `order_item_types`    | `orders`, `orderdetails`                              |  |
| Order Detail   | `orders`, `orderdetails`             | `orderdetails` upsert, `order_detail_comments`        | Package builder lives here. |
| Remove         | `orders`                             | `orders` soft-delete, `actions`                       |  |
| Order Status   | `lists.order_statuses`               | `orders.status`, `actions`                            | See Open Question §C.1 (state machine). |
| Reorders       | `orders`                             | new `orders` row with `parent_order_id`               | See Open Question §C.2. |
| Print Receipt  | `orders`, `orderpayments`            | `actions`                                             |  |
| Order Payments | `orderpayments`                      | `orderpayments` insert (no card data)                 | Method = token only. |
| Print ID Card  | `customers`, `imageproperties`       | `customers.ids_printed_count++`, `actions`            | See Open Question §C.3. |
| Customer Folder| `studios.spotspath` + customer path  | `actions`                                             | See Open Question §C.4. |

## Cross-cutting writes

Every action-bar / grid button that mutates state also writes one row to `actions` with:
`(orderid?, action, date=now(), userid=auth.uid(), studio, extraid?, update?, ybo, spotting, reprint, partial, pendingitem)`. This is the existing SPOTS audit trail and we preserve it as-is.

## Storage layout (Phase 6)

```text
raw/{studio_id}/{customer_id}/{sessionnumber}/{pose}.{ext}
full/{studio_id}/...
full-orig/{studio_id}/...
thumb/{studio_id}/...
```

Pose strip URLs and Print Proofs / Proof Book / Print ID Card all read from these buckets via signed URL.
