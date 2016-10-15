@Echo off
cd /d %~dp0
if not exist Reversed\bootmgr\bootmgr nircmd.exe infobox "Резервная копия отсутствует!" "Внимание..." & exit
set /P CURRENTNAME= < temp.tmp
copy /y Reversed\bootmgr\bootmgr.ORG.exe Reversed\bootmgr\bootmgr.exe
move /y Source\%CURRENTNAME% Source\boot
cd /d %~dp0Reversed\bootmgr\
for /f "skip=5 tokens=3" %%a in ('"dir BOOTMGR.ORG.XSL /-c"') do set sizeOrg=%%a & goto 1
:1 
for /f "skip=5 tokens=3" %%a in ('"dir BOOTMGR.XSL /-c"') do set sizeRev=%%a & goto 2
:2 
set /a soother=%sizeOrg%-%sizeRev%
if %soother% LSS 0 goto 3
del /f /q soother
fsutil file createnew soother %soother%
cd /d %~dp0
ResHackerFX.exe -script modify.txt
pecs.exe Reversed\bootmgr\bootmgr.exe
bmzip.exe /c Reversed\bootmgr\bootmgr.exe Reversed\bootmgr\bootmgr
move /y Source\boot\ru-RU\bootmgr.exe.mui Source\boot\ru-RU\!bootmgr.exe.mui!
copy /y Reversed\bootmgr\bootmgr Source\bootmgr
cd /d %~dp0Source\boot
set /P BCDNAME= < bcd.tmp
cd /d %~dp0
if exist Source\boot\bcd.tmp (
del /f /q Source\boot\%BCDNAME%
del /f /q Source\boot\bcd.tmp)
copy /y Reversed\bcd\bcd Source\boot\bcd
del /f /q test.iso
del /f /q temp.tmp
Echo boot>>temp.tmp
del /f /q bcd.tmp
Echo bcd>>bcd.tmp
nircmd.exe killprocess qemu.exe
oscdimg.exe -u1 -lProject -betfsboot.com Source test.iso
qemu.exe -boot d -cdrom "test.iso" -hda \\.\PhysicalDrive0 -m 512 -localtime -L . -net nic -net user
Exit
:3
cd /d %~dp0
set /a soother=%sizeRev%-%sizeOrg%
set /a char=%soother%/2
nircmd.exe infobox "Удалите лишние символы:  %char% шт." "Внимание..."