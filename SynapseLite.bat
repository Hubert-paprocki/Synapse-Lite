@echo off

set "max_checks=60"
set "check_interval=1"
set "check_count=0"

:loop
set "are_running=true"
for %%p in ("RzActionSvc.exe" "RazerCentralService.exe" "CefSharp.BrowserSubprocess.exe" "GameManagerService.exe") do (
    set "is_running="
    for /f "tokens=1" %%i in ('tasklist /nh /fi "imagename eq %%~p" 2^>nul') do (
        set "is_running=%%i"
    )
    if not defined is_running (
        set "are_running=false"
    )
)

if "%are_running%"=="true" (
    Timeout 60
    taskkill /f /t /im "Razer Synapse 3.exe"
    taskkill /f /t /im  "RzActionSvc.exe"
    taskkill /f /t /im "Razer Synapse Service Process.exe"
    taskkill /f /t /im "CefSharp.BrowserSubprocess.exe"
) else (
    set /a "check_count+=1"
    if !check_count! lss %max_checks% (
        timeout /t %check_interval% /nobreak >nul
        goto loop
    ) else (
        exit /b 1
    )
)

endlocal
