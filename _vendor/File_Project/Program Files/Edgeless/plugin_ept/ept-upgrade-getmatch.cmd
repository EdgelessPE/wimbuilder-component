set /p mname=<X:\Users\ept\upgrade\matchName.txt
echo ept-upgrade-getmatch ��������ȡ������%mname% >>X:\Users\Log.txt
findstr /i "^%mname%_" X:\Users\ept\upgrade\7zList.txt >>X:\Users\ept\upgrade\7zlMatch.txt