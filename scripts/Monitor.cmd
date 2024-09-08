@echo off
setlocal enabledelayedexpansion

set "config_file=config.ini"

REM Read config.ini file
for /f "tokens=1,2 delims==" %%A in (%config_file%) do (
    set "var=%%A"
    set "value=%%B"
    set "!var!=!value!"
)


:monitor_process
call :check_process
powershell Start-Sleep -m 500
goto monitor_process

:check_process
tasklist | find /i "%AppName%" >nul
if errorlevel 1 (
    echo %AppName% is not running. Restarting...
    start "" "%AppPath%\%AppName%"
)
exit /b