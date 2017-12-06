@Echo off
cd /d %~dp0
set /P CURRENTNAME= < temp.tmp
copy /y BackUp\mui\BOOTMGR.XSL BackUp\mui\BootmgrUndo.XSL
nircmd.exe killprocess qemu.exe
nircmd.exe killprocess AkelPad_x86.exe
copy /y BackUp\mui\BootmgrUndo.XSL Reversed\mui\BOOTMGR.XSL
tasklist.exe | find "AkelPad_x86.exe"
if %ERRORLEVEL%==1 start "" "AkelPad_x86.exe" Reversed\mui\BOOTMGR.XSL
ResHackerFX.exe -script modifyMUI.txt
move /y Source\%CURRENTNAME%\ru-RU\!bootmgr.exe.mui! Source\%CURRENTNAME%\ru-RU\bootmgr.exe.mui
copy /y "Reversed\mui\bootmgr.exe.mui" "Source\%CURRENTNAME%\ru-RU\bootmgr.exe.mui"
del /f /q test.iso
oscdimg.exe -u1 -lProject -betfsboot.com Source test.iso
qemu.exe -boot d -cdrom "test.iso" -hda \\.\PhysicalDrive0 -m 512 -localtime -L . -net nic -net user