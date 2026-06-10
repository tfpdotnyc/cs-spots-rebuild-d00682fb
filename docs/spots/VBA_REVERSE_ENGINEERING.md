# SPOTS 2027 — VBA Reverse Engineering Checklist

Version: 0.3.0
Last Updated: 2026-06-10
Status: **Done** — superseded by Codex/PowerShell export (2026-06-10). 347 queries + 4 modules + Documenter PDF extracted; forms-via-COM bypassed in favor of the Documenter dump. **Full VBA clone is explicitly out of scope** — see "Strategy pivot" below.

---

## Codex-based export (2026-06-10) — what actually worked

The hardened VBA macros below (Steps 2-4) ran successfully for queries and standard modules but were ultimately superseded by a PowerShell-driven export run from the user's workstation (committed to `tfpdotnyc/cs-spots-rebuild` under `export/`). That run produced:

- `export/queries/*.sql` — **347 saved queries**
- `export/modules/*.bas` + `export/vba/*.bas` — 4 unique standard modules (`Protection=0`)
- `export/meta/documenter.pdf` — full **Database Documenter** dump (8.2 MB): every form, report, control, bound field, format string, and event-procedure name
- `export/metadata/inventory.json` — structured object inventory
- `export/metadata/summary.txt` — `Queries: 347 · Forms: 0 · Reports: 2 · Modules: 4`

The `SaveAsText` step (Step 4 below) returned **0 forms** because the Access COM class factory failed with `0x80070520 — specified logon session does not exist`. This is a non-blocker: the Documenter PDF dumps the structural shape of every form and report (control names, bound fields, event-procedure names) and that's all the read model needs. The actual VBA *body* of event procedures is out of scope per the strategy pivot.

The macro-based path documented below remains valid as a fallback if a future MDB needs re-export on a workstation where the PowerShell tooling isn't installed.

---

## Strategy pivot (2026-06-10)

We are **not** rebuilding SPOTS feature-for-feature. The goals are:

1. **Read** the data SPOTS produces (already covered by the Postgres schema + import pipeline).
2. **Describe** the business logic well enough to rebuild what's still needed in the new app.
3. **Deprecate** workflows the user no longer uses.

Therefore: a partial VBA export is acceptable. `SaveAsText` (Step 4) + screenshots (Step 5) of the **live workflows** are sufficient. Missing event-procedure code can be reconstructed from the user's verbal walkthrough during the Open Questions quiz.

---

## Why this phase exists

`SPOTS2027.MDB` is a reference-rich Access app. The Postgres schema (Phase 1) covers **tables only**. Business logic lives in:

- **VBA modules** (`.bas`) — standard modules with shared functions/subs.
- **Class modules** (`.cls`) — object wrappers.
- **Form modules** (`.frm`) — UI event handlers (`Form_Load`, `cmd*_Click`, etc.).
- **Report modules** — print/export logic, often the source of derivative image presets and order paperwork.
- **Macros** — AutoExec, ribbon hooks, named macros invoked from forms.
- **Stored Queries** — saved `QueryDefs`. These often encode joins and filters that look like business rules.
- **References** — DAO/ADO/Outlook/Office/3rd-party COM libs. Each reference is a potential cutover blocker.

---

## Required environment

- Windows 10 or 11
- Microsoft Access (2016, 2019, 365). Runtime is **not** sufficient — full Access required for VBE export.
- A working copy of `SPOTS2027.MDB` (never the original)
- 7-Zip or similar (to zip the export folder)

### Required VBE References

Alt+F11 → **Tools → References** and tick:

- Visual Basic For Applications
- Microsoft Access xx.0 Object Library
- OLE Automation
- Microsoft Office xx.0 Access Database Engine Object Library (DAO)

Without DAO ticked, `DAO.QueryDef` and `CurrentDb` throw `Sub or Function not defined` at compile time.

### Required Trust Center setting (for Step 2 — VBA export)

File → Options → **Trust Center** → Trust Center Settings → **Macro Settings** → tick **"Trust access to the VBA project object model"** → OK → close and reopen the database. Without this, the `Application.VBE.VBProjects` loop runs silently and exports nothing.

### All macros below must live in a Standard Module

VBE → Insert → **Module** → paste → F5 to run, or call by name from the Immediate Window (Ctrl+G). Multi-line `Sub` definitions **cannot** be pasted into the Immediate Window directly.

---

## Extraction checklist

### 0. Prep

- [x] Copy `SPOTS2027.MDB` to `C:\spots-rev\SPOTS2027_WORK.MDB`. Work only on the copy.
- [x] Create export folder: `C:\spots-rev\export\` with subfolders `vba\`, `queries\`, `forms\`, `reports\`, `macros\`, `meta\`, `meta\screens\`.
- [x] Open the copy in Access. Enable content/macros if prompted.

### 1. Capture metadata

- [ ] Database Tools → **Database Documenter** → All object types → All → OK. Save as PDF to `meta\documenter.pdf`.
- [ ] File → Options → Current Database — screenshot startup form, AutoExec, ribbon settings to `meta\startup-settings.png`.
- [ ] VBE (Alt+F11) → Tools → References — screenshot full list to `meta\references.png`. Note non-standard libs (Outlook, Word, Excel, Scripting Runtime, FSO, ADO, custom DLLs).

### 2. Export VBA (hardened, multi-project)

```vba
Sub ExportAllVBA_Safe()
    Dim outDir As String : outDir = "C:\spots-rev\export\vba\"
    If Dir(outDir, vbDirectory) = "" Then MkDir outDir
    Dim proj As Object, c As Object, ext As String, fname As String
    Dim okCount As Long, failCount As Long
    For Each proj In Application.VBE.VBProjects
        Debug.Print "Project: " & proj.Name & "  Protection=" & proj.Protection
        If proj.Protection = 0 Then
            For Each c In proj.VBComponents
                Select Case c.Type
                    Case 1: ext = ".bas"
                    Case 2: ext = ".cls"
                    Case 3: ext = ".frm"
                    Case 100: ext = ".cls"
                    Case Else: ext = ".txt"
                End Select
                fname = outDir & proj.Name & "__" & c.Name & ext
                On Error Resume Next
                Kill fname
                c.Export fname
                If Err.Number = 0 Then okCount = okCount + 1 Else failCount = failCount + 1
                On Error GoTo 0
            Next
        End If
    Next
    Debug.Print "Exported: " & okCount & "   Failed: " & failCount
End Sub
```

- [x] Run `ExportAllVBA_Safe`. Result on SPOTS: `Project: SPOTSNEW  Protection=0  Exported: 4  Failed: 0`. Most business logic lives in form/report event procedures captured by Step 4 below — this is expected.

### 3. Export saved Queries as SQL (hardened, late-bound)

```vba
Sub ExportAllQueries_Safe()
    Dim outDir As String : outDir = "C:\spots-rev\export\queries\"
    If Dir(outDir, vbDirectory) = "" Then MkDir outDir
    Dim db As Object : Set db = CurrentDb
    Dim qd As Object, f1 As Integer, p As String
    For Each qd In db.QueryDefs
        If Left(qd.Name, 1) <> "~" Then
            p = outDir & Replace(qd.Name, "/", "_") & ".sql"
            f1 = FreeFile
            Open p For Output As #f1
            Print #f1, "-- Query: " & qd.Name
            Print #f1, qd.SQL
            Close #f1
        End If
    Next
    Debug.Print "Queries done."
End Sub
```

- [x] Run `ExportAllQueries_Safe`. One `.sql` file per saved query.

### 4. Export Forms / Reports / Macros as text (hardened)

```vba
Sub ExportFormsReportsMacros_Safe()
    Dim base As String : base = "C:\spots-rev\export\"
    Dim subs, s
    subs = Array("forms", "reports", "macros")
    For Each s In subs
        If Dir(base & s, vbDirectory) = "" Then MkDir base & s
    Next
    Dim obj As Object, okF As Long, okR As Long, okM As Long, fail As Long
    For Each obj In CurrentProject.AllForms
        On Error Resume Next
        Application.SaveAsText acForm, obj.Name, base & "forms\" & obj.Name & ".txt"
        If Err.Number = 0 Then okF = okF + 1 Else fail = fail + 1
        On Error GoTo 0
    Next
    For Each obj In CurrentProject.AllReports
        On Error Resume Next
        Application.SaveAsText acReport, obj.Name, base & "reports\" & obj.Name & ".txt"
        If Err.Number = 0 Then okR = okR + 1 Else fail = fail + 1
        On Error GoTo 0
    Next
    For Each obj In CurrentProject.AllMacros
        On Error Resume Next
        Application.SaveAsText acMacro, obj.Name, base & "macros\" & obj.Name & ".txt"
        If Err.Number = 0 Then okM = okM + 1 Else fail = fail + 1
        On Error GoTo 0
    Next
    Debug.Print "Forms=" & okF & "  Reports=" & okR & "  Macros=" & okM & "  Failed=" & fail
End Sub
```

- [ ] Run `ExportFormsReportsMacros_Safe`. `.txt` files are verbose property dumps containing control names, bound fields, **and embedded event-procedure VBA** — this is where the real business logic lives.

### 5. Screenshots of live workflows only

Skip anything you never open. For each **actively used** form/report:

- [ ] Design View → `meta\screens\<name>-design.png`
- [ ] Form/Report View with real data → `meta\screens\<name>-runtime.png`

Priority targets (skip if unused):

- Customer / Session intake
- Image browse / tagging
- Order entry (package selection, line items, totals)
- Order fulfillment / export to lab
- Schedule / Appointments
- Any report routinely printed or emailed (order confirmations, lab sheets, school packets)

### 6. Package and upload

- [ ] Zip `C:\spots-rev\export\` → `spots-vba-export.zip`.
- [ ] Drag into this Lovable chat. If >20 MB, split: `forms-reports.zip`, `screenshots-1.zip`, `screenshots-2.zip`, etc.

---

## Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| `Compile error: Sub or Function not defined` on `DAO.QueryDef` or `CurrentDb` | DAO reference missing | Tools → References → tick Microsoft Office Access Database Engine Object Library |
| Macro must be a single line in Immediate Window | Multi-line Subs can't be pasted there | Insert → Module → paste → F5 |
| Step 2 loop runs but exports 0 files | "Trust access to the VBA project object model" disabled | Trust Center → Macro Settings → tick it → reopen DB |
| `Protection=1` printed by `ExportAllVBA_Safe` | VBProject is password-locked | Skip Step 2; rely on Step 4 (`SaveAsText`) for event-procedure code |
| Step 2 exports only a handful of files (`Protection=0`) | The front-end genuinely has few standard modules; logic lives in form/report code-behind | Expected. Step 4 captures the rest. |
| `Path not found` writing `.sql` / `.txt` | Subfolder missing | Hardened macros now `MkDir` if missing; otherwise create manually |
| Form errors on open during screenshots | Broken reference, missing linked table, or dead code | Note name in `meta\skipped.txt` and move on |

---

## What Lovable does once the zip arrives

1. Unpack into `/tmp/spots-vba/`.
2. **`docs/spots/vba/INVENTORY.md`** — counts + list of every form/report/macro/query/module found.
3. **`docs/spots/vba/READ_MODEL.md`** — for each active screen: tables read, tables written, derived values computed. Spec for new read-only views + rebuilt write paths.
4. **`docs/spots/vba/QUERY_MAP.md`** — every saved `.sql` → Postgres view / function / app query, flagged `keep` / `rebuild` / `deprecate`.
5. **`docs/spots/vba/OPEN_QUESTIONS.md`** — numbered quiz of business rules that can't be inferred from artifacts alone. User answers inline.
6. Flag risky patterns: `DoCmd.RunSQL`, `CurrentDb.Execute`, `Shell`, `CreateObject("Outlook…")`, hard-coded UNC paths, ADO connection strings.
7. Bump `BUILD_PLAN.md` → v0.3.2, close Phase 2.

---

## Open questions for the user

- [ ] Multiple `.mdb` files in production (front-end / back-end split), or is `SPOTS2027.MDB` the entire app?
- [ ] Any linked tables to ODBC / SharePoint / other MDBs? (Globe/arrow icon in nav pane.)
- [ ] Any `.accda` / `.mde` / `.accde` add-ins loaded alongside?
- [ ] Which forms/reports are entry points actually used daily vs. legacy/dead?

---

## Status tracking

| Step | Status | Notes |
|------|--------|-------|
| 0. Prep | done | |
| 1. Metadata | in-progress | Documenter PDF + screenshots pending |
| 2. VBA export | done | 4 components exported, Protection=0. Full clone declared out of scope. |
| 3. Queries export | done | All saved QueryDefs exported as `.sql` |
| 4. Forms/Reports/Macros export | in-progress | Hardened `_Safe` variant ready |
| 5. Screenshots | in-progress | Live workflows only |
| 6. Upload zip | todo | partials accepted |
| 7. Lovable inventory + read model + quiz | todo | unblocks on upload |
