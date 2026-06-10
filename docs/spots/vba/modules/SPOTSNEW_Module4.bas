Attribute VB_Name = "Module4"
Option Compare Database

Sub ExportAllVBA_Safe()
    Dim outDir As String: outDir = "C:\spots-rev\export\vba\"
    Dim proj As Object, c As Object
    Dim ext As String, fname As String, n As Long, errs As Long
    
    If Dir(outDir, vbDirectory) = "" Then MkDir outDir
    
    For Each proj In Application.VBE.VBProjects
        Debug.Print "Project: " & proj.Name & "  Protection=" & proj.Protection
        For Each c In proj.VBComponents
            Select Case c.Type
                Case 1: ext = ".bas"
                Case 2: ext = ".cls"
                Case 3: ext = ".frm"
                Case 100: ext = ".cls"
                Case Else: ext = ".txt"
            End Select
            fname = outDir & proj.Name & "_" & c.Name & ext
            On Error Resume Next
            Kill fname
            Err.Clear
            c.Export fname
            If Err.Number <> 0 Then
                Debug.Print "FAIL: " & c.Name & " -> " & Err.Description
                errs = errs + 1
            Else
                n = n + 1
            End If
            On Error GoTo 0
        Next
    Next
    Debug.Print "Exported: " & n & "   Failed: " & errs
End Sub
