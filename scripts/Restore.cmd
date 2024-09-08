@echo off
setlocal enabledelayedexpansion

REM Kill the application

REM Read config.ini file
for /f "tokens=1,2 delims==" %%A in (config.ini) do (
    set "var=%%A"
    set "value=%%B"
    set "!var!=!value!"
)


REM Kill the application
taskkill /IM %AppName% /F
if %errorlevel% equ 0 (
    echo Successfully killed %AppName%
) else (
    echo Failed to kill %AppName%. It may not be running.
)

REM Remove AppFolder from AppRoot
if exist "%AppRoot%\%AppFolder%" (
    rmdir /s /q "%AppRoot%\%AppFolder%"
    echo Removed %AppFolder% from %AppRoot%
) else (
    echo %AppFolder% does not exist in %AppRoot%
)

powershell Start-Sleep -m 2000

REM Extract zipFile from zipPath to AppRoot
if exist "%zipPath%\%zipFile%" (
    powershell -command "Expand-Archive -Path '%zipPath%\%zipFile%' -DestinationPath '%AppRoot%'"
    echo Extracted %zipFile% from %zipPath% to %AppRoot%
) else (
    echo %zipFile% does not exist in %zipPath%
)

endlocal
pause
