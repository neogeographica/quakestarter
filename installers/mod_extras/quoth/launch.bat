#!/bin/bash
# & @cls & @echo off & echo Launching Quoth... & goto win

# The syntax for this launcher is 
# 		launch [filename] [options...]
# where [filename] specifies the map to launch and [options...] are parameters
# passed to the quake engine
# [filename] is stripped of it's file extensions (e.g. .bsp, .pak) then
# used as the map name to load
# If [filename] is a pak file, a copy will be installed as pak3.pak
# Set the global quothengine before running the launcher to specify a engine
# quakespasm is the default if quothengine is not set
# Values set in the quothoptions global are passed to the command line

pushd "$(dirname "$0")"
quothengine=${quothengine:-'quakespasm'}
quothoptions=${quothoptions:-'-heapsize 64000'}
if [ "$#" -gt 0 ]
then
 fname=$(basename "$1")
 mapname="+map $(echo "$fname" | sed 's/\.[^.]*$//')"
 ext=${fname:(-4)}
 if [ "$ext" = '.pak' ]
 then
  cp "$1" pak3.pak
 fi
fi
cd ..
./"$quothengine" -hipnotic -game quoth "$mapname" "$quothoptions" "${@:2}"
popd
exit 0

:win

SETLOCAL
  REM Switch to the batch file directory
CD /D "%~dp0"
  REM Get the name of the directory we are currently in
  REM to use as the -game option on the command line
FOR /f "delims==" %%F IN ("%cd%") DO SET moddir=%%~nF
  REM Add the mod selection options to the command line
SET quothoptions=-hipnotic -game %moddir% %quothoptions%

  REM clear steam variable as the PickEngine call sets it
SET steam=
CALL:PickEngine

  REM Test if we were called with a file on the command line
IF "%~n1"=="" (GOTO Randomiser)
  REM Don't let people try to launch the main pak files!
IF "%~f1"=="%~dp0pak0.pak" (
GOTO Randomiser
)
IF "%~f1"=="%~dp0pak1.pak" (
GOTO Randomiser
)
IF "%~f1"=="%~dp0pak2.pak" (
GOTO Randomiser
)
 REM The name of the file is used as the map to run
 REM This works for pak files, and for readme files
 REM The latter helps for existing single file releases
SET quothoptions=+map %~n1 %quothoptions%

  REM Test if a pak file was dropped on the batch
SET pakfile=false
IF NOT "%~x1"==".pak" (
GOTO Prelaunch
)
  REM We might have been called with a command line to a non-existent pak
IF NOT EXIST "%~f1" (
GOTO Prelaunch
)

  REM The user pak is made pak3, for the moment
  REM Don't go overriding Quoth resources as future versions may change!
COPY /y "%~f1" "%~dp0pak3.pak" > NUL
IF ERRORLEVEL 1 (GOTO PakError)
SET pakfile=true
GOTO Prelaunch

:Randomiser
  REM Randomly show off some of the test maps on some launches
SET /a "seed=%random% %% 128"

IF %seed% LEQ 15 (
set quothoptions=+map kellbase1 %quothoptions%
GOTO Prelaunch
)
IF %seed% LEQ 25 (
set quothoptions=+map kelltest1 %quothoptions%
GOTO Prelaunch
)
IF %seed% LEQ 30 (
set quothoptions=+map kelltest2 %quothoptions%
GOTO Prelaunch
)
IF %seed% LEQ 35 (
set quothoptions=+map kelltest3 %quothoptions%
GOTO Prelaunch
)
IF %seed% LEQ 40 (
set quothoptions=+map kelltest4 %quothoptions%
GOTO Prelaunch
)
IF %seed% LEQ 45 (
set quothoptions=+map kelltest5 %quothoptions%
GOTO Prelaunch
)
IF %seed% LEQ 60 (
set quothoptions=+map ne_basetest %quothoptions%
GOTO Prelaunch
)

:Prelaunch
  REM We need to be in the root quake directory when we launch
PUSHD  ..

:AddParams
  REM If called from the command line, parameters after the first are
  REM added to the launch options, but we have to shift the first
  REM one off before that is safe
IF "%2" == "" GOTO Launch
SET quothoptions=%2 %quothoptions%
SHIFT /1
GOTO AddParams

:Launch
START "" /B /WAIT %quothengine% %quothoptions%
POPD
GOTO :eof


:PakError
ECHO Quoth encountered a pak file error.
ECHO This may mean another copy of Quoth is still running.
ECHO Please check your pak files and try again.
PAUSE
GOTO :eof



:PickEngine
  REM Run through a big long list of engines in order of preference
  REM Need to be in the directory above for this
PUSHD ..

  REM First we check for engine specified by environment variable
IF EXIST "%quothengine%" (GOTO PickEngineEnd)
  REM If we're falling back to an unselected engine, throw in
  REM a few more default options
SET quothoptions=%quothoptions% -bpp 32 -heapsize 64000
  REM Next we try a few loops. If engine is set by the end of the
  REM loop we accept that engine and jump to the end
SET quothengine=
  REM Because later engines can overwrite earlier ones
  REM engines further down the list have higher priority
  REM fitzquake085.exe is top because it's been most
  REM extensively tested.
  REM Thanks to func_ for hosting the straw-poll this list
  REM was compiled from
FOR %%G IN (tyr-quake.exe
            tyr-glquake.exe
            darkplaces.exe
            RMQEngine-Win32.exe
            glquakebjp.exe
            directq.exe
            mark_v_winquake.exe
            mark_v.exe
            fitzquake5.exe
            quakespasm.exe
            fitzquake085.exe) DO (
			   IF EXIST %%G (
			   SET quothengine=%%G
			   )
			)
IF NOT "%quothengine%"=="" (GOTO PickEngineEnd)

  REM Try looking for anything fitzquake related
  REM The last alphabetically will overwrite any prior engines
  REM which in theory should also be the most recent version
FOR %%G IN (fitzquake*.exe) DO SET quothengine=%%G
IF NOT "%quothengine%"=="" (GOTO PickEngineEnd)

  REM Next a short list of older custom engines that Preach
  REM had lying around
FOR %%G IN (tq146.exe
            tq148.exe
			joequake.exe
			qmb.exe
			gltochris.exe
			tochris.exe
			mhglqr8.exe
			joequake-gl.exe
			directfitz.exe
			) DO (
			   IF EXIST %%G (
			   SET quothengine=%%G
			   )
			)
IF NOT "%quothengine%"=="" (GOTO PickEngineEnd)

  REM Stock engines - important note
  REM The stock engines won't accept a command line
  REM if they are the version from steam
  REM so we handle steam separately
IF EXIST ..\..\..\steam.dll GOTO SteamEngines

SET quothengine=glquake.exe
IF EXIST %quothengine% (
  REM glquake doesn't have dynamic resolution switching so increase from default
SET quothoptions=%quothoptions% -width 1024
GOTO PickEngineEnd
)

SET quothengine=winquake.exe
IF EXIST %quothengine% (
 REM winquake crashes playing all the demos so we only give it one
SET quothoptions=%quothoptions% +startdemos base
GOTO PickEngineEnd
)
  REM Absolute default (might not even run Quoth?)
SET quothengine=quake.exe
GOTO PickEngineEnd

:SteamEngines
  REM There's one reprieve if we're on Steam - the user may have installed 
  REM the Ultimate Quake Patch which lets us launch mods again
  REM Both glquake and winquake will have the same filesize if so
SET quothengine=glquake.exe
IF NOT EXIST winquake.exe GOTO SteamService
FOR /F %%A in ("winquake.exe") DO SET wqsize=%%~zA
FOR /F %%A in ("glquake.exe") DO SET glsize=%%~zA
IF  %wqsize% EQU %glsize% GOTO PickEngineEnd

:SteamService
SET quothengine=..\..\..\steam.exe -applaunch 2310
SET quothoptions=%quothoptions% +startdemos base
GOTO PickEngineEnd

:PickEngineEnd
POPD
GOTO :eof
