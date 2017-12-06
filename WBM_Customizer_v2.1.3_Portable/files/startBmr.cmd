@Echo off
cd /d %~dp0
set /P CURRENTNAME= < temp.tmp
tasklist.exe | find "AkelPad_x86.exe"
if %ERRORLEVEL%==1 start "" "AkelPad_x86.exe" Reversed\bootmgr\BOOTMGR.XSL
nircmd.exe killprocess qemu.exe
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
del /f /q test.iso
oscdimg.exe -u1 -lProject -betfsboot.com Source test.iso
qemu.exe -boot d -cdrom "test.iso" -hda \\.\PhysicalDrive0 -m 512 -localtime -L . -net nic -net user
copy /y Reversed\bootmgr\BOOTMGR.XSL BackUp\bootmgr\BOOTMGR.XSL
Exit
:3
cd /d %~dp0
set /a soother=%sizeRev%-%sizeOrg%
set /a char=%soother%/2
nircmd.exe infobox "Удалите лишние символы:  %char% шт." "Внимание..."
