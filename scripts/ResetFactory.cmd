@echo off
setlocal enabledelayedexpansion

echo [%DATE% %TIME%] " Start ResetFactory" >> "%LOG_FILE%"

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

call %scriptPath%\Restore.cmd

echo [%DATE% %TIME%]  settingFolder is  %settingFolder%	 >> "%LOG_FILE%"
echo [%DATE% %TIME%]  zipSettingFile is  %zipSettingFile% >> "%LOG_FILE%")
echo [%DATE% %TIME%]  zipSettingFolder is  %zipSettingFolder%	 >> "%LOG_FILE%")
powershell Start-Sleep -m 200

REM Extract zipSettingFile from zipSettingFolder to settingFolder
if exist "%zipSettingFolder%\%zipSettingFile%" (
    powershell -command "Expand-Archive -Path '%zipSettingFolder%\%zipSettingFile%' -DestinationPath '%settingFolder%'"
    echo [%DATE% %TIME%]   Extracted %zipSettingFile% from %zipSettingFolder% to %settingFolder	 >> "%LOG_FILE%"
) else (
    echo [%DATE% %TIME%]   %zipSettingFile% does not exist in %zipSettingFolder%	 >> "%LOG_FILE%"
)
