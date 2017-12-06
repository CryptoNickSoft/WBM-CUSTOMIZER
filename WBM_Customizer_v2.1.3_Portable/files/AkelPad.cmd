@echo off
cd /d %~dp0
copy "AkelPad_x86.exe" "AkelPad.exe"
start "" "AkelPad.exe"