@echo off
del /f /q target.txt
for /f "delims=" %%c in ('type %1 ^|find /v "" ^| findstr /I /C:".exe"') do (
    set paf=%%c
)
set "paf=%paf:\=\\%"
echo %paf%>target.txt