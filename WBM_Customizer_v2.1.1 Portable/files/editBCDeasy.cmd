@Echo off
cd /d %~dp0
if not exist Reversed\bootmgr\bootmgr start "" /w /min "Reversed.cmd"
set /P CURRENTNAME= < temp.tmp
set /P BCDNAME= < bcd.tmp
bootice.exe /edit_bcd /easymode /file=Source\%CURRENTNAME%\%BCDNAME%
