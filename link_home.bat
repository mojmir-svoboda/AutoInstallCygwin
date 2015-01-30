
set ROOTDIR=C:\cygwin
ren %ROOTDIR%\home\%USERNAME% %USERNAME%.old
mklink /J %ROOTDIR%\home\%USERNAME% %HOMEPATH%"
