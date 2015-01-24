@echo ON
rem -- Automates cygwin installation

setlocal

rem -- Change to the directory of the executing batch file
CD %~dp0

set PROGNAME=setup-x86_64.exe

echo [INFO]: Downloading cygwin %PROGNAME%
Cscript.exe getFile.vbs "https://cygwin.com/%PROGNAME%" %PROGNAME%
if exist %PROGNAME% (
	echo [INFO]: Cygwin setup was downloaded
) else (
	echo [FATAL]: Cygwin setup was not downloaded
	goto end
)

rem -- Configure our paths
set SITE=ftp://mirror.switch.ch/mirror/cygwin/
set LOCALDIR=%CD%\tmp
set ROOTDIR=C:/cygwin
set OPTIONS=-q --no-desktop --download --local-install --no-verify

rem -- Do it!
echo [INFO]: Cygwin setup installing base packages
%PROGNAME% %OPTIONS% -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%"

pause

rem -- These are the packages we will install (in addition to the default packages)
set PACKAGES=mintty,wget,ctags,diffutils
set PACKAGES=%PACKAGES%,gcc4,make,automake,autoconf,readline,libncursesw-devel,libiconv
set PACKAGES=%PACKAGES%,colorgcc,colordiff,bvi,gawk
rem SET PACKAGES=%PACKAGES%,lua,perl,python,ruby
set PACKAGES=%PACKAGES%,bc,gnuplot
set PACKAGES=%PACKAGES%,inetutils,ncurses,openssh,openssl,vim,mc,multitail

echo [INFO]: Cygwin setup installing custom packages:
echo %PACKAGES%
%PROGNAME% %OPTIONS% -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%" -P %PACKAGES%

endlocal

pause
exit /B 0

