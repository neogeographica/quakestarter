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
call :installed_check koohoo rating
call :installed_check czgtoxic rating
call :installed_check rpgsmse rating
call :installed_check sm82 rating
call :installed_check ant rating
call :installed_check fmb_bdg rating
call :installed_check arwop rating
call :installed_check dmc3 rating
call :installed_check its_demo_v1_1
call :installed_check retrojam4dlc_pulsar rating
call :installed_check sm198 rating
call :installed_check jjj2 rating
call :installed_check plaw02 rating
call :installed_check markiesm1v2 rating
call :installed_check copper_v1_19 version
call :installed_check ctsj2 version
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
  if "%show_arcane%"=="true" (
    echo %is_arcane_installed%  1: arcane - Arcane ^(1997^)
  )
  if "%show_koohoo%"=="true" (
    echo %is_koohoo_installed%  2: koohoo - The Castle of Koohoo ^(2001^)
  )
  if "%show_czgtoxic%"=="true" (
    echo %is_czgtoxic_installed%  3: czgtoxic - Biotoxin ^(2001^)
  )
  if "%show_rpgsmse%"=="true" (
    echo %is_rpgsmse_installed%  4: rpgsmse - Quake Condensed ^(2004^)
  )
  if "%show_sm82%"=="true" (
    echo %is_sm82_installed%  5: sm82 - Rubicondom ^(2005^)
  )
  if "%show_ant%"=="true" (
    echo %is_ant_installed%  6: ant - Antediluvian ^(2005^)
  )
  if "%show_fmb_bdg%"=="true" (
    echo %is_fmb_bdg_installed%  7: fmb_bdg - This Onion ^(2007^)
  )
  if "%show_arwop%"=="true" (
    echo %is_arwop_installed%  8: arwop - A Roman Wilderness Of Pain ^(2009^)
  )
  if "%show_dmc3%"=="true" (
    echo %is_dmc3_installed%  9: dmc3 - Deathmatch Classics Vol. 3 ^(2011^)
  )
  if "%show_its_demo_v1_1%"=="true" (
    echo %is_its_demo_v1_1_installed% 10: its_demo_v1_1 - In The Shadows [Demo v1.1] ^(2012^)
  )
  if "%show_retrojam4dlc_pulsar%"=="true" (
    echo %is_retrojam4dlc_pulsar_installed% 11: retrojam4dlc_pulsar - The Elder Reality ^(2016^)
  )
  if "%show_sm198%"=="true" (
    echo %is_sm198_installed% 12: sm198 - 768^^2 ^(2019^)
  )
  if "%show_jjj2%"=="true" (
    echo %is_jjj2_installed% 13: jjj2 - January Jump Jam 2 ^(2022^)
  )
  if "%show_plaw02%"=="true" (
    echo %is_plaw02_installed% 14: plaw02 - Waldsterben ^(2022^)
  )
  if "%show_markiesm1v2%"=="true" (
    echo %is_markiesm1v2_installed% 15: markiesm1v2 - Slip Tripping ^(2022^)
  )
  echo.
)
if "%show_version%"=="true" (
  echo Dropped because superseded by a newer version:
  if "%show_copper_v1_19%"=="true" (
    echo %is_copper_v1_19_installed% 16: copper_v1_19 - Copper 1.19 ^(2022^)
  )
  if "%show_ctsj2%"=="true" (
    echo %is_ctsj2_installed% 17: ctsj2 - Coppertone Summer Jam 2 v1.0 ^(2022^)
  )
  if "%show_toneodspmp3_2_3%"=="true" (
    echo %is_toneodspmp3_2_3_installed% 18: toneodspmp3_2_3 - Empire of Disorder v2.3 ^(2022^)
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

REM The Castle of Koohoo should age out after 4/6/2023
:2
if not "%show_koohoo%"=="true" (
  goto :eof
)
set start_map=start
set modsettings[0]=r_wateralpha 0.6
set modsettings[1]=r_shadows 0
set modsettings[2]=gl_flashblend 0
set modsettings[3]=gl_ztrick 0
set modsettings[4]=gl_keeptjunctions 1
set modsettings[5]=
call "%scriptspath%_handle_mod_choice.cmd" koohoo
goto :menu

REM Biotoxin should age out after 4/6/2023
:3
if not "%show_czgtoxic%"=="true" (
  goto :eof
)
set start_map=czgtoxic
call "%scriptspath%_handle_mod_choice.cmd" czgtoxic
goto :menu

REM Quake Condensed should age out six months after v3.8.0
:4
if not "%show_rpgsmse%"=="true" (
  goto :eof
)
set start_map=rpgsmse1
call "%scriptspath%_handle_mod_choice.cmd" rpgsmse
goto :menu

REM Rubicondom should age out after 5/14/2023
:5
if not "%show_sm82%"=="true" (
  goto :eof
)
set start_map=sm82
call "%scriptspath%_handle_mod_choice.cmd" sm82
goto :menu

REM Antediluvian should age out after 4/6/2023
:6
if not "%show_ant%"=="true" (
  goto :eof
)
set start_map=ant
call "%scriptspath%_handle_mod_choice.cmd" ant
goto :menu

REM This Onion should age out after 3/20/2023
:7
if not "%show_fmb_bdg%"=="true" (
  goto :eof
)
set start_map=fmb_bdg1
call "%scriptspath%_handle_mod_choice.cmd" fmb_bdg
goto :menu

REM A Roman Wilderness Of Pain should age out six months after v3.8.0
:8
if not "%show_arwop%"=="true" (
  goto :eof
)
set start_map=start
set startdemos=demo1
call "%scriptspath%_handle_mod_choice.cmd" arwop
goto :menu

REM Deathmatch Classics Vol. 3 should age out six months after v3.8.0
:9
if not "%show_dmc3%"=="true" (
  goto :eof
)
set patch_url=https://quaketastic.com/files/single_player/maps/dmc3m8_hotfix.zip
set start_map=dmc3
call "%scriptspath%_handle_mod_choice.cmd" dmc3
goto :menu

REM In The Shadows [Demo v1.1] should age out six months after v3.8.0
:10
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

REM The Elder Reality should age out after 4/6/2023
:11
if not "%show_retrojam4dlc_pulsar%"=="true" (
  goto :eof
)
set start_map=retrojam4dlc_pulsar
call "%scriptspath%_handle_mod_choice.cmd" retrojam4dlc_pulsar
goto :menu

REM 768^^2 should age out six months after v3.8.0
:12
if not "%show_sm198%"=="true" (
  goto :eof
)
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" sm198
goto :menu

REM January Jump Jam 2 should age out six months after v3.8.0
:13
if not "%show_jjj2%"=="true" (
  goto :eof
)
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/jjj2_ish.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" jjj2
goto :menu

REM Waldsterben should age out after 4/6/2023
:14
if not "%show_plaw02%"=="true" (
  goto :eof
)
set base_game=%latest_copper%
set start_map=plaw02
set skip_quakerc_gen=true
REM Because this archive is packaged oddly, we need to remove the top level
REM "src" dir for it to install correctly. We'll add the src dir contents
REM back in through the patch.
set junkdirs=src
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/plaw02_source.zip
call "%scriptspath%_handle_mod_choice.cmd" plaw02
goto :menu

REM Slip Tripping should age out after 4/6/2023
:15
if not "%show_markiesm1v2%"=="true" (
  goto :eof
)
set start_map=markiesm1
call "%scriptspath%_handle_mod_choice.cmd" markiesm1v2
goto :menu

REM Copper 1.19 should age out six months after v3.8.0
:16
if not "%show_copper_v1_19%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" copper_v1_19
goto :menu

REM Coppertone Summer Jam 2 v1.0 should age out after 2/11/2023
:17
if not "%show_ctsj2%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ctsj2
goto :menu

REM Empire of Disorder v2.3 should age out six months after v3.8.0
:18
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
