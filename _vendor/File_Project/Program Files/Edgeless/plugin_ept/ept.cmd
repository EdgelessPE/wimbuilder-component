@echo off
echo %time% ept-���У���һ������%1���ڶ�������%2������������%3 >>X:\Users\Log.txt
if "%1"=="search" (
    echo %time% ept-�ض�����ept-search >>X:\Users\Log.txt
    call ept-search %2
    goto endOfEtp
)
if "%1"=="install" (
    echo %time% ept-�ض�����ept-install >>X:\Users\Log.txt
    call ept-install %2 %3
    goto endOfEtp
)

if "%1"=="remove" (
    echo %time% ept-�ض�����ept-remove >>X:\Users\Log.txt
    call ept-remove %2 %3
    goto endOfEtp
)

if "%1"=="update" (
    echo %time% ept-�ض�����ept-update >>X:\Users\Log.txt
    call ept-update
    goto endOfEtp
)

if "%1"=="upgrade" (
    echo %time% ept-�ض�����ept-upgrade >>X:\Users\Log.txt
    call ept-upgrade %2
    goto endOfEtp
)

if "%1"=="getver" (
    echo %time% ept-cache-�ض�����ept-getver >>X:\Users\Log.txt
    call ept-getver %2
    goto endOfEtp
)
call ept-help.cmd
:endOfEtp
@echo on