@echo off
setlocal enabledelayedexpansion

set count=0

:loop
set /a count+=1
set /p output=<output2.txt
echo Count is %count% %output%
powershell Start-Sleep -m 500

goto loop