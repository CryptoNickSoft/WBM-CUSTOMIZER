@Echo off
cd /d %~dp0
nircmd.exe killprocess ButtonBar.exe
nircmd.exe killprocess qemu.exe
nircmd.exe killprocess AkelPad_x86.exe
nircmd.exe killprocess cmd.exe