@echo off

REM Installer for mapsets that fit the following criteria:
REM * released from 2020 through 2022
REM * a start map and at least four non-startmaps
REM * Quaddicted editor rating "Excellent"
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
call :installed_check ctsj
call :installed_check dwellv1p2
call :installed_check ad_v1_80p1final
call :installed_check eoe
call :installed_check hwjam3
call :installed_check xmasjam2020
call :installed_check smej2_1.1
call :installed_check pun
call :installed_check alkaline1.1
call :installed_check xmasjam2021
call :installed_check sm215
call :installed_check snack2
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
echo %is_alkaline1.1_installed%  9: alkaline1.1 - Alkaline 1.1
echo %is_xmasjam2021_installed% 10: xmasjam2021 - Xmas Jam 2021
echo %is_sm215_installed% 11: sm215 - Quad Run
echo %is_snack2_installed% 12: snack2 - Speedmap Snack Pack 2 - Cosmic Hunger
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set base_game=%latest_copper%
set start_map=ctsj_start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ctsj.zip
pause
goto :menu

:2
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/dwellv1p2.zip
pause
goto :menu

:3
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ad_v1_80p1final.zip
pause
goto :menu

:4
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/eoem7_fix_pak.zip
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/eoe.zip
pause
goto :menu

:5
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/hwjam3_fixes.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/hwjam3.zip
pause
goto :menu

:6
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/xmasjam2020.zip
pause
goto :menu

:7
set start_map=start
set skip_quakerc_gen=true
set startdemos=demo3 demo2 demo1
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/smej2_1.1.zip
pause
goto :menu

:8
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/pun.zip
pause
goto :menu

:9
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/alkaline1.1.zip
pause
goto :menu

:10
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/xmasjam2021.zip
pause
goto :menu

:11
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/sm215.zip
pause
goto :menu

:12
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/snack2.zip
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
