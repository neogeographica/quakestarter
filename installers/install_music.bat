@echo off

REM Installer for campaign/missionpack soundtrack files.

REM save working dir and change to dir that holds this script
pushd "%~dp0"

REM set the Mark V executable to use
set markv_exe=mark_v.exe

REM CD up to Mark V dir if necessary
if not exist "%markv_exe%" (
  cd ..
  if not exist "%markv_exe%" (
    echo Couldn't find "%markv_exe%" in this folder or parent folder.
    pause
    goto :exit
  )
)

:menu
cls
call :music_installed_check id1
call :music_installed_check hipnotic
call :music_installed_check rogue
echo(
echo Soundtrack files to install for main campaign or missionpacks:
echo 1: id1\music - original campaign%id1_music_installed%
if exist hipnotic (
  echo 2: hipnotic\music - Scourge of Armagon%hipnotic_music_installed%
) else (
  echo    ^(missionpack 1 not present^)
)
if exist rogue (
  echo 3: rogue\music - Dissolution of Eternity%rogue_music_installed%
) else (
  echo    ^(missionpack 2 not present^)
)
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if not exist id1 (
  echo The "id1" gamedir does not exist.
  echo Check your Quake files setup!
) else (
  if exist id1\music (
    echo The "id1\music" folder already exists.
  ) else (
    call "%~dp0\_mod_patch_install.cmd" http://www.eclecticmenagerie.com/jl/quake/quake_campaign_soundtrack_markv.zip id1 music_placeholder_delete_me.pak
  )
)
pause
goto :menu

:2
if not exist hipnotic (
  echo The "hipnotic" gamedir does not exist.
  echo Do you have that missionpack installed?
) else (
  if exist hipnotic\music (
    echo The "hipnotic\music" folder already exists.
  ) else (
    call "%~dp0\_mod_patch_install.cmd" http://www.eclecticmenagerie.com/jl/quake/quake_mp1_soundtrack_markv.zip hipnotic music_placeholder_delete_me.pak
  )
)
pause
goto :menu

:3
if not exist rogue (
  echo The "rogue" gamedir does not exist.
  echo Do you have that missionpack installed?
) else (
  if exist rogue\music (
    echo The "rogue\music" folder already exists.
  ) else (
    call "%~dp0\_mod_patch_install.cmd" http://www.eclecticmenagerie.com/jl/quake/quake_mp2_soundtrack_markv.zip rogue music_placeholder_delete_me.pak
  )
)
pause
goto :menu

:menu_exit
popd
goto :eof


REM function used above
:music_installed_check
if exist "%1\music" (
  set %1_music_installed= - already installed
) else (
  set %1_music_installed=
)
