@echo off
echo %time% ept-cache-���У���һ������%1���ڶ�������%2 >>X:\Users\Log.txt

if "%1"=="search" (
    echo %time% ept-cache-�ض�����ept-search >>X:\Users\Log.txt
    call ept-search %2
    goto endOfEtp
)

if "%1"=="madison" (
    echo %time% ept-cache-�ض�����ept-getver >>X:\Users\Log.txt
    call ept-getver %2
    goto endOfEtp
)

call ept-help.cmd
:endOfEtp
@echo on