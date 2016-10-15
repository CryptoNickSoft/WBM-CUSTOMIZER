@Echo off
cd /d %~dp0
nircmd.exe killprocess ButtonBar.exe
nircmd.exe killprocess AkelPad_x86.exe
if not exist Reversed\bootmgr\bootmgr start "" /w /min "Reversed.cmd"
if not exist Reversed\bootmgr\BOOTMGR.XSL (
nircmd.exe infobox "Ошибка распаковки файла BOOTMGR" "Внимание..."
Exit
)
HexEdit.exe Reversed\bootmgr\bootmgr.exe
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
copy /y Reversed\bootmgr\bootmgr Source\bootmgr
Exit
:3
cd /d %~dp0
set /a soother=%sizeRev%-%sizeOrg%
set /a char=%soother%/2
nircmd.exe infobox "Удалите лишние символы:  %char% шт." "Внимание..."