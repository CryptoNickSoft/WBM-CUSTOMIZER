@Echo off
cd /d %~dp0
set /P CURRENTNAME= < temp.tmp
copy /y BackUp\bootmgr\BOOTMGR.ORG.XSL Reversed\bootmgr\BOOTMGR.XSL
cd /d %~dp0Reversed\bootmgr\
for  %%a in (BOOTMGR.ORG.XSL) do set sizeOrg=%%~za & goto 1
:1 
for  %%a in (BOOTMGR.XSL) do set sizeRev=%%~za & goto 2
:2 
set /a soother=%sizeOrg%-%sizeRev%
if %soother% LSS 0 goto 3
del /f /q soother
fsutil file createnew soother %soother%
cd /d %~dp0
ResHackerFX.exe -script modify.txt
pecs.exe Reversed\bootmgr\bootmgr.exe
bmzip.exe /c Reversed\bootmgr\bootmgr.exe Reversed\bootmgr\bootmgr
move /y Source\%CURRENTNAME%\ru-RU\bootmgr.exe.mui Source\%CURRENTNAME%\ru-RU\!bootmgr.exe.mui!
copy /y Reversed\bootmgr\bootmgr Source\bootmgr
nircmd.exe killprocess AkelPad_x86.exe
nircmd.exe killprocess ButtonBar.exe
nircmd.exe killprocess qemu.exe
nircmd.exe qboxcomtop "Запустить виртуальную машину ~nQemu, для тестирования?" "Внимание..." "execmd" qemu.cmd