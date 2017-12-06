@Echo off
cd /d %~dp0
nircmd.exe killprocess qemu.exe
nircmd.exe waitprocess qemu.exe
del /f /q test.iso
oscdimg.exe -u1 -lProject -betfsboot.com Source test.iso
qemu.exe -boot d -cdrom "test.iso" -hda \\.\PhysicalDrive0 -m 512 -localtime -L . -net nic -net user