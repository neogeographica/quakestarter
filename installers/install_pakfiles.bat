@echo off

REM Try to find pak files on this computer and copy them here.

REM save working dir and change to dir that holds this script
pushd "%~dp0"

REM We're not going to use Mark V to download anything in this script, but
REM let's try our standard approach of using mark_v.exe to find the Quake
REM basedir. If that doesn't work then also look for the id1 folder.
set markv_exe=mark_v.exe
if not exist "%markv_exe%" (
  if not exist "id1" (
    cd ..
    if not exist "%markv_exe%" (
      if not exist "id1" (
        echo Couldn't find "%markv_exe%" or "id1" in this folder or parent folder.
        pause
        goto :exit
      )
    )
  )
)
set basedir=%cd%

cls

echo This script will look for pak files ^(Quake game data^) that are already
echo on this computer's disks, and copy them into this Quake installation.
echo(

echo For the original Quake campaign:
call :find_pakfile id1 pak0.pak
call :find_pakfile id1 pak1.pak
echo(
echo For missionpack 1:
call :find_pakfile hipnotic pak0.pak
echo(
echo For missionpack 2:
call :find_pakfile rogue pak0.pak
echo(

set missing_anypak=false
set missing_id1pak=false
if not exist "id1\pak0.pak" set missing_id1pak=true
if not exist "id1\pak1.pak" set missing_id1pak=true
if "%missing_id1pak%"=="true" (
  set missing_anypak=true
  echo To play Quake, you will need both "pak0.pak" and "pak1.pak" from the
  echo original Quake game data to be placed inside this folder:
  echo   "%basedir%\id1"
  echo One or both of those pak files are currently missing.
  echo(
)
if not exist "hipnotic\pak0.pak" (
  set missing_anypak=true
  echo To play missionpack 1, you will need to put its "pak0.pak" file inside
  echo this folder:
  echo   "%basedir%\hipnotic"
  echo You don't need that file if you don't want to play that missionpack.
  echo(
)
if not exist "rogue\pak0.pak" (
  set missing_anypak=true
  echo To play missionpack 2, you will need to put its "pak0.pak" file inside
  echo this folder:
  echo   "%basedir%\rogue"
  echo You don't need that file if you don't want to play that missionpack.
  echo(
)
if "%missing_anypak%"=="true" (
  echo See the "readmes\other_stuff\pak_files.txt" file for more info about
  echo pak files and how to get them.
  echo(
)

:exit
pause
popd
goto :eof


REM function used above

:find_pakfile
set gamedir=%~1
set pak_file=%~2
set target_gamedir=%basedir%\%gamedir%
set target_pakfile=%basedir%\%gamedir%\%pak_file%

if exist "%target_pakfile%" (
  echo "%gamedir%\%pak_file%" already exists.
  goto :eof
)

echo Looking for "%gamedir%\%pak_file%" ...

set found_file=false

REM first check registry for Steam or GOG Quake installs
set dirs_checked=
call :reg_query_and_copy "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2310" InstallLocation
if exist "%target_pakfile%" goto :eof
call :reg_query_and_copy "HKLM\SOFTWARE\WOW6432Node\GOG.com\Games\1435828198" PATH
if exist "%target_pakfile%" goto :eof

REM handle older Steam installs
call :reg_query_path_root_and_copy "HKCU\SOFTWARE\Valve\Steam" SteamPath "steamapps\common\Quake"
if exist "%target_pakfile%" goto :eof

REM no luck there, so let's look in the usual locations

setlocal EnableDelayedExpansion
set drives=
for /f "delims=: tokens=1,*" %%a in ('fsutil fsinfo drives') do (
  for %%c in (%%b) do (
    set drive=%%c
    >nul 2>&1 vol !drive:\=! && set drives=!drives! %%c
  )
)
call :find_and_copy_from "Quake"
if exist "%target_pakfile%" goto :eof
call :find_and_copy_from "Games\Quake"
if exist "%target_pakfile%" goto :eof
set temp=Program Files (x86)\Quake
call :find_and_copy_from "%temp%"
if exist "%target_pakfile%" goto :eof
set temp=Program Files (x86)\Steam\steamapps\common\Quake
call :find_and_copy_from "%temp%"
if exist "%target_pakfile%" goto :eof
call :find_and_copy_from "Program Files\Steam\steamapps\common\Quake"
if exist "%target_pakfile%" goto :eof
call :find_and_copy_from "Games\Steam\steamapps\common\Quake"
if exist "%target_pakfile%" goto :eof
call :find_and_copy_from "Steam\steamapps\common\Quake"
if exist "%target_pakfile%" goto :eof
call :find_and_copy_from "GOG Games\Quake"
if exist "%target_pakfile%" goto :eof
endlocal

if "%found_file%"=="false" (
  echo Couldn't find "%gamedir%\%pak_file%" in the usual locations.
)

goto :eof


REM subroutines used by find_pakfile

:reg_query_and_copy
reg query "%~1" /v "%~2" > nul 2>&1
if %errorlevel% equ 0 (
  for /f "tokens=2,* skip=2" %%a in ('reg query "%~1" /v "%~2"') do (
    call :handle_reg_query_copy "%%b"
  )
)
goto :eof

:reg_query_path_root_and_copy
reg query "%~1" /v "%~2" > nul 2>&1
if %errorlevel% equ 0 (
  for /f "tokens=2,* skip=2" %%a in ('reg query "%~1" /v "%~2"') do (
    call :handle_reg_query_copy "%%b\%~3"
  )
)
goto :eof

:handle_reg_query_copy
set fullpath=%~1
set backslashed=%fullpath:/=\%
call :conditional_copy "%backslashed%"
set dirs_checked=%dirs_checked% "%backslashed%"
goto :eof

:find_and_copy_from
for %%a in (%drives%) do (
  call :conditional_copy "%%a%~1"
  if exist "%target_pakfile%" goto :eof
)
goto :eof

:conditional_copy
for %%d in (%dirs_checked%) do (
  if /i %%d=="%~1" goto :eof
)
if exist "%~1\%gamedir%\%pak_file%" (
  call :copy_to_target "%~1\%gamedir%\%pak_file%"
)
goto :eof

:copy_to_target
set found_file=true
set menu_choice=y
set /p menu_choice=Found "%~1", ok to copy and use that file? ([y]/n):
if /i "%menu_choice%"=="y" (
  echo Copying "%~1" into "%target_gamedir%"...
  md "%target_gamedir%" 2> nul
  copy /y "%~1" "%target_gamedir%" > nul
)
goto :eof
