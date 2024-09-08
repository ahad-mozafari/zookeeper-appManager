@echo off
setlocal enabledelayedexpansion

REM Read config.ini file
for /f "tokens=1,2 delims==" %%A in (config.ini) do (
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
        echo Successfully killed %%P
    ) else (
        echo Failed to kill %%P. It may not be running.
    )
)

endlocal
pause
