@echo off

set "max_checks=60"
set "check_interval=1"
set "check_count=0"
set "wait_for_setup=60"
set "give_time_to_read=3"

:loop
set "are_running=false"

for /f "tokens=1" %%i in ('tasklist /nh /fi "imagename eq RazerCentralService.exe"') do (
    if "%%i"=="RazerCentralService.exe" (
        set "are_running=true"
        echo Razer Synapse is running
    )
)

if "%are_running%"=="true" (
    Timeout %wait_for_setup%
    taskkill /f /t /im "Razer Synapse 3.exe"
    taskkill /f /t /im "RzActionSvc.exe"
    taskkill /f /t /im "Razer Synapse Service Process.exe"
    taskkill /f /t /im "CefSharp.BrowserSubprocess.exe"
    timeout 4
) else (
    set /a "check_count+=%check_interval%"
    echo Checking if Razer Synapse is running %check_count% / %max_checks%
    if %check_count% lss %max_checks% (
        timeout /t %check_interval% /nobreak >nul
        goto loop
    ) else (
        echo Razer Synapse not running after %max_checks% checks. Exiting.
        timeout %give_time_to_read% >null
        exit /b 1
    )
)

endlocal