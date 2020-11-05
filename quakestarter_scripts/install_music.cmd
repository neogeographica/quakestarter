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
  echo Couldn't find the id1 folder in this script's folder or parent folder.
  pause
  goto :eof
)

REM set common var used for _install_patch.cmd
set no_cleanup=true

:menu
cls
call :music_installed_check id1
call :music_installed_check hipnotic
call :music_installed_check rogue
echo.
echo Soundtrack files for main campaign or missionpacks:
echo %id1_music_installed%  1: id1\music - original campaign
if exist "%basedir%\hipnotic" (
  echo %hipnotic_music_installed%  2: hipnotic\music - Scourge of Armagon
) else (
  echo       ^(missionpack 1 not present^)
)
if exist "%basedir%\rogue" (
  echo %rogue_music_installed%  3: rogue\music - Dissolution of Eternity
) else (
  echo       ^(missionpack 2 not present^)
)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
if not exist "%basedir%\id1" (
  echo The "id1" gamedir does not exist.
  echo Check your Quake files setup!
) else (
  if exist "%basedir%\id1\music" (
    echo The "id1\music" folder already exists.
  ) else (
    call "%scriptspath%_install_patch.cmd" https://www.quaddicted.com/files/music/quake_campaign_soundtrack.zip id1
    if "%patch_success%"=="false" (
      rd /q /s "%basedir%\id1\music" >nul 2>&1
    )
  )
)
pause
goto :menu

:2
if not exist "%basedir%\hipnotic" (
  echo The "hipnotic" gamedir does not exist.
  echo Do you have that missionpack installed?
) else (
  if exist "%basedir%\hipnotic\music" (
    echo The "hipnotic\music" folder already exists.
  ) else (
    call "%scriptspath%_install_patch.cmd" https://www.quaddicted.com/files/music/quake_mp1_soundtrack.zip hipnotic
    if "%patch_success%"=="false" (
      rd /q /s "%basedir%\hipnotic\music" >nul 2>&1
    )
  )
)
pause
goto :menu

:3
if not exist "%basedir%\rogue" (
  echo The "rogue" gamedir does not exist.
  echo Do you have that missionpack installed?
) else (
  if exist "%basedir%\rogue\music" (
    echo The "rogue\music" folder already exists.
  ) else (
    call "%scriptspath%_install_patch.cmd" https://www.quaddicted.com/files/music/quake_mp2_soundtrack.zip rogue
    if "%patch_success%"=="false" (
      rd /q /s "%basedir%\rogue\music" >nul 2>&1
    )
  )
)
pause
goto :menu


REM function used above
:music_installed_check
if exist "%basedir%\%1\music" (
  set %1_music_installed=*
) else (
  set %1_music_installed= 
)
