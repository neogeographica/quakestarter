@echo off

REM Installer for mapsets that fit the following criteria:
REM * released from 2016 through 2019
REM * a start map and at least four non-startmaps
REM * Quaddicted user rating 3.95 or better (normalized Bayesian average)

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
call :installed_check dopa
call :installed_check gotshun-never-released_levels
call :installed_check func_mapjam9_2
call :installed_check qump
call :installed_check dm4jam
call :installed_check hwjam
call :installed_check xmasjam2018
call :installed_check func_mapjamx
call :installed_check udob_v1_1
call :installed_check quoffee
call :installed_check sewerjam
call :installed_check hwjam2
call :installed_check xmasjam2019
call :installed_check smej_1.13
echo.
echo Selected custom episodes/hubs released from 2016 through 2019:
echo %is_dopa_installed%  1: dopa - Dimension of the Past ^(2016^)
echo %is_gotshun-never-released_levels_installed%  2: gotshun-never-released_levels - The "lost" levels ^(2016^)
echo %is_func_mapjam9_2_installed%  3: func_mapjam9_2 - Func Map Jam 9 - Contract Revoked / Knave theme ^(2017^)
echo %is_qump_installed%  4: qump - Quake Upstart Mapping Project ^(2017^)
echo %is_dm4jam_installed%  5: dm4jam - DM4 Jam ^(2018^)
echo %is_hwjam_installed%  6: hwjam - Halloween Jam 2018 ^(2018^)
echo %is_xmasjam2018_installed%  7: xmasjam2018 - Xmas Jam 2018 - 1024^^3 theme ^(2018^)
echo %is_func_mapjamx_installed%  8: func_mapjamx - Func Map Jam X - Insomnia Theme ^(2019^)
echo %is_udob_v1_1_installed%  9: udob_v1_1 - Underdark Overbright ^(2019^)
echo %is_quoffee_installed% 10: quoffee - Coffee Quake ^(2019^)
echo %is_sewerjam_installed% 11: sewerjam - Quake Sewer Jam ^(2019^)
echo %is_hwjam2_installed% 12: hwjam2 - Halloween Jam 2 ^(2019^)
echo %is_xmasjam2019_installed% 13: xmasjam2019 - Xmas Jam 2019 ^(2019^)
echo %is_smej_1.13_installed% 14: smej_1.13 - Menetettyjen Valtakunta ^(Realm of the Lost^) ^(2019^)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/dopa.zip
pause
goto :menu

:2
set base_game=hipnotic
set start_map=q1map1
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/gotshun-never-released_levels.zip
pause
goto :menu

:3
set base_game=quoth
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam9_2.zip
pause
goto :menu

:4
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/qump.zip
pause
goto :menu

:5
set patch_url=https://www.quaddicted.com/filebase/dm4jam_dlc_patch.zip
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/dm4jam.zip
pause
goto :menu

:6
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/hwjam.zip
pause
goto :menu

:7
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/xmasjam2_shotro.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/xmasjam2018.zip
pause
goto :menu

:8
set patch_url=http://www.quaketastic.com/files/single_player/mods/JamX_progs_fix_for_items.zip
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjamx.zip
pause
goto :menu

:9
set base_game=%latest_copper%
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/udob_v1_1.zip
pause
goto :menu

:10
set start_map=start
set startdemos=demo1 demo2 demo3 demo4 demo5
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/quoffee.zip
pause
goto :menu

:11
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/sewerjam.zip
pause
goto :menu

:12
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/hwjam2.zip
pause
goto :menu

:13
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/xmasjam2019.zip
pause
goto :menu

:14
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/smej_1.13.zip
pause
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
) else (
  set is_%1_installed= 
)
goto :eof
