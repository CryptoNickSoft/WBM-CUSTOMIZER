@echo off
cd /d %~dp0
if not exist test.iso nircmd.exe infobox "��ࠧ ��᪠ �� �� ᮧ���!" "��������..." & exit
for /F "tokens=1-4 delims=:., " %%a in ('time/T') do set TIME=%%a%%b%%c
for /F "tokens=1-4 delims=/- " %%A in ('date/T') do set DATE=%%B%%C%%D
Chcp 1251
for /f "delims=" %%a in ('Wfolder.exe "SET TargetDir=" ..\ "Specify the folder to SAVE the disk image:"') do %%a
IF NOT EXIST "%TargetDir%" nircmd.exe infobox "Error folder selection!" "Warning..." & Exit
copy /y test.iso %TargetDir%\WBM_%DATE%.%TIME%.iso
chcp 866
nircmd.exe qbox "�஥�� �����祭 � �����: %TargetDir%~n��� ��ࠧ�: WBM_%DATE%.%TIME%.iso~n������ �����, ᮤ�ঠ��� �஥��?" "��������..." explorer.exe %TargetDir%