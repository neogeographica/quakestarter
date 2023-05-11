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
call :installed_check rpgsmse rating
call :installed_check arwop rating
call :installed_check dmc3 rating
call :installed_check its_demo_v1_1
call :installed_check sm198 rating
call :installed_check jjj2 rating
call :installed_check dwellv1p2 version
call :installed_check copper_v1_19 version
call :installed_check toneodspmp3_2_3 version

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
  if "%show_rpgsmse%"=="true" (
    echo %is_rpgsmse_installed%  1: rpgsmse - Quake Condensed ^(2004^)
  )
  if "%show_arwop%"=="true" (
    echo %is_arwop_installed%  2: arwop - A Roman Wilderness Of Pain ^(2009^)
  )
  if "%show_dmc3%"=="true" (
    echo %is_dmc3_installed%  3: dmc3 - Deathmatch Classics Vol. 3 ^(2011^)
  )
  if "%show_its_demo_v1_1%"=="true" (
    echo %is_its_demo_v1_1_installed%  4: its_demo_v1_1 - In The Shadows [Demo v1.1] ^(2012^)
  )
  if "%show_sm198%"=="true" (
    echo %is_sm198_installed%  5: sm198 - 768^^2 ^(2019^)
  )
  if "%show_jjj2%"=="true" (
    echo %is_jjj2_installed%  6: jjj2 - January Jump Jam 2 ^(2022^)
  )
  echo.
)
if "%show_version%"=="true" (
  echo Dropped because superseded by a newer version:
  if "%show_dwellv1p2%"=="true" (
    echo %is_dwellv1p2_installed%  7: dwellv1p2 - Dwell - Episode 1 ^(2020^)
  )
  if "%show_copper_v1_19%"=="true" (
    echo %is_copper_v1_19_installed%  8: copper_v1_19 - Copper 1.19 ^(2022^)
  )
  if "%show_toneodspmp3_2_3%"=="true" (
    echo %is_toneodspmp3_2_3_installed%  9: toneodspmp3_2_3 - Empire of Disorder v2.3 ^(2022^)
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


REM Quake Condensed should age out after 7/30/2023
:1
if not "%show_rpgsmse%"=="true" (
  goto :eof
)
set start_map=rpgsmse1
call "%scriptspath%_handle_mod_choice.cmd" rpgsmse
goto :menu

REM A Roman Wilderness Of Pain should age out after 7/30/2023
:2
if not "%show_arwop%"=="true" (
  goto :eof
)
set start_map=start
set startdemos=demo1
call "%scriptspath%_handle_mod_choice.cmd" arwop
goto :menu

REM Deathmatch Classics Vol. 3 should age out after 7/30/2023
:3
if not "%show_dmc3%"=="true" (
  goto :eof
)
set patch_url=https://quaketastic.com/files/single_player/maps/dmc3m8_hotfix.zip
set start_map=dmc3
call "%scriptspath%_handle_mod_choice.cmd" dmc3
goto :menu

REM In The Shadows [Demo v1.1] should age out after 7/30/2023
:4
if not "%show_its_demo_v1_1%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
set prelaunch_msg[0]=This mod supports some unique stealth gameplay; be sure to check the
set prelaunch_msg[1]=readme for tips!
set prelaunch_msg[2]=
call "%scriptspath%_handle_mod_choice.cmd" its_demo_v1_1
goto :menu

REM 768^^2 should age out after 7/30/2023
:5
if not "%show_sm198%"=="true" (
  goto :eof
)
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" sm198
goto :menu

REM January Jump Jam 2 should age out after 7/30/2023
:6
if not "%show_jjj2%"=="true" (
  goto :eof
)
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/jjj2_ish.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" jjj2
goto :menu

REM Dwell - Episode 1 should age out after 8/7/2023
:7
if not "%show_dwellv1p2%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" dwellv1p2
goto :menu

REM Copper 1.19 should age out after 7/30/2023
:8
if not "%show_copper_v1_19%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" copper_v1_19
goto :menu

REM Empire of Disorder v2.3 should age out after 7/30/2023
:9
if not "%show_toneodspmp3_2_3%"=="true" (
  goto :eof
)
set review_page=https://www.quaddicted.com/reviews/toneodspmp3_2_2.html
set start_map=eod_intro
call "%scriptspath%_handle_mod_choice.cmd" toneodspmp3_2_3
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
