@echo off
setlocal enabledelayedexpansion

title MonitorAppManager

REM Define the log file path
set "LOG_FILE=log.txt"

set "configFile=%1"
echo config file is  %configFile%

echo [%DATE% %TIME%] " Start Monitoring" >> "%LOG_FILE%"

REM Read config.ini file
for /f "tokens=1,2 delims==" %%A in (%configFile%) do (
    set "var=%%A"
    set "value=%%B"
    set "!var!=!value!"
)

set "AppFilePath=%AppRoot%\%AppFolder%\%AppName%"

echo [%DATE% %TIME%] %configFile% "%AppFilePath%"  >> "%LOG_FILE%"
:monitor_process
call :check_process
powershell Start-Sleep -m 2000
goto monitor_process

echo [%DATE% %TIME%] " stop %AppName%" >> "%LOG_FILE%"
:check_process
tasklist | find /i "%AppName%" >nul
if errorlevel 1 (
    echo [%DATE% %TIME%] %AppName% is not running. Restarting... >> "%LOG_FILE%"
REM    start "" "%AppFilePath%"
	%AppFilePath%
)

exit /b