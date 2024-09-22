@echo off
setlocal enabledelayedexpansion


set "configFile=%1"
echo config file is  %configFile%

set count=0

:loop
set /a count+=1
echo Count is %count%
powershell Start-Sleep -m 500

goto loop