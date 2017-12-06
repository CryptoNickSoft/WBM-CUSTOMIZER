@Echo off
cd /d %~dp0
del /f /q temp.tmp
del /f /q bcd.tmp
cd /d %~dp0Source
for /d %%B in (*) do set CURRENTNAME=%%B
cd /d %~dp0
Echo %CURRENTNAME%>> temp.tmp
copy /y Source\%CURRENTNAME%\bcd.tmp bcd.tmp
if not exist bcd.tmp Echo bcd>>bcd.tmp
set /P BCDNAME= < bcd.tmp
rem Unpack BOOTMGR.EXE.MUI
copy /y Source\%CURRENTNAME%\ru-RU\!bootmgr.exe.mui! Reversed\mui\bootmgr.exe.mui
copy /y Source\%CURRENTNAME%\ru-RU\bootmgr.exe.mui Reversed\mui\bootmgr.exe.mui
ResHackerFX.exe -extract Reversed\mui\bootmgr.exe.mui, "XSL.rc",23,,1049
del /f /q ResHackerFX.log, XSL.rc
copy /y Data_1.bin Reversed\mui\BOOTMGR.XSL
copy /y Data_1.bin Reversed\mui\BOOTMGR.ORG.XSL
move /y Data_1.bin BackUp\mui\BOOTMGR.XSL
rem BackUp BCD
copy /y Source\%CURRENTNAME%\%BCDNAME% Reversed\bcd\bcd
rem Unpack BOOTMGR
copy /y Source\bootmgr Reversed\bootmgr\bootmgr
bmzip.exe Reversed\bootmgr\bootmgr Reversed\bootmgr\bootmgr.exe
copy /y Reversed\bootmgr\bootmgr.exe Reversed\bootmgr\bootmgr.ORG.exe
ResHackerFX.exe -extract Reversed\bootmgr\bootmgr.exe, "XSL.rc",23,,
del /f /q ResHackerFX.log, XSL.rc
copy /y Data_1.bin Reversed\bootmgr\BOOTMGR.XSL
copy /y Data_1.bin BackUp\bootmgr\BOOTMGR.XSL
copy /y Data_1.bin BackUp\bootmgr\BOOTMGR.ORG.XSL
if exist Data_2.bin (
for  %%a in (Data_1.bin) do set sizeXSL=%%~za & goto 1
:1
for  %%a in (Data_2.bin) do set sizeSOOTHER=%%~za & goto 2
:2
set /a OrgXSL=%sizeXSL%+%sizeSOOTHER%
fsutil file createnew Data_3.bin %OrgXSL%
del /f /q Data_1.bin
del /f /q Data_2.bin
move /y Data_3.bin Reversed\bootmgr\BOOTMGR.ORG.XSL
exit
)
move /y Data_1.bin Reversed\bootmgr\BOOTMGR.ORG.XSL
exit



