# Phase 2 — Pivot to "read the data, rebuild the logic"

Acknowledged: SPOTS is not being cloned. We need to **read what it produces** and **describe what it does** well enough to rebuild only what's still needed. Missing VBA is no longer a blocker.

## What we have

- `queries\` — all saved QueryDefs exported as `.sql` ✓
- `vba\` — 4 components exported (likely 2 standard modules + 2 form/report code-behinds). `Protection=0` confirms the project isn't locked; the small count means the front-end really does carry little standalone VBA. Most logic lives in **form/report event procedures**, which `SaveAsText` captures.
- `.mdb` — all 114 tables + data already mapped to Postgres

## What we still need (minimum)

1. **Step 4 — `SaveAsText` dump** of every Form, Report, and Macro → `forms\*.txt`, `reports\*.txt`, `macros\*.txt`. This is where the real business logic lives (event procedures embedded in the `.txt`).
2. **Step 5 — Screenshots** of the workflows you actually use day-to-day. Two views per object:
   - Design view (shows control names + bindings)
   - Runtime view with real data (shows what the user sees)
3. **Zip + upload** — even partial is fine; ship in chunks if easier.

## Screenshot scope (only what's in active use)

Focus on the **live workflows**, skip dead/legacy stuff. Likely candidates based on schema:

- **Customer / Session intake** — whatever form starts a new shoot
- **Image browse / tagging** — the screen where poses get reviewed
- **Order entry** — package selection, line items, totals
- **Order fulfillment / export** — how images get pushed to print/lab
- **Schedule / Appointments** — calendar view if used
- **Any report** routinely printed or emailed (order confirmations, lab sheets, school packets)

Anything you never open — skip it. If unsure, screenshot it; cheaper than re-asking.

## Plan of action

### D.1 — You: run Step 4 + screenshots
1. In a Standard Module, paste and run the `ExportFormsReportsMacros` macro from `docs/spots/VBA_REVERSE_ENGINEERING.md` §4. (Same DAO/late-bound fix pattern — wrap each `SaveAsText` in `On Error Resume Next` if any one form errors.)
2. Walk the nav pane. For every form/report you actually use, open in **Design** view → screenshot → open in **Form/Report** view with real data → screenshot. Save under `meta\screens\<name>-design.png` and `<name>-runtime.png`.
3. Zip `C:\spots-rev\export\` → drag `spots-vba-export.zip` into chat. If >20MB, split: `forms-reports.zip`, `screenshots-1.zip`, `screenshots-2.zip`, etc.

### D.2 — Lovable: ingest + produce read-only data map
On arrival I will:
1. Unpack to `/tmp/spots-vba/`.
2. Write `docs/spots/vba/INVENTORY.md` — counts + list of every form/report/macro/query found.
3. Write `docs/spots/vba/READ_MODEL.md` — for each active screen: **what tables it reads**, **what tables it writes**, **what derived values it computes**. This becomes the spec for the new read-only views and the rebuilt write paths.
4. Write `docs/spots/vba/QUERY_MAP.md` — every saved `.sql` → Postgres view / function / app query, flagged as `keep`, `rebuild`, or `deprecate`.
5. Write `docs/spots/vba/OPEN_QUESTIONS.md` — a numbered list of business rules I can't infer from screenshots + SaveAsText alone. **This is the quiz.** You answer inline; I fold answers back into the read model.
6. Bump `BUILD_PLAN.md` → v0.3.2, mark Phase 2 done, add audit entries #16 (export hardening) and #17 (pivot to read-the-data strategy).

### D.3 — Phase boundary
Phase 2 closes when `READ_MODEL.md` + `OPEN_QUESTIONS.md` exist and you've answered the quiz. **Phase 3 (Lovable Cloud enable + first migration) can start in parallel** as soon as you say go — it depends only on the Phase 1 schema, which is already done.

## Doc updates queued for build mode

- `VBA_REVERSE_ENGINEERING.md` → v0.2.0:
  - Add Trust-access subsection
  - Replace Step 2 macro with `ExportAllVBA_Safe` (hardened, multi-project, per-component error trap)
  - Add Step 4 hardened variant
  - Add Troubleshooting (silent loop, locked VBProject, DAO ref, folder missing)
  - Update Status table: Steps 2 & 3 = done; Steps 4 & 5 = in-progress; declare full-VBA-clone explicitly out of scope
- `BUILD_PLAN.md` → v0.3.2:
  - Reframe Phase 2 deliverable from "Per-module logic summary" to "Read model + open-questions quiz"
  - Audit entries #16, #17

---

**Ready when you are.** Run Step 4, take screenshots of the live workflows, zip and drop. I'll inventory on arrival and come back with the quiz.
