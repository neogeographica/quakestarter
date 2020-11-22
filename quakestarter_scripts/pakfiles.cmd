@echo off

REM Try to find pak files on this computer and copy them here.

setlocal

REM remember dir where this script lives
set scriptspath=%~dp0

REM find the basedir by looking for id1 folder here or above one level
set basedir=
pushd "%~dp0"
dir id1 /ad >nul 2>&1
if not %errorlevel% equ 0 (
  cd ..
  dir id1 /ad >nul 2>&1
)
if %errorlevel% equ 0 (
  set basedir=%cd%
)
popd
if "%basedir%"=="" (
  echo Couldn't find the id1 folder.
  pause
  goto :eof
)

cls

echo This script will look for pak files ^(Quake game data^) that are already
echo on this computer's disks, and copy them into this Quake installation.
echo.

echo For the original Quake campaign:
call "%scriptspath%_install_quakefiles.cmd" id1 pak0.pak
call "%scriptspath%_install_quakefiles.cmd" id1 pak1.pak
echo.
echo For missionpack 1:
call "%scriptspath%_install_quakefiles.cmd" hipnotic pak0.pak
echo.
echo For missionpack 2:
call "%scriptspath%_install_quakefiles.cmd" rogue pak0.pak
echo.

set missing_anypak=false
set missing_id1pak=false
if not exist "%basedir%\id1\pak0.pak" set missing_id1pak=true
if not exist "%basedir%\id1\pak1.pak" set missing_id1pak=true
if "%missing_id1pak%"=="true" (
  set missing_anypak=true
  echo To play Quake, you will need both "pak0.pak" and "pak1.pak" from the
  echo original Quake game data to be placed inside this folder:
  echo   %basedir%\id1
  echo One or both of those pak files are currently missing.
  echo.
)
if not exist "%basedir%\hipnotic\pak0.pak" (
  set missing_anypak=true
  echo To play missionpack 1, you will need to put its "pak0.pak" file inside
  echo this folder:
  echo   %basedir%\hipnotic
  echo You don't need that file if you don't want to play that missionpack
  echo or content that depends on it.
  echo.
)
if not exist "%basedir%\rogue\pak0.pak" (
  set missing_anypak=true
  echo To play missionpack 2, you will need to put its "pak0.pak" file inside
  echo this folder:
  echo   %basedir%\rogue
  echo You don't need that file if you don't want to play that missionpack
  echo or content that depends on it.
  echo.
)
if "%missing_anypak%"=="true" (
  echo See the "quakestarter_docs\other_stuff\pak_files.txt" file for more info about
  echo pak files and how to get them.
  echo.
)

pause

