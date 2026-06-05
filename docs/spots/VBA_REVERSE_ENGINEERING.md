# SPOTS 2027 — VBA Reverse Engineering Checklist

Version: 0.1.0
Last Updated: 2026-06-05
Status: **Blocked on user** — requires Microsoft Access (Windows) to extract. `mdb-tools` cannot read VBA, Forms, Reports, Macros, or Query SQL.

---

## Why this phase exists

`SPOTS2027.MDB` is a reference-rich Access app. The Postgres schema (Phase 1) covers **tables only**. Business logic lives in:

- **VBA modules** (`.bas`) — standard modules with shared functions/subs.
- **Class modules** (`.cls`) — object wrappers.
- **Form modules** (`.frm` + `.frx`) — UI event handlers (`Form_Load`, `cmd*_Click`, etc.).
- **Report modules** — print/export logic, often the source of derivative image presets and order paperwork.
- **Macros** — AutoExec, ribbon hooks, named macros invoked from forms.
- **Stored Queries** — saved `QueryDefs` (SELECT/INSERT/UPDATE/DELETE/parameter queries). These often encode joins and filters that look like business rules.
- **References** — DAO/ADO/Outlook/Office/3rd-party COM libs. Each reference is a potential cutover blocker.

Until these are extracted, we cannot faithfully re-implement order processing, image-export presets, scheduling, or sync expectations.

---

## Required environment

- Windows 10 or 11
- Microsoft Access (2016, 2019, 365, or Runtime is **not** sufficient — full Access required for VBE export)
- A working copy of `SPOTS2027.MDB` (never the original)
- 7-Zip or similar (to zip the export folder)

---

## Extraction checklist

### 0. Prep

- [ ] Copy `SPOTS2027.MDB` to `C:\spots-rev\SPOTS2027_WORK.MDB`. Work only on the copy.
- [ ] Create export folder: `C:\spots-rev\export\` with subfolders `vba\`, `queries\`, `forms\`, `reports\`, `macros\`, `meta\`.
- [ ] Open the copy in Access. If prompted, enable content/macros (we need them readable, not running).

### 1. Capture metadata

- [ ] Database Tools → **Database Documenter** → select **All object types** → All → OK. Save the report as PDF to `meta\documenter.pdf`.
- [ ] File → Options → Current Database — screenshot startup form, AutoExec, ribbon settings to `meta\startup-settings.png`.
- [ ] In the VBE (Alt+F11) → Tools → References — screenshot the full list to `meta\references.png`. Note any non-standard libraries (Outlook, Word, Excel, Scripting Runtime, FSO, ADO version, custom DLLs).

### 2. Export VBA (modules, classes, form code, report code)

Open the VBE (Alt+F11), then in the **Immediate Window** (Ctrl+G) paste and run:

```vba
Sub ExportAllVBA()
    Dim outDir As String : outDir = "C:\spots-rev\export\vba\"
    Dim c As Object, ext As String, fname As String
    For Each c In Application.VBE.ActiveVBProject.VBComponents
        Select Case c.Type
            Case 1: ext = ".bas"   ' standard module
            Case 2: ext = ".cls"   ' class module
            Case 3: ext = ".frm"   ' form module
            Case 100: ext = ".cls" ' document/report code-behind
            Case Else: ext = ".txt"
        End Select
        fname = outDir & c.Name & ext
        On Error Resume Next
        Kill fname
        On Error GoTo 0
        c.Export fname
    Next
    Debug.Print "Done."
End Sub
```

- [ ] Run `ExportAllVBA`. Confirm `vba\` contains one file per module. Expect dozens.
- [ ] Spot-check three files open in Notepad and show readable code (not binary).

### 3. Export saved Queries as SQL

Paste in the Immediate Window:

```vba
Sub ExportAllQueries()
    Dim outDir As String : outDir = "C:\spots-rev\export\queries\"
    Dim qd As DAO.QueryDef, f As Integer, path As String
    For Each qd In CurrentDb.QueryDefs
        If Left(qd.Name, 1) <> "~" Then
            path = outDir & Replace(qd.Name, "/", "_") & ".sql"
            f = FreeFile
            Open path For Output As #f
            Print #f, "-- Query: " & qd.Name
            Print #f, qd.SQL
            Close #f
        End If
    Next
    Debug.Print "Done."
End Sub
```

- [ ] Run `ExportAllQueries`. Confirm one `.sql` file per saved query.

### 4. Export Forms and Reports as text (SaveAsText)

```vba
Sub ExportFormsReportsMacros()
    Dim db As Object : Set db = CurrentDb
    Dim obj As AccessObject
    For Each obj In CurrentProject.AllForms
        Application.SaveAsText acForm, obj.Name, "C:\spots-rev\export\forms\" & obj.Name & ".txt"
    Next
    For Each obj In CurrentProject.AllReports
        Application.SaveAsText acReport, obj.Name, "C:\spots-rev\export\reports\" & obj.Name & ".txt"
    Next
    For Each obj In CurrentProject.AllMacros
        Application.SaveAsText acMacro, obj.Name, "C:\spots-rev\export\macros\" & obj.Name & ".txt"
    Next
    Debug.Print "Done."
End Sub
```

- [ ] Run `ExportFormsReportsMacros`. Each `.txt` is a verbose property dump — that's expected; we need control names, bound fields, and event procedures.

### 5. Capture screenshots of key forms/reports

For each form/report that exists in the Access nav pane (especially `frm*Order*`, `frm*Session*`, `frm*Image*`, `rpt*Export*`, `rpt*Order*`):

- [ ] Open in Design View, screenshot to `meta\screens\<name>-design.png`.
- [ ] Open in Form/Report View with sample data, screenshot to `meta\screens\<name>-runtime.png`.

(Skip if a form errors on open — just note the name in `meta\skipped.txt`.)

### 6. Package and upload

- [ ] Zip `C:\spots-rev\export\` to `spots-vba-export.zip`.
- [ ] Upload `spots-vba-export.zip` into this Lovable chat.

---

## What Lovable does once the zip arrives

1. Unpack into `/tmp/spots-vba/`.
2. Inventory: count modules, classes, forms, reports, macros, queries → write `docs/spots/vba/INVENTORY.md`.
3. Per module: extract Inputs / Outputs / Side-effects / Postgres-or-TS equivalent → write `docs/spots/vba/SUMMARY.md` (one row per Sub/Function).
4. Flag risky patterns: `DoCmd.RunSQL`, `CurrentDb.Execute`, `Shell`, `CreateObject("Outlook…")`, file I/O against `studios.spotspath`, hard-coded UNC paths, ADO connection strings.
5. Map saved Queries to Postgres equivalents (views, RLS-aware functions, or app-layer queries) in `docs/spots/vba/QUERY_MAP.md`.
6. Surface unresolved business rules as questions back to the user.

---

## Open questions for the user

- [ ] Are there **multiple `.mdb` files** in production (front-end / back-end split), or is `SPOTS2027.MDB` the entire app?
- [ ] Any **linked tables** to ODBC sources, SharePoint, or other MDBs? (Visible in nav pane with a globe/arrow icon.)
- [ ] Any **add-ins / .accda / .mde / .accde** loaded alongside?
- [ ] Confirm which forms are entry points actually used daily vs. legacy/dead.

---

## Status tracking

| Step | Status | Notes |
|------|--------|-------|
| 0. Prep | blocked-on-user | needs Windows + Access |
| 1. Metadata | blocked-on-user | |
| 2. VBA export | blocked-on-user | |
| 3. Queries export | blocked-on-user | |
| 4. Forms/Reports/Macros export | blocked-on-user | |
| 5. Screenshots | blocked-on-user | |
| 6. Upload zip | blocked-on-user | |
| 7. Lovable inventory + summary | todo | unblocks on upload |
