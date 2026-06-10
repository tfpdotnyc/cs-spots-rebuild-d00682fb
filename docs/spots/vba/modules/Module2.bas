Attribute VB_Name = "Module2"
Option Compare Database

Sub ExportAllVBA()
    Dim outDir As String: outDir = "C:\spots-rev\export\vba\"
    Dim c As Object, ext As String, fname As String
    For Each c In Application.VBE.ActiveVBProject.VBComponents
        On Error Resume Next
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
