@Echo off
cd /d %~dp0
set /P CURRENTNAME= < temp.tmp
set /P BCDNAME= < bcd.tmp
copy /y Reversed\bcd\bcd Source\%CURRENTNAME%\%BCDNAME%
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
nircmd.exe qboxcomtop "Запустить виртуальную машину ~nQemu, для тестирования?" "Внимание..." "execmd" qemu.cmd