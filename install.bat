@ECHO OFF
REM -- Automates cygwin installation

SETLOCAL

REM -- Change to the directory of the executing batch file
CD %~dp0

REM -- Configure our paths
SET SITE=http://mirror.cs.vt.edu/pub/cygwin/cygwin/
SET LOCALDIR=%CD%
SET ROOTDIR=C:/cygwin

REM -- These are the packages we will install (in addition to the default packages)
SET PACKAGES=mintty,gcc4,make,readline,diffutils,ctags,vim,git,git-completion,git-svn,stgit,tig,libncurses9

REM -- Do it!
setup -q -d -D -L -s %SITE% -l "%LOCALDIR%" -R "%ROOTDIR%" -P %PACKAGES%

REM -- Show what we did
ECHO.
ECHO.
ECHO cygwin installation updated
ECHO  - %PACKAGES%
ECHO.

ENDLOCAL

PAUSE
EXIT /B 0
