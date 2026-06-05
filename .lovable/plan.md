# SPOTS 2027 — Schema Verification, Migration Scaffold & Living Build Plan

Version: 0.2.0 (plan-level)

## What changed in this revision
Adds a **parallel, human-readable Build Plan artifact** that lives in-repo (so it syncs to GitHub automatically via Lovable's GitHub integration) and is updated at the end of every phase. Adds a reusable **skill** so this process can be invoked on any future build with one command.

---

## Deliverable A — The Build Plan artifact (new)

**File:** `docs/spots/BUILD_PLAN.md` (markdown, no header/footer crosslinks, plain titles only).

**Format rules (locked):**
- Title block: project name, plan version (semver, bumped on every edit), last-updated date.
- One H2 per **phase**, ordered by **system-group** (Data Model → Migration → Storage → Sync → UI → Ops).
- Inside each phase: items sorted **dependency-linked first**, **deliverable items last**.
- Every item is a checkbox with: `status` (todo / in-progress / done / blocked), `owner` (Lovable / User / Both), and a one-line `QA check` describing how a human visually verifies it.
- An "Audit Trail" H2 at the bottom listing every executed step from chat history, with date and outcome.
- No nav links, no breadcrumbs in the doc itself — the doc *is* the breadcrumb.

**Audit Trail seed (from this chat so far):**
1. Discussed reference-heavy MDB with 250k image links and varied export sizes.
2. Estimated Supabase Storage cost ($44–$120/mo range).
3. Evaluated offline "satellite" field mode → Electron recommended over PWA.
4. Sketched sync engine: local SQLite/IndexedDB + sync queue + `device_id`/`updated_at` conflict resolution.
5. Summarized full project scope (Access → Supabase + Electron satellites).
6. User uploaded `SPOTS2027.MDB`; extracted schema via mdb-tools.
7. Inventoried 114 tables, confirmed empty template (Sessions/Orders/ImageProperties = 0 rows), populated lookups (Customers 4263, Appointments 3888, Lists 7134, Studios 177, Schools 144).
8. Verified image model: `imageproperties(customerid, sessionnumber, pose, rawname, fullname, fullnameorg, thmbname, …)` + `posesettings` for non-destructive edits; root paths from `studios.spotspath` and `schools.schoolpath`.
9. Identified blockers: VBA / Forms / Reports / Queries are NOT extractable from `.mdb` without Microsoft Access.
10. Saved full Postgres DDL to `/mnt/documents/SPOTS2027_schema.sql`.

**Phase skeleton (initial; will grow):**

- **Phase 1 — Data Model (verified)**
  - [dep] Canonical schema doc `docs/spots/SCHEMA.md`
  - [dep] Entity map `docs/spots/ENTITIES.md`
  - [del] `BUILD_PLAN.md` published and committed to GitHub
- **Phase 2 — VBA Reverse Engineering (user-blocked)**
  - [dep] Checklist `docs/spots/VBA_REVERSE_ENGINEERING.md`
  - [dep] User exports `.bas/.cls/.frm` on Windows + uploads
  - [del] Per-module logic summary doc
- **Phase 3 — Lovable Cloud Migration**
  - [dep] Enable Lovable Cloud
  - [dep] `supabase/migrations/<ts>_spots_core.sql` (tables, GRANTs, RLS, `user_studios` mapping, `has_studio_access` SECURITY DEFINER)
  - [dep] Lookup seed migration
  - [del] Verified migration applied; row counts match expected per table
- **Phase 4 — Data Import**
  - [dep] `scripts/import-mdb.ts` (mdb-export → COPY)
  - [dep] Name coalescing, email normalization, card-data stripping, `studio` → tenant UUID
  - [del] Import report (rows in vs. rows out) committed under `docs/spots/imports/`
- **Phase 5 — Image-link Audit (no upload yet)**
  - [dep] `scripts/verify-image-paths.ts`
  - [del] CSV report: existing / missing / orphan; total GB; finalized Storage cost
- **Phase 6 — Storage & Image Pipeline**
  - [dep] Supabase Storage buckets (raw / full / thumb / export)
  - [dep] Edge Function: derivative generator (sizes for export presets from `default_exportimagesdata`)
  - [del] Batch uploader script + signed-URL exporter
- **Phase 7 — Offline Satellite (Electron)**
  - [dep] Local SQLite schema mirror
  - [dep] Sync queue with `device_id` + `legacy_rowversion`/`updated_at` cursor
  - [dep] Conflict resolution UI
  - [del] Packaged installer; round-trip sync test with sample school
- **Phase 8 — Web UI**
  - [dep] Auth (Lovable Cloud) + studio selector
  - [dep] Media library (grid, search, bulk select)
  - [dep] Order/session/customer screens mapped to verified schema
  - [del] Visual QA pass on each screen (screenshots into `docs/spots/qa/`)
- **Phase 9 — Ops & Cutover**
  - [dep] Backup/restore runbook
  - [dep] Cost dashboard
  - [del] Sign-off doc

**GitHub backup:** because `docs/spots/BUILD_PLAN.md` lives inside the project, any Lovable edit auto-pushes to the connected GitHub repo. If GitHub is not yet connected, the build-mode follow-up will prompt the user via the Plus (+) → GitHub flow.

---

## Deliverable B — Reusable Skill

**Path:** `.agents/skills/build-plan-tracker/SKILL.md`, then activated with `skills--apply_draft`.

**Trigger phrases (description):** "create a build plan", "track this build", "skillify the build-plan process", "add breadcrumbs for QA".

**What the skill encodes:**
- The locked format rules above (phase H2s, system-group ordering, dep-first / del-last, status + owner + QA-check on every item, audit trail at bottom, no header/footer crosslinks, semver version bump on every write).
- The audit step: scan chat history with `chat_search` tools to seed the Audit Trail.
- The GitHub-sync expectation (file lives in `docs/<project>/BUILD_PLAN.md`).
- A `references/template.md` skeleton that any future project can copy.
- Update protocol: on every phase status change, bump patch version; on adding a phase, bump minor; on restructure, bump major.

---

## Deliverable C — Original schema work (carried forward unchanged)
- `docs/spots/SCHEMA.md` — column-by-column Access→Postgres mapping with the corrections from the verified DDL (name coalescing, `sessionnumber` as text, payment-column stripping, soft-delete normalization, drop of `Temp_*` and `(deleted records)` shadows).
- `docs/spots/ENTITIES.md` — grouped ASCII entity maps.
- `docs/spots/VBA_REVERSE_ENGINEERING.md` — Windows-side extraction checklist.
- `supabase/migrations/<ts>_spots_core.sql` — tables, GRANTs, RLS, `user_studios` + `has_studio_access`.
- `scripts/import-mdb.ts`, `scripts/verify-image-paths.ts`.
- `/mnt/documents/SPOTS2027_schema.sql` already produced as reference.

---

## Order of operations when switched to build mode
1. Create `docs/spots/BUILD_PLAN.md` with the seeded audit trail and Phase 1–9 skeleton above. Commit (auto-syncs to GitHub if connected; otherwise prompt user to connect).
2. Author and apply the `build-plan-tracker` skill.
3. Produce `SCHEMA.md`, `ENTITIES.md`, `VBA_REVERSE_ENGINEERING.md`.
4. Stop and wait for user to (a) confirm GitHub connection, (b) start VBA export on a Windows box, (c) approve Phase 3 (Lovable Cloud enable + first migration).

## Out of scope for this phase
No UI, no Electron, no Storage uploads, no VBA reimplementation, no payment-data migration.
