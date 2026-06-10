# SPOTS — Export Inventory

Version: 0.1.0
Last Updated: 2026-06-10
Source: `tfpdotnyc/cs-spots-rebuild` → `export/` (Codex PowerShell export, 2026-06-10)

---

## Counts

| Artifact            | Count | Location                                          | Notes |
|---------------------|------:|---------------------------------------------------|-------|
| Tables (Access)     | 114   | `docs/spots/SCHEMA.md` · `/mnt/documents/SPOTS2027_schema.sql` | Full DDL + index list — 2,295 lines |
| Saved queries       | 347   | `docs/spots/vba/queries/*.sql`                    | See `QUERY_MAP.md` |
| Standard modules    | 4     | `docs/spots/vba/modules/*.bas`                    | `Module1..3` + `SPOTSNEW_Module4` |
| Forms (via COM)     | 0     | —                                                 | COM auth blocked — recovered from Documenter PDF instead |
| Reports (via COM)   | 2     | (in Documenter PDF)                               | Names captured in Documenter dump |
| Macros              | 0     | —                                                 | None present in source MDB |
| Database Documenter | 1     | `export/meta/documenter.pdf` (GitHub, 8.2 MB)     | Every form, report, control, bound field, event-procedure name |
| References list     | 1     | `export/meta/references.png` (GitHub)             | VBE Tools → References screenshot |

> The COM-based `SaveAsText` step returned 0 forms (`80070520 — specified logon session does not exist`).
> This is **not a blocker**: the Database Documenter PDF contains the full structural dump of every form
> and report — control names, bound fields, formats, event-procedure names — which is what the read
> model needs. The actual VBA *body* of event procedures was not recovered, and per the Phase 2 pivot
> we do not need it.

## Modules

All 4 `.bas` files were exported at `Protection=0` (no password). Source folder also contains a
duplicate set prefixed `SPOTSNEW_*` — same content, different export pass. Treat `SPOTSNEW_Module4.bas`
as the canonical fourth module.

| File                    | Bytes |
|-------------------------|------:|
| `Module1.bas`           |   830 |
| `Module2.bas`           |   753 |
| `Module3.bas`           |   655 |
| `SPOTSNEW_Module4.bas`  | 1,200 |

Standard-module logic in this front-end is minimal — the bulk of business logic lives in form/report
code-behind, which we are not recovering. Where rules can't be inferred from the schema, queries, or
the main-screen workflow, they are listed in `OPEN_QUESTIONS.md` for the user to answer.

## Reports

Two reports are referenced by the Documenter dump. They are read-only print/email artifacts and will
be rebuilt as Postgres views + a React print template in Phase 8. Names and bound fields are pulled
from the Documenter PDF when those views are authored.

## Daily-use surface (anchor for the read model)

Per the main-screen screenshot (`spots_main_screen.JPG`):

- **Customer Information** panel — appointment bar + action bar (Add Student, Transfer Student,
  Order Overview, Import Images, Print Proofs, Proof Book, Poses Ordered, Refresh).
- **Pose strip 1..10** — Next/Prev/Full Page/YB Pose/Aux Pose, Overlay Text.
- **Customer fields** — name, address, phone, 3 emails, 2 cells, Web PW, Misc1/2/3, Middle Name,
  Student ID 1/2, # IDs Printed, Retake flag, Proof Due Date, Notes, Cust Log, Payment History.
- **Session Overview** grid — Add/Edit/Remove Session, Session Detail, Proofs, Print Receipt,
  Session Payments, Appointment Deposit.
- **Order Overview** grid — Add/Order Detail/Remove Order, Order Status, Reorders, Print Receipt,
  Order Payments, Print ID Card, Customer Folder.

These are the only screens the user interacts with daily. Every other 114-table corner of the source
MDB is secondary and follows the same read-model pattern when (and if) it surfaces.

## In-scope tables for Phase 3 core migration

~14 tables out of 114:

`customers`, `sessions`, `imageproperties`, `posesettings`, `appointments`, `orders`, `orderdetails`,
`orderpayments`, `sessionpayments`, `actions`, `schools`, `studios`, `lists`, `accesslevels`.

The remaining ~100 tables (deleted-records duplicates, `Std*`/`Ox*` template families, unused legacy
lookups) are deferred to Phase 8 or dropped after Open Questions confirms they're dead.

## Gaps

| Gap | Mitigation |
|-----|------------|
| Form/report VBA bodies | Out of scope per Phase 2 pivot. Behavior reconstructed via `OPEN_QUESTIONS.md`. |
| 0 forms via COM SaveAsText | Documenter PDF supplies the structural dump used by `READ_MODEL.md`. |
| Studio-specific query variants (`*JKB`, `*CONTINENTAL`) | Marked `deprecate` in `QUERY_MAP.md`; reporting is rebuilt once, tenant-aware. |
| `*_OLD`, `*_OLD2`, `*XXXX` | Marked `deprecate` — do not port. |
