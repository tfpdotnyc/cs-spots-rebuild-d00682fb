Attribute VB_Name = "Module1"
Option Compare Database

Private Sub RenameFiles()
    Dim sFile As String
    Dim sNewFile As String
    
    sFile = Dir("C:\Program Files\SPOTS20\Data\Rutgers\Yearbook_Images_Verified\*.*")
    
    Do Until sFile = vbNullString
        sNewFile = vbNullString
        bSecond = False
        For i = 1 To Len(sFile)
            If Mid(sFile, i, 1) = "_" Then
                If bSecond = True Then
                    GoTo NextChar
                Else
                    bSecond = True
                End If
            End If
            sNewFile = sNewFile & Mid(sFile, i, 1)
NextChar:
        Next i
        FileCopy "C:\Program Files\SPOTS20\Data\Rutgers\Yearbook_Images_Verified\" & sFile, "C:\Program Files\SPOTS20\Data\Rutgers\Misc_1\" & sNewFile
        sFile = Dir()
    Loop
End Sub
