@echo off
setlocal enabledelayedexpansion

set "configFile=%1"
echo config file is  %configFile%

REM Define the log file path
set "LOG_FILE=log.txt"

REM Read config.ini file
for /f "tokens=1,2 delims==" %%A in (%configFile%) do (
    set "var=%%A"
    set "value=%%B"
    set "!var!=!value!"
)

REM Split the processes string into an array
set processes=%processes%
set processes=%processes:,= %

REM Kill each process in the array
for %%P in (%processes%) do (
    taskkill /IM %%P /F
    if %errorlevel% equ 0 (
        echo [%DATE% %TIME%]  Successfully killed %%P	 >> "%LOG_FILE%"
    ) else (
        echo [%DATE% %TIME%]  Failed to kill %%P. It may not be running.	 >> "%LOG_FILE%"
    )
)

endlocal

