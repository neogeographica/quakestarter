@echo off

REM Installer for mapsets that fit the following criteria:
REM * released from 2020 on
REM * a start map and at least four non-startmaps
REM * Quaddicted user rating 4.0 or better (normalized Bayesian average)

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
call :installed_check ctsj
call :installed_check dwellv1p2
call :installed_check ad_v1_80p1final
call :installed_check eoe
call :installed_check hwjam3
call :installed_check xmasjam2020
call :installed_check smej2_1.1
call :installed_check pun
call :installed_check alkjam
call :installed_check alkaline1.1
call :installed_check xmasjam2021
call :installed_check jjj2
call :installed_check sm215
call :installed_check snack2
call :installed_check sm_217
echo.
echo Selected custom episodes/hubs released from 2020 through 2022:
echo %is_ctsj_installed%  1: ctsj - Coppertone Summer Jam
echo %is_dwellv1p2_installed%  2: dwellv1p2 - Dwell - Episode 1
echo %is_ad_v1_80p1final_installed%  3: ad_v1_80p1final - Arcane Dimensions 1.81
echo %is_eoe_installed%  4: eoe - Epochs of Enmity
echo %is_hwjam3_installed%  5: hwjam3 - Halloween Jam 3
echo %is_xmasjam2020_installed%  6: xmasjam2020 - Xmas Jam 2020
echo %is_smej2_1.1_installed%  7: smej2_1.1 - Torrent of Impurities ^(Epaepuhtauksien Virta^)
echo %is_pun_installed%  8: pun - The Punishment Due
echo %is_alkjam_installed%  9: alkjam - Alkaline Jam
echo %is_alkaline1.1_installed% 10: alkaline1.1 - Alkaline 1.1
echo %is_xmasjam2021_installed% 11: xmasjam2021 - Xmas Jam 2021
echo %is_jjj2_installed% 12: jjj2 - January Jump Jam 2
echo %is_sm215_installed% 13: sm215 - Quad Run
echo %is_snack2_installed% 14: snack2 - Speedmap Snack Pack 2 - Cosmic Hunger
echo %is_sm_217_installed% 15: sm_217 - Remaster Textures
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
set base_game=%latest_copper%
set start_map=ctsj_start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ctsj
goto :menu

:2
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" dwellv1p2
goto :menu

:3
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ad_v1_80p1final
goto :menu

:4
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/eoem7_fix_pak.zip
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" eoe
goto :menu

:5
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/hwjam3_fixes.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" hwjam3
goto :menu

:6
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" xmasjam2020
goto :menu

:7
set start_map=start
set skip_quakerc_gen=true
set startdemos=demo3 demo2 demo1
call "%scriptspath%_handle_mod_choice.cmd" smej2_1.1
goto :menu

:8
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" pun
goto :menu

:9
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" alkjam
goto :menu

:10
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" alkaline1.1
goto :menu

:11
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" xmasjam2021
goto :menu

:12
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/jjj2_ish.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" jjj2
goto :menu

:13
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" sm215
goto :menu

:14
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" snack2
goto :menu

:15
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" sm_217
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
) else (
  set is_%1_installed= 
)
goto :eof
