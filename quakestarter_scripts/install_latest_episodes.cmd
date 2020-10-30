@echo off

REM Installer for mapsets that fit the following criteria:
REM * released in 2016 or later
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
  echo Couldn't find the id1 folder in this script's folder or parent folder.
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
set has_startdemos=false
cls
call :installed_check dopa
call :installed_check gotshun-never-released_levels
call :installed_check func_mapjam9_2
call :installed_check qump
call :installed_check ad_v1_70final
call :installed_check dm4jam
call :installed_check hwjam
call :installed_check xmasjam2018
echo.
echo Custom episodes released in 2016 or later:
echo %dopa_installed%  1: dopa - Dimension of the Past ^(2016^)
echo %gotshun-never-released_levels_installed%  2: gotshun-never-released_levels - The "lost" levels ^(2016^)
echo %func_mapjam9_2_installed%  3: func_mapjam9_2 - Func Map Jam 9 - Contract Revoked / Knave theme ^(2017^)
echo %qump_installed%  4: qump - Quake Upstart Mapping Project ^(2017^)
echo %ad_v1_70final_installed%  5: ad_v1_70final - Arcane Dimensions 1.7 ^(2017^)
echo %dm4jam_installed%  6: dm4jam - DM4 Jam ^(2018^)
echo %hwjam_installed%  7: hwjam - Halloween Jam 2018 ^(2018^)
echo %xmasjam2018_installed%  8: xmasjam2018 - Xmas Jam 2018 - 1024^^3 theme ^(2018^)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set start_map=start
set has_startdemos=true
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
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam9_2.zip
pause
goto :menu

:4
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/qump.zip
pause
goto :menu

:5
set patch_url=https://www.quaddicted.com/filebase/ad_v1_70patch1.zip
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ad_v1_70final.zip
pause
goto :menu

:6
set patch_url=https://www.quaddicted.com/filebase/dm4jam_dlc_patch.zip
set start_map=start
set has_startdemos=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/dm4jam.zip
pause
goto :menu

:7
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/hwjam.zip
pause
goto :menu

:8
set patch_url=http://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/xmasjam2_shotro.zip
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/xmasjam2018.zip
pause
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set %1_installed=*
) else (
  set %1_installed= 
)
goto :eof
