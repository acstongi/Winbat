Set fso = CreateObject("Scripting.FileSystemObject")

ScanAndUnlock "D:\"

Sub ScanAndUnlock(path)
    On Error Resume Next
    Set folder = fso.GetFolder(path)
    
    For Each file In folder.Files
        If LCase(fso.GetExtensionName(file.Name)) = "locked" Then
            ' .locked এক্সটেনশন সরিয়ে ফেলা
            file.Name = Replace(file.Name, ".locked", "")
        End If
    Next

    For Each subFolder In folder.SubFolders
        ScanAndUnlock subFolder.Path
    Next
End Sub
