@echo off

REM Installer for maps that fit the following criteria:
REM * it (or a variant) is NOT included in other selected episodes
REM * Quaddicted editor rating "Excellent"
REM * Quaddicted user rating 4.5 or better (normalized Bayesian average)

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
set skip_quakerc_gen=false
set modsettings[0]=
set startdemos=
cls
call :installed_check apsp3
call :installed_check something_wicked
call :installed_check fmb_bdg2
call :installed_check ivory1b
call :installed_check func_mapjam2
call :installed_check func_mapjam3
call :installed_check retrojam6
call :installed_check grim_rezipped
echo.
echo A selection of other maps ^(part 2^):
echo %apsp3_installed% 17: apsp3 - Subterranean Library ^(2012^)
echo %something_wicked_installed% 18: something_wicked - Something Wicked This Way Comes ^(2012^)
echo %fmb_bdg2_installed% 19: fmb_bdg2 - For My Babies - Bin Dunne Gorne 2 ^(2013^)
echo %ivory1b_installed% 20: ivory1b - The Ivory Tower ^(2013^)
echo %func_mapjam2_installed% 21: func_mapjam2 - Func Map Jam 2 - IKblue/IKwhite Theme ^(2014^)
echo %func_mapjam3_installed% 22: func_mapjam3 - Func Map Jam 3 - Zerstoerer theme ^(2014^)
echo %retrojam6_installed% 23: retrojam6 - Retro Jam 6 - Egyptian theme ^(2017^)
echo %grim_rezipped_installed% 24: grim_rezipped - The Grim Outpost ^(2018^)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:17
set base_game=quoth
set start_map=apsp3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/apsp3.zip
pause
goto :menu

:18
set start_map=wickedstart
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/something_wicked.zip
pause
goto :menu

:19
set start_map=start_____
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/fmb_bdg2.zip
pause
goto :menu

:20
set start_map=ivory
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ivory1b.zip
pause
goto :menu

:21
set modsettings[0]=scr_conspeed 1000
set modsettings[1]=r_wateralpha 0.65
set modsettings[2]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam2.zip
pause
goto :menu

:22
set patch_url=https://www.quaddicted.com/filebase/jam3_mfx_fix.zip
set prelaunch_msg[0]=Note that this mod happens to include the original Zerstoerer campaign
set prelaunch_msg[1]=maps, but for the Func Jam 3 maps you will want to pick maps with names
set prelaunch_msg[2]=that begin with "jam3_".
set prelaunch_msg[3]=
set modsettings[0]=scr_conspeed 1000
set modsettings[1]=r_wateralpha 0.65
set modsettings[2]=max_edicts 4096
set modsettings[3]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam3.zip
pause
goto :menu

:23
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/retrojam6.zip
pause
goto :menu

:24
set start_map=grim
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/grim_rezipped.zip
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
