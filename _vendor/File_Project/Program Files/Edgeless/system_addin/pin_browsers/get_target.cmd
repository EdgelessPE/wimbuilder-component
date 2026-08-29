@echo off
del /f /q target.txt arguments.txt 2>nul
get_lnk.exe %1 target.txt arguments.txt X:\Users\Config\HomePage.txt
if errorlevel 1 del /f /q target.txt arguments.txt 2>nul
