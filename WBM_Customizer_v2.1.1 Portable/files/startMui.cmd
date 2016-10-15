@Echo off
cd /d %~dp0
set /P CURRENTNAME= < temp.tmp
tasklist.exe | find "AkelPad_x86.exe"
if %ERRORLEVEL%==1 start "" "AkelPad_x86.exe" Reversed\mui\BOOTMGR.XSL
nircmd.exe killprocess qemu.exe
ResHackerFX.exe -script modifyMUI.txt
move /y Source\%CURRENTNAME%\ru-RU\!bootmgr.exe.mui! Source\%CURRENTNAME%\ru-RU\bootmgr.exe.mui
copy /y "Reversed\mui\bootmgr.exe.mui" "Source\%CURRENTNAME%\ru-RU\bootmgr.exe.mui"
del /f /q test.iso
oscdimg.exe -u1 -lProject -betfsboot.com Source test.iso
qemu.exe -boot d -cdrom "test.iso" -hda \\.\PhysicalDrive0 -m 512 -localtime -L . -net nic -net user
copy /y Reversed\mui\BOOTMGR.XSL BackUp\mui\BOOTMGR.XSL
