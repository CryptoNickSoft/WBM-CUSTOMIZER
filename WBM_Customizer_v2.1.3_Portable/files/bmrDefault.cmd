@Echo off
cd /d %~dp0
copy /y Original\bootmgr Reversed\bootmgr\bootmgr
bmzip.exe Reversed\bootmgr\bootmgr Reversed\bootmgr\bootmgr.ORG.exe
nircmd.exe execmd bmrEdit.cmd
exit