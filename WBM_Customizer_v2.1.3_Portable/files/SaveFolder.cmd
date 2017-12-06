@echo off
cd /d %~dp0
for /F "tokens=1-4 delims=:., " %%a in ('time/T') do set TIME=%%a%%b%%c
for /F "tokens=1-4 delims=/- " %%A in ('date/T') do set DATE=%%B%%C%%D
Chcp 1251
for /f "delims=" %%a in ('Wfolder.exe "SET TargetDir=" ..\ "Specify the folder to SAVE the project:"') do %%a
IF NOT EXIST "%TargetDir%" nircmd.exe infobox "Error folder selection!" "Warning..." & Exit
xcopy /c /s /h /y Source %TargetDir%\WBM_%DATE%.%TIME%\
chcp 866
nircmd.exe qbox "Проект извлечен в папку: %TargetDir%~nИмя проекта: WBM_%DATE%.%TIME%~nОткрыть папку, содержащую проект?" "Внимание..." explorer.exe %TargetDir%
