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

set SITE=ftp://mirror.switch.ch/mirror/cygwin/
set LOCALDIR=%CD%\tmp
set ROOTDIR=C:/cygwin
set OPTIONS=-q --no-desktop --download --local-install --no-verify

if "%1" == "" goto FRESH_INSTALL

	echo [INFO]: Cygwin setup post-install package(s):
	echo [INFO]: For more packages go to http://grasswiki.osgeo.org/wiki/Cygwin_Packages
	set PACKAGES=%1
	echo %PACKAGES%
	%PROGNAME% %OPTIONS% -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%" -P %PACKAGES%

	goto DONE

:FRESH_INSTALL

	if exist %ROOTDIR% (
		echo [FATAL]: Cygwin root dir already exists!
		goto ERROR
	)

		pause

	echo [INFO]: Cygwin setup installing base packages
	%PROGNAME% %OPTIONS% -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%"

	echo [INFO]: For more packages go to http://grasswiki.osgeo.org/wiki/Cygwin_Packages

	rem -- These are the packages we will install (in addition to the default packages)
	set PACKAGES=mintty,wget,ctags,diffutils
	set PACKAGES=%PACKAGES%,gcc4,make,automake,autoconf,readline,libncursesw-devel,libiconv
	set PACKAGES=%PACKAGES%,colorgcc,colordiff,bvi,gawk
	set PACKAGES=%PACKAGES%,bc,gnuplot
	set PACKAGES=%PACKAGES%,inetutils,ncurses,openssh,openssl,vim,mc,multitail,dos2unix,irssi
	set PACKAGES=%PACKAGES%,screen

	echo [INFO]: Cygwin setup installing custom packages:
	echo %PACKAGES%
	%PROGNAME% %OPTIONS% -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%" -P %PACKAGES%

:ERROR
	echo [INFO]: cannot continue
:DONE

endlocal
exit /B 0

