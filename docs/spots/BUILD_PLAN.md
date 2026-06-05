# SPOTS 2027 — Build Plan

Version: 0.2.0
Last Updated: 2026-06-05

Legend — Status: `todo` | `in-progress` | `done` | `blocked` · Owner: `Lovable` | `User` | `Both` · Tags: `[dep]` dependency-linked (sorted first), `[del]` deliverable (sorted last).

---

## Phase 1 — Data Model

- [x] **[dep]** Canonical schema document — `docs/spots/SCHEMA.md` · Owner: Lovable · Status: done · QA: open file; every Access table maps to a Postgres table with type corrections noted (name coalescing, `sessionnumber` text, payment cols stripped).
- [x] **[dep]** Entity map — `docs/spots/ENTITIES.md` · Owner: Lovable · Status: done · QA: open file; ASCII diagrams grouped by domain (Tenant / Customer-Session-Image / Orders / Scheduling / Pipeline / Lookups / Audit / Deferred).
- [x] **[dep]** Reference DDL exported — `/mnt/documents/SPOTS2027_schema.sql` · Owner: Lovable · Status: done · QA: file exists, opens, contains all 114 mapped tables.
- [x] **[del]** This Build Plan published in-repo + rendered at `/build-plan` · Owner: Lovable · Status: done · QA: file visible in GitHub repo (`tfpdotnyc/cs-spots-rebuild`) and live at `/build-plan` route.

## Phase 2 — VBA Reverse Engineering

- [ ] **[dep]** Extraction checklist — `docs/spots/VBA_REVERSE_ENGINEERING.md` · Owner: Lovable · Status: todo · QA: open file; steps for exporting `.bas/.cls/.frm`, queries, macros from Access on Windows are numbered and reproducible.
- [ ] **[dep]** User exports VBA modules + uploads — Owner: User · Status: blocked · QA: zip received containing at least one `.bas` per module listed in the MDB inventory.
- [ ] **[del]** Per-module logic summary — `docs/spots/vba/SUMMARY.md` · Owner: Lovable · Status: todo · QA: every module has Inputs / Outputs / Side-effects / Postgres-equivalent rows.

## Phase 3 — Lovable Cloud Migration

- [ ] **[dep]** Enable Lovable Cloud · Owner: Both · Status: todo · QA: Cloud panel shows project provisioned.
- [ ] **[dep]** Core migration `supabase/migrations/<ts>_spots_core.sql` (tables, GRANTs, RLS, `user_studios`, `has_studio_access`) · Owner: Lovable · Status: todo · QA: migration applies cleanly; `\dt public.*` lists every expected table.
- [ ] **[dep]** Lookup seed migration · Owner: Lovable · Status: todo · QA: `Lists` row count matches MDB (7,134).
- [ ] **[del]** Migration verification report — `docs/spots/imports/migration-verify.md` · Owner: Lovable · Status: todo · QA: row-count table source vs target, all green.

## Phase 4 — Data Import

- [ ] **[dep]** Importer script `scripts/import-mdb.ts` (mdb-export → COPY, name coalesce, email normalize, strip card data, studio→UUID) · Owner: Lovable · Status: todo · QA: dry-run on sample MDB writes to staging schema with zero errors.
- [ ] **[del]** Import report — `docs/spots/imports/<date>.md` · Owner: Lovable · Status: todo · QA: report shows rows-in / rows-out / rejects per table.

## Phase 5 — Image-Link Audit

- [ ] **[dep]** Path verifier `scripts/verify-image-paths.ts` · Owner: Lovable · Status: todo · QA: script runs against a sample studio path and emits CSV.
- [ ] **[del]** Audit CSV + cost recalculation — `docs/spots/imports/image-audit.csv` · Owner: Lovable · Status: todo · QA: counts of existing / missing / orphan; total GB; finalized Storage $ figure.

## Phase 6 — Storage & Image Pipeline

- [ ] **[dep]** Buckets created (`raw`, `full`, `thumb`, `export`) · Owner: Lovable · Status: todo · QA: buckets visible in Cloud → Storage with correct public/private flags.
- [ ] **[dep]** Edge Function: derivative generator driven by `default_exportimagesdata` presets · Owner: Lovable · Status: todo · QA: POST a sample image returns all preset sizes.
- [ ] **[del]** Batch uploader + signed-URL exporter scripts · Owner: Lovable · Status: todo · QA: 100-image dry run lands files in correct bucket paths.

## Phase 7 — Offline Satellite (Electron)

- [ ] **[dep]** Local SQLite schema mirror · Owner: Lovable · Status: todo · QA: schema diff against Postgres = 0 differences.
- [ ] **[dep]** Sync queue (`device_id`, `legacy_rowversion`/`updated_at` cursor) · Owner: Lovable · Status: todo · QA: round-trip insert on laptop appears in HQ DB after sync.
- [ ] **[dep]** Conflict resolution UI · Owner: Lovable · Status: todo · QA: forced conflict surfaces both versions with chooser.
- [ ] **[del]** Packaged Electron installer + sample-school round-trip test · Owner: Lovable · Status: todo · QA: installer runs on Win/Mac; sample school syncs both directions cleanly.

## Phase 8 — Web UI

- [ ] **[dep]** Auth (Lovable Cloud) + studio selector · Owner: Lovable · Status: todo · QA: login restricts visible studios per `user_studios`.
- [ ] **[dep]** Media library (grid, search, bulk select) · Owner: Lovable · Status: todo · QA: 1k-image fixture renders ≤2s; search filters live.
- [ ] **[dep]** Order / Session / Customer screens bound to verified schema · Owner: Lovable · Status: todo · QA: each screen CRUD covered by a screenshot in `docs/spots/qa/`.
- [ ] **[del]** Visual QA pack — `docs/spots/qa/` · Owner: Both · Status: todo · QA: screenshot per screen, signed-off date in filename.

## Phase 9 — Ops & Cutover

- [ ] **[dep]** Backup / restore runbook — `docs/spots/ops/RUNBOOK.md` · Owner: Lovable · Status: todo · QA: dry-run restore on staging succeeds.
- [ ] **[dep]** Cost dashboard · Owner: Lovable · Status: todo · QA: live numbers for Storage GB, egress, DB rows.
- [ ] **[del]** Go-live sign-off — `docs/spots/ops/SIGNOFF.md` · Owner: User · Status: todo · QA: signed + dated by stakeholder.

---

## Audit Trail

Executed steps captured from chat history through 2026-06-05:

1. 2026-06-05 — Discussed reference-heavy MDB with ~250k image links and varied export sizes. Outcome: confirmed scope of replacement system.
2. 2026-06-05 — Estimated Supabase Storage cost. Outcome: $44–$120/mo working range pending image audit.
3. 2026-06-05 — Evaluated offline "satellite" field mode. Outcome: Electron recommended over PWA (filesystem + storage limits).
4. 2026-06-05 — Sketched sync engine. Outcome: local SQLite/IndexedDB + sync queue + `device_id`/`updated_at` conflict resolution.
5. 2026-06-05 — Summarized full project scope (Access → Supabase + Electron satellites). Outcome: shared mental model with user.
6. 2026-06-05 — User uploaded `SPOTS2027.MDB`. Outcome: schema extracted via `mdb-tools`.
7. 2026-06-05 — Inventoried 114 tables. Outcome: template confirmed empty (Sessions/Orders/ImageProperties = 0); lookups populated (Customers 4,263; Appointments 3,888; Lists 7,134; Studios 177; Schools 144).
8. 2026-06-05 — Verified image model: `imageproperties(customerid, sessionnumber, pose, rawname, fullname, fullnameorg, thmbname, …)` + `posesettings` for non-destructive edits; roots in `studios.spotspath` / `schools.schoolpath`. Outcome: storage-bucket layout decided.
9. 2026-06-05 — Blocker identified: VBA / Forms / Reports / Queries are not extractable from `.mdb` without Microsoft Access. Outcome: Phase 2 marked blocked-on-user.
10. 2026-06-05 — Full Postgres DDL exported to `/mnt/documents/SPOTS2027_schema.sql`. Outcome: reference DDL committed as Phase 1 dependency.
11. 2026-06-05 — Created this Build Plan + `build-plan-tracker` skill. Outcome: living QA artifact + repeatable process in place.
12. 2026-06-05 — Connected GitHub repo `tfpdotnyc/cs-spots-rebuild` on `main`. Outcome: auto-sync of all repo files confirmed via Project Settings → Git.
13. 2026-06-05 — Shipped in-app Build Plan page at `/build-plan` rendering `docs/spots/BUILD_PLAN.md` as single source of truth. Outcome: zero-drift visual QA surface.
14. 2026-06-05 — Phase 1 deliverables published: `docs/spots/SCHEMA.md` v0.1.0 (114-table inventory, conventions, critical-table field mappings, open questions) and `docs/spots/ENTITIES.md` v0.1.0 (8 grouped ASCII diagrams). Outcome: Phase 1 closed; ready for Phase 2 (VBA reverse-engineering checklist) and Phase 3 (Lovable Cloud enable).
15. 2026-06-05 — Workspace move + GitHub reconnect. Sync probe appended to verify `main` branch round-trip after re-authorization.
