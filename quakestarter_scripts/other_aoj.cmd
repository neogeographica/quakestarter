@echo off

REM Installer for maps that fit the following criteria:
REM * released from 2014 through 2019
REM * Quaddicted user rating 4.4 or better (normalized Bayesian average)

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
call :installed_check func_mapjam2
call :installed_check func_mapjam3
call :installed_check retrojam6
call :installed_check grim_rezipped
call :installed_check dm6rmx
call :installed_check 37_hcm1
echo.
echo Selected other custom maps released from 2014 through 2019:
echo %is_func_mapjam2_installed%  1: func_mapjam2 - Func Map Jam 2 - IKblue/IKwhite Theme ^(2014^)
echo %is_func_mapjam3_installed%  2: func_mapjam3 - Func Map Jam 3 - Zerstoerer theme ^(2014^)
echo %is_retrojam6_installed%  3: retrojam6 - Retro Jam 6 - Egyptian theme ^(2017^)
echo %is_grim_rezipped_installed%  4: grim_rezipped - The Grim Outpost ^(2018^)
echo %is_dm6rmx_installed%  5: dm6rmx - The Dark Portal ^(2018^)
echo %is_37_hcm1_installed%  6: 37_hcm1 - 37th Relic Retrieval ^(2019^)
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
set modsettings[0]=scr_conspeed 1000
set modsettings[1]=r_wateralpha 0.65
set modsettings[2]=
call "%scriptspath%_handle_mod_choice.cmd" func_mapjam2
goto :menu

:2
set patch_url=https://www.quaddicted.com/filebase/jam3_mfx_fix.zip
set prelaunch_msg[0]=Note that this mod happens to include the original Zerstoerer campaign
set prelaunch_msg[1]=maps, but for the Func Jam 3 maps you will want to pick maps with names
set prelaunch_msg[2]=that begin with "jam3_".
set prelaunch_msg[3]=
set modsettings[0]=scr_conspeed 1000
set modsettings[1]=r_wateralpha 0.65
set modsettings[2]=max_edicts 4096
set modsettings[3]=
call "%scriptspath%_handle_mod_choice.cmd" func_mapjam3
goto :menu

:3
set modsettings[0]=r_wateralpha 0.65
set modsettings[1]=
call "%scriptspath%_handle_mod_choice.cmd" retrojam6
goto :menu

:4
set start_map=grim
call "%scriptspath%_handle_mod_choice.cmd" grim_rezipped
goto :menu

:5
set start_map=dm6rmx
call "%scriptspath%_handle_mod_choice.cmd" dm6rmx
goto :menu

:6
set base_game=%latest_ad%
set start_map=37_hcm1
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" 37_hcm1
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
) else (
  set is_%1_installed= 
)
goto :eof
