@Echo off
cd /d %~dp0
nircmd.exe killprocess AkelPad_x86.exe
nircmd.exe killprocess qemu.exe
nircmd.exe killprocess ButtonBar.exe
nircmd.exe killprocess EasyBootIce.exe
del /f /q Reversed\bootmgr\*
del /f /q Reversed\mui\*
del /f /q Reversed\bcd\*
del /f /q BackUp\bootmgr\*
del /f /q BackUp\mui\*
del /f /q AkelPad.exe
rmdir .\Source /s /q
xcopy /c /s /h /y Original Source\
del /f /q ResHackerFX.ini
del /f /q EasyBootIce.ini
del /f /q Extract_BMR.ini
del /f /q autorun.ico
del /f /q autorun.inf
del /f /q autorun.exe
del /f /q temp.tmp
del /f /q bcd.tmp
Echo boot>>temp.tmp
Echo bcd>>bcd.tmp
del /f /q test.iso
del /f /q *.jpg
nircmd.exe infobox "Очищено!" "Внимание..."