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
call :installed_check sm198
call :installed_check sewerjam
call :installed_check hwjam2
call :installed_check jumpmod2+td_complete
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
echo %is_sm198_installed% 11: sm198 - 768^^2 ^(2019^)
echo %is_sewerjam_installed% 12: sewerjam - Quake Sewer Jam ^(2019^)
echo %is_hwjam2_installed% 13: hwjam2 - Halloween Jam 2 ^(2019^)
echo %is_jumpmod2+td_complete_installed% 14: jumpmod2+td_complete - Jumpmod 2 + Triune Discovery ^(2019^)
echo %is_xmasjam2019_installed% 15: xmasjam2019 - Xmas Jam 2019 ^(2019^)
echo %is_smej_1.13_installed% 16: smej_1.13 - Menetettyjen Valtakunta ^(Realm of the Lost^) ^(2019^)
echo.
echo Enter a number to install/launch/manage one of the releases above.
echo.
echo Or, to just view its Quaddicted page, use Shift+Enter to submit your
echo choice; keep holding shift until the webpage opens.
echo.
set menu_choice=:eof
set /p menu_choice=enter your choice or just press Enter to exit:
echo.
goto %menu_choice%

:1
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" dopa
goto :menu

:2
set base_game=hipnotic
set start_map=q1map1
call "%scriptspath%_handle_mod_choice.cmd" gotshun-never-released_levels
goto :menu

:3
set base_game=quoth
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" func_mapjam9_2
goto :menu

:4
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" qump
goto :menu

:5
set patch_url=https://www.quaddicted.com/filebase/dm4jam_dlc_patch.zip
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" dm4jam
goto :menu

:6
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" hwjam
goto :menu

:7
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/xmasjam2_shotro.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" xmasjam2018
goto :menu

:8
set patch_url=http://www.quaketastic.com/files/single_player/mods/JamX_progs_fix_for_items.zip
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" func_mapjamx
goto :menu

:9
set base_game=%latest_copper%
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" udob_v1_1
goto :menu

:10
set start_map=start
set startdemos=demo1 demo2 demo3 demo4 demo5
call "%scriptspath%_handle_mod_choice.cmd" quoffee
goto :menu

:11
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" sm198
goto :menu

:12
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" sewerjam
goto :menu

:13
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" hwjam2
goto :menu

:14
set review_page=jumpmod2%%2Btd_complete
set start_map=start
set prelaunch_msg[0]=Note that this mod includes two small additional maps outside of the
set prelaunch_msg[1]=episode sequence: jcr_jbdemo1 and jcr_jbdemo2. You can start those maps
set prelaunch_msg[2]=manually with the console "map" command.
set prelaunch_msg[3]=
set modsettings[0]=sv_protocol 999
set modsettings[1]=
call "%scriptspath%_handle_mod_choice.cmd" jumpmod2+td_complete
goto :menu

:15
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" xmasjam2019
goto :menu

:16
set review_page=smej_1.0
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" smej_1.13
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
) else (
  set is_%1_installed= 
)
goto :eof
