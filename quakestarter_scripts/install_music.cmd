@echo off

REM Installer for campaign/missionpack soundtrack files.

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

REM set common vars used for _install_patch.cmd and _install_mod.cmd.
set no_cleanup=true
set cleanup_archive=%cleanup_soundtrack_archive%
REM Stuff outside the music directory in the downloaded patch zips can be
REM interesting, but for consistency with the find-and-copy behavior we'll
REM only deal with the music directory.
set skipfiles=tracklist.cfg quake_campaign_soundtrack_readme.txt quake_mp1_soundtrack_readme.txt  quake_mp2_soundtrack_readme.txt

:menu
cls
call :music_installed_check id1
call :music_installed_check hipnotic
call :music_installed_check rogue
echo.
echo Soundtrack files for main campaign or missionpacks:
echo %is_id1_music_installed%  1: id1\music - original campaign
if exist "%basedir%\hipnotic" (
  echo %is_hipnotic_music_installed%  2: hipnotic\music - Scourge of Armagon
) else (
  echo       ^(missionpack 1 not present^)
)
if exist "%basedir%\rogue" (
  echo %is_rogue_music_installed%  3: rogue\music - Dissolution of Eternity
) else (
  echo       ^(missionpack 2 not present^)
)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
call :handle_choice id1 https://www.quaddicted.com/files/music/quake_campaign_soundtrack.zip
pause
goto :menu

:2
call :handle_choice hipnotic https://www.quaddicted.com/files/music/quake_mp1_soundtrack.zip
pause
goto :menu

:3
call :handle_choice rogue https://www.quaddicted.com/files/music/quake_mp2_soundtrack.zip
pause
goto :menu


REM functions used above

:music_installed_check
if exist "%basedir%\%1\music" (
  set is_%1_music_installed=*
) else (
  set is_%1_music_installed= 
)
goto :eof

:handle_choice
set gamedir=%~1
set url=%~2
if not exist "%basedir%\%gamedir%" (
  echo The "%gamedir%" gamedir does not exist.
  echo Check your Quake files setup!
  echo.
  goto :eof
)
if exist "%basedir%\%gamedir%\music" (
  echo The "%gamedir%\music" folder already exists.
  echo.
  goto :eof
)
call "%scriptspath%_install_quakefiles.cmd" "%gamedir%" music
echo.
if exist "%basedir%\%gamedir%\music" goto :eof
set /p choice=Would you like to download it? ([y]/n):
if "%choice%"=="n" goto :eof
if "%choice%"=="N" goto :eof
call "%scriptspath%_install_patch.cmd" "%url%" "%gamedir%"
if "%patch_success%"=="false" (
  rd /q /s "%basedir%\%gamedir%\music" >nul 2>&1
)
goto :eof
