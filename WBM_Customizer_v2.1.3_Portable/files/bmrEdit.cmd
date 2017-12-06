@echo off
cd /d %~dp0
if not exist Reversed\bootmgr\bootmgr start "" /w /min "Reversed.cmd"
set /P FOLDER= < temp.tmp
set /P BCD= < bcd.tmp
nircmd.exe killprocess AkelPad_x86.exe
nircmd.exe killprocess qemu.exe
nircmd.exe killprocess ButtonBar.exe
ChangeFolder.exe
if exist "cancel.tmp" exit
set /P CURRENTNAME= < temp.tmp
set /P BCDNAME= < bcd.tmp
del /f /q Reversed\bootmgr\bootmgr.exe
copy /y Reversed\bootmgr\bootmgr.ORG.exe Reversed\bootmgr\bootmgr.exe
bmredit.exe -file=Reversed\bootmgr\bootmgr.exe -boot=%CURRENTNAME% -bcd=%BCDNAME% -font=boot.ttf
if %Errorlevel% NEQ 0 (
del /f /q temp.tmp
del /f /q bcd.tmp
Echo %FOLDER%>>temp.tmp
Echo %BCD%>>bcd.tmp
nircmd.exe qboxcom "Коды ошибок:~n1 - не найдено стандартное имя папки BCD (Boot)~n2 - не найдено стандартное имя файла BCD (BCD)~n3 - не найдено стандартное имя шрифта (wgl4_boot.ttf)~n~nКонечный код формируется из вышеуказанных чисел.~n~n!!! КОД ОШИБКИ:  %Errorlevel% ~n~nВозможно, Hex значения Bootmgr, редактировались ранее,~nили введены неверные данные...~n~nИСПОЛЬЗОВАТЬ СТАНДАРТНЫЙ,~n ВСТРОЕННЫЙ В ПРОГРАММУ BOOTMGR ???~n~n(если загруженный Bootmgr другой версии, данное действие~nприведет к непредсказуемым результатам!)" "Ошибка редактирования файла BOOTMGR !!!" execmd bmrDefault.cmd
exit
)
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
move /y Source\%FOLDER%\%BCD% Source\%FOLDER%\%BCDNAME%
copy /y bcd.tmp Source\%FOLDER%\bcd.tmp
move /y Source\%FOLDER% Source\%CURRENTNAME% 
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {memdiag} path \%CURRENTNAME%\memtest.exe
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {memdiag} nointegritychecks True
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {bootmgr} nointegritychecks True
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {default} nointegritychecks True
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {globalsettings} nointegritychecks True
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {bootmgr} nointegritychecks True
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {ramdiskoptions} ramdisksdipath \%CURRENTNAME%\boot.sdi
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {7619dcc8-fafe-11d9-b411-000476eba25f} ramdisksdipath \%CURRENTNAME%\boot.sdi
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {default} device ramdisk=[boot]\%CURRENTNAME%\boot.wim,{ramdiskoptions}
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {default} osdevice ramdisk=[boot]\%CURRENTNAME%\boot.wim,{ramdiskoptions}
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {4840b8bb-89db-40a5-9ced-9c0265bfa6b5} device ramdisk=[boot]\%CURRENTNAME%\boot.wim,{ramdiskoptions}
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {4840b8bb-89db-40a5-9ced-9c0265bfa6b5} osdevice ramdisk=[boot]\%CURRENTNAME%\boot.wim,{ramdiskoptions}
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {globalsettings} FontPath \%CURRENTNAME%\Fonts
bcdedit.exe /store Source\%CURRENTNAME%\%BCDNAME% /set {globalsettings} loadoptions "DDISABLE_INTEGRITY_CHECKS"
nircmd.exe waitprocess bcdedit.exe
attrib -r -s -h /S "Source\%CURRENTNAME%\*.log*" 1>nul 2>&1
attrib -r -s -h /S "Source\%CURRENTNAME%\*.blf" 1>nul 2>&1
attrib -r -s -h /S "Source\%CURRENTNAME%\*.regtrans-ms" 1>nul 2>&1
del /S "Source\%CURRENTNAME%\*.log*" 1>nul 2>&1
del /S "Source\%CURRENTNAME%\*.blf" 1>nul 2>&1
del /S "Source\%CURRENTNAME%\*.regtrans-ms" 1>nul 2>&1
del /f /q test.iso
oscdimg.exe -u1 -lProject -betfsboot.com Source test.iso
qemu.exe -boot d -cdrom "test.iso" -hda \\.\PhysicalDrive0 -m 512 -localtime -L . -net nic -net user
exit
:3
cd /d %~dp0
set /a soother=%sizeRev%-%sizeOrg%
set /a char=%soother%/2
nircmd.exe infobox "Удалите лишние символы:  %char% шт." "Внимание..."