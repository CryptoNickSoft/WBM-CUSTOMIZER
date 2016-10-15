@Echo off
cd /d %~dp0
nircmd.exe killprocess ButtonBar.exe
nircmd.exe killprocess AkelPad_x86.exe 
if not exist Reversed\bootmgr\bootmgr start "" /w /min "Reversed.cmd"
if not exist Reversed\bootmgr\BOOTMGR.XSL (
nircmd.exe infobox "Ошибка распаковки файла BOOTMGR" "Внимание..."
Exit
)
cd /d %~dp0Source
for /d %%B in (*) do set CURRENTNAME=%%B
cd /d %~dp0
move /y Source\%CURRENTNAME%\ru-RU\bootmgr.exe.mui Source\%CURRENTNAME%\ru-RU\!bootmgr.exe.mui!
start "" "ButtonBar.exe" ButtonBarBmr.ini
start "" "AkelPad_x86.exe" Reversed\bootmgr\BOOTMGR.XSL

