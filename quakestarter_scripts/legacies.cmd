@echo off

REM Installer for stuff that has been removed from the main menus.
REM Periodically things will get culled from here as well.

REM set the default value to return if "check" arg is used
set show_legacies_menu=false

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

:menu
set show_rating=false
set show_version=false
call :installed_check arcane rating
call :installed_check fmb_bdg rating
call :installed_check copper_v1_17 version
call :installed_check ctsj2 version

REM if called with "check" arg just decide whether to show this menu at all
if "%~1"=="check" (
  if "%show_rating%"=="true" goto :checksuccess
  if "%show_version%"=="true" goto :checksuccess
  goto :eof
)

if "%show_rating%"=="false" (
  if "%show_version%"=="false" (
    goto :eof
  )
)

set renamed_gamedir=
set review_page=
set base_game=
set patch_url=
set patch_required=false
set patch_skipfiles=
set patch2_url=
set patch2_required=false
set patch2_skipfiles=
set start_map=
set extra_launch_args=
set prelaunch_msg[0]=
set postlaunch_msg[0]=
set skip_quakerc_gen=false
set modsettings[0]=
set startdemos=
set junkdirs=
cls
echo.
echo Releases shown here were in the installer menus in previous versions but have
echo since been removed. If a release stays on this legacies menu for six 
echo uninterrupted months, it will be removed from the legacies menu too.
echo.
if not "%force_show_legacies%"=="true" (
  echo Only currently installed releases will be shown here, since the
  echo force_show_legacies option is false in the config.
  echo.
)
if "%show_rating%"=="true" (
  echo Dropped because of a change in rating or criteria:
  if "%show_arcane%"=="true" (
    echo %is_arcane_installed%  1: arcane - Arcane ^(1997^)
  )
  if "%show_fmb_bdg%"=="true" (
    echo %is_fmb_bdg_installed%  2: fmb_bdg - This Onion ^(2007^)
  )
  echo.
)
if "%show_version%"=="true" (
  echo Dropped because superseded by a newer version:
  if "%show_copper_v1_17%"=="true" (
    echo %is_copper_v1_17_installed%  3: copper_v1_17 - Copper 1.17 ^(2021^)
  )
  if "%show_ctsj2%"=="true" (
    echo %is_ctsj2_installed%  4: ctsj2 - Coppertone Summer Jam 2 v1.0 ^(2022^)
  )
  echo.
)
echo Enter a number to install/launch/manage one of the releases above.
echo.
echo Or, to just view its Quaddicted page, use Shift+Enter to submit your
echo choice; keep holding shift until the webpage opens.
echo.
set menu_choice=:eof
set /p menu_choice=enter your choice or just press Enter to exit:
echo.
goto %menu_choice%


REM Arcane should age out after 3/20/2023
:1
if not "%show_arcane%"=="true" (
  goto :eof
)
set start_map=arcane
call "%scriptspath%_handle_mod_choice.cmd" arcane
goto :menu

REM This Onion should age out after 3/20/2023
:2
if not "%show_fmb_bdg%"=="true" (
  goto :eof
)
set start_map=fmb_bdg1
call "%scriptspath%_handle_mod_choice.cmd" fmb_bdg
goto :menu

REM Copper 1.17 should age out after 1/10/2023
:3
if not "%show_copper_v1_17%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" copper_v1_17
goto :menu

REM Coppertone Summer Jam 2 v1.0 should age out after 2/11/2023
:4
if not "%show_ctsj2%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ctsj2
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
  set show_%1=true
  set show_%2=true
) else (
  set is_%1_installed= 
  if "%force_show_legacies%"=="true" (
    set show_%1=true
    set show_%2=true
  ) else (
    set show_%1=false
  )
)
goto :eof

:checksuccess
endlocal
set show_legacies_menu=true
goto :eof
