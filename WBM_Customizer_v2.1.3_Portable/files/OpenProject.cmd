@echo off
cd /d %~dp0
Chcp 1251
for /f "delims=" %%a in ('Wfolder.exe "SET TargetDir=" ..\ "Please select project folder:"') do %%a
IF NOT EXIST "%TargetDir%" nircmd.exe infobox "Error folder selection!" "Warning..." & Exit
chcp 866
IF NOT EXIST "%TargetDir%\bootmgr" nircmd.exe infobox "����� ���०���� ��� ����������!" "��������..." & Exit
nircmd.exe killprocess AkelPad_x86.exe
nircmd.exe killprocess qemu.exe
nircmd.exe killprocess ButtonBar.exe
del /f /q Reversed\bootmgr\*
del /f /q Reversed\mui\*
del /f /q Reversed\bcd\*
del /f /q BackUp\bootmgr\*
del /f /q BackUp\mui\*
rmdir .\Source /s /q
mkdir .\Source
del /f /q test.iso
del /f /q temp.tmp
del /f /q bcd.tmp
del /f /q *.jpg
xcopy /c /s /h /y %TargetDir% Source
nircmd.exe qboxcomtop "����� �஥�� ����㦥��.~n�������� ����㠫��� ��設� ~nQemu, ��� ���஢����?" "��������..."  "execmd" qemu.cmd