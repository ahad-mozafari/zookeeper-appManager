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

call %scriptPath%\Kill.cmd

REM Remove AppFolder from AppRoot
if exist "%AppRoot%\%AppFolder%" (
    rmdir /s /q "%AppRoot%\%AppFolder%"
    echo [%DATE% %TIME%]  Removed %AppFolder% from %AppRoot%	 >> "%LOG_FILE%"
) else (
    echo [%DATE% %TIME%]  %AppFolder% does not exist in %AppRoot%	 >> "%LOG_FILE%"
)

powershell Start-Sleep -m 2000

REM Extract zipFile from zipFolder to AppRoot
if exist "%zipFolder%\%zipFile%" (
    powershell -command "Expand-Archive -Path '%zipFolder%\%zipFile%' -DestinationPath '%AppRoot%'"
    echo [%DATE% %TIME%]   Extracted %zipFile% from %zipFolder% to %AppRoot	 >> "%LOG_FILE%"
) else (
    echo [%DATE% %TIME%]   %zipFile% does not exist in %zipFolder%	 >> "%LOG_FILE%"
)

endlocal
