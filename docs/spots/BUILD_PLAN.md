# SPOTS 2027 — Build Plan

Version: 0.5.0
Last Updated: 2026-06-10

> **Auth model:** This app is embedded inside a host website that owns authentication. SPOTS does NOT ship its own login UI. The host site is responsible for establishing a Supabase session (JWT) and forwarding it to the embed; SPOTS only consumes `auth.uid()` for RLS. All "Auth (login/signup)" deliverables are therefore out of scope; studio scoping still flows through `user_studios` + `has_studio_access()`.

Legend — Status: `todo` | `in-progress` | `done` | `blocked` · Owner: `Lovable` | `User` | `Both` · Tags: `[dep]` dependency-linked (sorted first), `[del]` deliverable (sorted last).

---

## Phase 1 — Data Model

- [x] **[dep]** Canonical schema document — `docs/spots/SCHEMA.md` · Owner: Lovable · Status: done · QA: open file; every Access table maps to a Postgres table with type corrections noted (name coalescing, `sessionnumber` text, payment cols stripped).
- [x] **[dep]** Entity map — `docs/spots/ENTITIES.md` · Owner: Lovable · Status: done · QA: open file; ASCII diagrams grouped by domain (Tenant / Customer-Session-Image / Orders / Scheduling / Pipeline / Lookups / Audit / Deferred).
- [x] **[dep]** Reference DDL exported — `/mnt/documents/SPOTS2027_schema.sql` · Owner: Lovable · Status: done · QA: file exists, opens, contains all 114 mapped tables.
- [x] **[del]** This Build Plan published in-repo + rendered at `/build-plan` · Owner: Lovable · Status: done · QA: file visible in GitHub repo (`tfpdotnyc/cs-spots-rebuild`) and live at `/build-plan` route.

## Phase 2 — SPOTS Read Model (pivoted from full VBA clone)

Goal: read what SPOTS produces and describe what it does — not duplicate it. Missing business logic is reconstructed via the Open Questions quiz, not by recovering every line of VBA.

- [x] **[dep]** Extraction checklist — `docs/spots/VBA_REVERSE_ENGINEERING.md` v0.2.0 · Owner: Lovable · Status: done · QA: hardened `_Safe` macros, Trust-access fix, Troubleshooting table, pivot note.
- [x] **[dep]** Saved queries exported — `queries\*.sql` · Owner: User · Status: done.
- [x] **[dep]** VBA modules exported (best-effort) — `vba\` 4 components, `Protection=0` · Owner: User · Status: done · Note: front-end carries little standalone VBA; logic lives in form/report code-behind captured by Step 4.
- [x] **[dep]** Forms/Reports/Macros `SaveAsText` dump — Owner: User · Status: done (superseded) · Note: COM SaveAsText returned 0 forms (`80070520` logon-session error). Superseded by Database Documenter PDF (`export/meta/documenter.pdf`, 8.2 MB) which dumps every form/report control + bound field + event-procedure name — sufficient for the read model.
- [x] **[dep]** Main-screen anchor uploaded — `spots_main_screen.JPG` · Owner: User · Status: done · QA: locks Phase 2 read model to 14 in-scope tables out of 114.
- [x] **[del]** Inventory — `docs/spots/vba/INVENTORY.md` · Owner: Lovable · Status: done · QA: counts + named list of every artifact (114 tables, 347 queries, 4 modules, 2 reports, 0 forms-via-COM).
- [x] **[del]** Read model — `docs/spots/vba/READ_MODEL.md` · Owner: Lovable · Status: done · QA: every main-screen button has reads/writes/derived values mapped.
- [x] **[del]** Query map — `docs/spots/vba/QUERY_MAP.md` · Owner: Lovable · Status: done · QA: all 347 queries flagged keep/rebuild/deprecate, grouped by domain.
- [ ] **[del]** Open questions quiz — `docs/spots/vba/OPEN_QUESTIONS.md` · Owner: Both · Status: in-progress · QA: every numbered question answered inline by user. Sections A.2 (Misc1/2/3) and C.1 (Order Status state machine) are gating Phase 3 final migration.

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

- [x] **[dep]** Landing surface — main screen scaffold at `/` mirroring SPOTS three-panel layout (Customer Info / Session Overview / Order Overview) · Owner: Lovable · Status: done · QA: page renders at `/` with all three panels visible.
- [ ] ~~Auth (login UI)~~ — **out of scope.** Host site provides the Supabase session. SPOTS reads `auth.uid()` only.
- [ ] **[dep]** Studio selector (reads `user_studios` for current session) · Owner: Lovable · Status: todo · QA: dropdown lists only studios the JWT can access.
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
16. 2026-06-10 — Hardened VBA export macros (`ExportAllVBA_Safe`, `ExportAllQueries_Safe`, `ExportFormsReportsMacros_Safe`). Diagnosed compile errors (missing DAO ref), silent loops (Trust access to VBProject disabled), and password-locked-project fallback. Checklist bumped to v0.2.0 with Troubleshooting table and Required Trust Center subsection. Queries exported; VBA export returned 4 components at `Protection=0`.
17. 2026-06-10 — **Strategy pivot**: Phase 2 reframed from "clone SPOTS feature-for-feature" to "read what it produces + describe what it does". Full VBA recovery declared out of scope. New Phase 2 deliverables: `INVENTORY.md`, `READ_MODEL.md`, `QUERY_MAP.md`, `OPEN_QUESTIONS.md`. Per-module `SUMMARY.md` retired. Phase 3 (Cloud enable) cleared to start in parallel with Phase 2 quiz cycle.
18. 2026-06-10 — Codex/PowerShell export ingested from `tfpdotnyc/cs-spots-rebuild` → `export/`: 347 saved queries, 4 standard modules, Database Documenter PDF (8.2 MB), inventory JSON. Forms-via-COM returned 0 (`80070520` logon-session error) and was declared **superseded by the Documenter PDF**, which provides the structural dump needed for the read model. Authoritative Postgres DDL replaced at `/mnt/documents/SPOTS2027_schema.sql` from user-supplied `SPOTS2027_Schema_PostgreSQL_with_indexes.sql` (2,295 lines).
19. 2026-06-10 — Phase 2 deliverables shipped: `docs/spots/vba/INVENTORY.md`, `READ_MODEL.md` (anchored to `spots_main_screen.JPG` — 14 in-scope tables out of 114), `QUERY_MAP.md` (347 queries classified keep/rebuild/deprecate by domain), `OPEN_QUESTIONS.md` (quiz pending user answers; A.2 Misc1/2/3 and C.1 Order Status state machine flagged as gating Phase 3 final migration). Build Plan bumped to v0.4.0. Phase 3 (Lovable Cloud enable + core migration) unblocked to start.
