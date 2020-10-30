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
set has_startdemos=false
cls
call :installed_check honey
call :installed_check e1m5quotha
call :installed_check apsp3
call :installed_check something_wicked
call :installed_check fmb_bdg2
call :installed_check mstalk1c
call :installed_check ivory1b
call :installed_check func_mapjam1
call :installed_check func_mapjam2
call :installed_check func_mapjam3
call :installed_check retrojam6
call :installed_check grim_rezipped
echo.
echo A selection of other maps ^(part 2^):
echo %honey_installed% 17: honey - Honey ^(2012^)
echo %e1m5quotha_installed% 18: e1m5quotha - Gloomier Keep ^(2012^)
echo %apsp3_installed% 19: apsp3 - Subterranean Library ^(2012^)
echo %something_wicked_installed% 20: something_wicked - Something Wicked This Way Comes ^(2012^)
echo %fmb_bdg2_installed% 21: fmb_bdg2 - For My Babies - Bin Dunne Gorne 2 ^(2013^)
echo %mstalk1c_installed% 22: mstalk1c - Midnight Stalker ^(2013^)
echo %ivory1b_installed% 23: ivory1b - The Ivory Tower ^(2013^)
echo %func_mapjam1_installed% 24: func_mapjam1 - Func Map Jam 1 - Honey Theme ^(2014^)
echo %func_mapjam2_installed% 25: func_mapjam2 - Func Map Jam 2 - IKblue/IKwhite Theme ^(2014^)
echo %func_mapjam3_installed% 26: func_mapjam3 - Func Map Jam 3 - Zerstoerer theme ^(2014^)
echo %retrojam6_installed% 27: retrojam6 - Retro Jam 6 - Egyptian theme ^(2017^)
echo %grim_rezipped_installed% 28: grim_rezipped - The Grim Outpost ^(2018^)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:17
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/honey.zip
pause
goto :menu

:18
set base_game=quoth
set start_map=e1m5quotha
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/e1m5quotha.zip
pause
goto :menu

:19
set base_game=quoth
set start_map=apsp3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/apsp3.zip
pause
goto :menu

:20
set start_map=wickedstart
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/something_wicked.zip
pause
goto :menu

:21
set start_map=start_____
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/fmb_bdg2.zip
pause
goto :menu

:22
set start_map=mstalk
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/mstalk1c.zip
pause
goto :menu

:23
set start_map=ivory
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ivory1b.zip
pause
goto :menu

:24
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam1.zip
pause
goto :menu

:25
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam2.zip
pause
goto :menu

:26
set patch_url=https://www.quaddicted.com/filebase/jam3_mfx_fix.zip
set prelaunch_msg[0]=Note that this mod happens to include the original Zerstoerer campaign
set prelaunch_msg[1]=maps, but for the Func Jam 3 maps you will want to pick maps with names
set prelaunch_msg[2]=that begin with "jam3_".
set prelaunch_msg[3]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam3.zip
pause
goto :menu

:27
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/retrojam6.zip
pause
goto :menu

:28
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
