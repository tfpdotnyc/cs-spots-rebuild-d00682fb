Attribute VB_Name = "Module3"
Option Compare Database

Sub ExportAllQueries()
    Dim outDir As String: outDir = "C:\spots-rev\export\queries\"
    If Dir(outDir, vbDirectory) = "" Then MkDir outDir
    Dim qd As Object, f1 As Integer, path As String
    For Each qd In CurrentDb.QueryDefs
        If Left(qd.Name, 1) <> "~" Then
            path = outDir & Replace(Replace(qd.Name, "/", "_"), "\", "_") & ".sql"
            f1 = FreeFile
            Open path For Output As #f1
            Print #f1, "-- Query: " & qd.Name
            Print #f1, qd.SQL
            Close #f1
        End If
    Next
    Debug.Print "Done. Exported to " & outDir
End Sub
