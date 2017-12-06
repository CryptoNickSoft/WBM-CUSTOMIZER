@Echo off
cd /d %~dp0
nircmd.exe killprocess ButtonBar.exe
nircmd.exe killprocess AkelPad_x86.exe
if not exist Reversed\bootmgr\bootmgr start "" /w /min "Reversed.cmd"
if not exist Reversed\bootmgr\BOOTMGR.XSL (
nircmd.exe infobox "Ошибка распаковки файла BOOTMGR" "Внимание..."
Exit
)
HxD.exe Reversed\bootmgr\bootmgr.exe
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
copy /y Reversed\bootmgr\bootmgr Source\bootmgr
Exit
:3
cd /d %~dp0
set /a soother=%sizeRev%-%sizeOrg%
set /a char=%soother%/2
nircmd.exe infobox "Удалите лишние символы:  %char% шт." "Внимание..."