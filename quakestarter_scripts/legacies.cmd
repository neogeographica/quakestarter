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
call :installed_check descent rating
call :installed_check koohoo rating
call :installed_check e1m1rmx rating
call :installed_check chapters rating
call :installed_check fmb_bdg rating
call :installed_check arwop rating
call :installed_check digs05 rating
call :installed_check dmc3 rating
call :installed_check fmb_bdg2 rating
call :installed_check func_mapjam5
call :installed_check ad_paradise rating
call :installed_check sewerjam
call :installed_check unusedjam rating
call :installed_check bluemonday_v2 rating
call :installed_check ad_v1_70final version
call :installed_check copper_v1_15 version
call :installed_check copper_v1_16 version

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
cls
echo.
echo Releases shown here were in the installer menus in previous versions but
echo have since been removed.
echo.
if not "%force_show_legacies%"=="true" (
  echo Only currently installed releases will be shown here, since the
  echo force_show_legacies option is false in the config.
  echo.
)
if "%show_rating%"=="true" (
  echo Dropped because of a change in rating or criteria:
  if "%show_descent%"=="true" (
    echo %is_descent_installed%  1: descent - ^(The Final^) Descent ^(2000^)
  )
  if "%show_koohoo%"=="true" (
    echo %is_koohoo_installed%  2: koohoo - The Castle of Koohoo ^(2001^)
  )
  if "%show_e1m1rmx%"=="true" (
    echo %is_e1m1rmx_installed%  3: e1m1rmx - The Slipgate Duplex ^(2004^)
  )
  if "%show_chapters%"=="true" (
    echo %is_chapters_installed%  4: chapters - Contract Revoked: The Lost Chapters ^(2005^)
  )
  if "%show_fmb_bdg%"=="true" (
    echo %is_fmb_bdg_installed%  5: fmb_bdg - This Onion ^(2007^)
  )
  if "%show_arwop%"=="true" (
    echo %is_arwop_installed%  6: arwop - A Roman Wilderness Of Pain ^(2009^)
  )
  if "%show_digs05%"=="true" (
    echo %is_digs05_installed%  7: digs05 - The Anomaly ^(2011^)
  )
  if "%show_dmc3%"=="true" (
    echo %is_dmc3_installed%  8: dmc3 - Deathmatch Classics Vol. 3 ^(2011^)
  )
  if "%show_fmb_bdg2%"=="true" (
    echo %is_fmb_bdg2_installed%  9: fmb_bdg2 - For My Babies - Bin Dunne Gorne 2 ^(2013^)
  )
  if "%show_func_mapjam5%"=="true" (
    echo %is_func_mapjam5_installed% 10: func_mapjam5 - Func Map Jam 5 - The Qonquer Map Jam ^(2015^)
  )
  if "%show_ad_paradise%"=="true" (
    echo %is_ad_paradise_installed% 11: ad_paradise - Paradise Sickness ^(2017^)
  )
  if "%show_sewerjam%"=="true" (
    echo %is_sewerjam_installed% 12: sewerjam - Quake Sewer Jam ^(2019^)
  )
  if "%show_unusedjam%"=="true" (
    echo %is_unusedjam_installed% 13: unusedjam - Unused Jam ^(2021^)
  )
  if "%show_bluemonday_v2%"=="true" (
    echo %is_bluemonday_v2_installed% 14: bluemonday_v2 - Blue Monday Jam ^(2021^)
  )
  echo.
)
if "%show_version%"=="true" (
  echo Dropped because superseded by a newer version:
  if "%show_ad_v1_70final%"=="true" (
    echo %is_ad_v1_70final_installed% 15: ad_v1_70final - Arcane Dimensions 1.7 ^(2017^)
  )
  if "%show_copper_v1_15%"=="true" (
    echo %is_copper_v1_15_installed% 16: copper_v1_15 - Copper 1.15 ^(2020^)
  )
  if "%show_copper_v1_16%"=="true" (
    echo %is_copper_v1_16_installed% 17: copper_v1_16 - Copper 1.16 ^(2021^)
  )
  echo.
)
echo Enter a number to install/launch/manage one of the releases above.
echo Or, to just view its Quaddicted page, use Shift+Enter to submit your
echo choice; keep holding shift until the webpage opens.
echo.
set menu_choice=:eof
set /p menu_choice=enter your choice or just press Enter to exit:
echo.
goto %menu_choice%

:1
if not "%show_descent%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
set startdemos=intro demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" descent
goto :menu

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

:3
if not "%show_e1m1rmx%"=="true" (
  goto :eof
)
set start_map=e1m1rmx
call "%scriptspath%_handle_mod_choice.cmd" e1m1rmx
goto :menu

:4
if not "%show_chapters%"=="true" (
  goto :eof
)
set start_map=start
set extra_launch_args=-hipnotic
set postlaunch_msg[0]=If you launch "chapters" outside of this installer, make sure to specify
set postlaunch_msg[1]=missionpack 1 as the base game ^("-hipnotic" arg^). In this case, that base
set postlaunch_msg[2]=game is necessary even if you don't have missionpack 1 currently installed.
set postlaunch_msg[3]=
call "%scriptspath%_handle_mod_choice.cmd" chapters
goto :menu

:5
if not "%show_fmb_bdg%"=="true" (
  goto :eof
)
set start_map=fmb_bdg1
call "%scriptspath%_handle_mod_choice.cmd" fmb_bdg
goto :menu

:6
if not "%show_arwop%"=="true" (
  goto :eof
)
set start_map=start
set startdemos=demo1
call "%scriptspath%_handle_mod_choice.cmd" arwop
goto :menu

:7
if not "%show_digs05%"=="true" (
  goto :eof
)
set start_map=digs05
call "%scriptspath%_handle_mod_choice.cmd" digs05
goto :menu

:8
if not "%show_dmc3%"=="true" (
  goto :eof
)
set start_map=dmc3
call "%scriptspath%_handle_mod_choice.cmd" dmc3
goto :menu

:9
if not "%show_fmb_bdg2%"=="true" (
  goto :eof
)
set start_map=start_____
call "%scriptspath%_handle_mod_choice.cmd" fmb_bdg2
goto :menu

:10
if not "%show_func_mapjam5%"=="true" (
  goto :eof
)
set patch_url=https://www.quaddicted.com/files/mods/QuickerQonquer.zip
set patch_skipfiles=maps\QArena.bsp maps\QStart.bsp
set start_map=start
set startdemos=demo1
set modsettings[0]=scr_conspeed 1000
set modsettings[1]=r_wateralpha 0.65
set modsettings[2]=
call "%scriptspath%_handle_mod_choice.cmd" func_mapjam5
goto :menu

:11
if not "%show_ad_paradise%"=="true" (
  goto :eof
)
set base_game=%latest_ad%
set start_map=ad_paradise
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ad_paradise
goto :menu

:12
if not "%show_sewerjam%"=="true" (
  goto :eof
)
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" sewerjam
goto :menu

:13
if not "%show_unusedjam%"=="true" (
  goto :eof
)
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" unusedjam
goto :menu

:14
if not "%show_bluemonday_v2%"=="true" (
  goto :eof
)
set base_game=quoth
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" bluemonday_v2
goto :menu

:15
if not "%show_ad_v1_70final%"=="true" (
  goto :eof
)
set patch_url=https://www.quaddicted.com/filebase/ad_v1_70patch1.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ad_v1_70final
goto :menu

:16
if not "%show_copper_v1_15%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" copper_v1_15
goto :menu

:17
if not "%show_copper_v1_16%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" copper_v1_16
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
