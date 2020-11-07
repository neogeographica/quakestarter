@echo off

REM Installer for maps that fit the following criteria:
REM * released from 2006 through 2013
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
call :installed_check thehand
call :installed_check fmb_bdg
call :installed_check apsp2
call :installed_check arwop
call :installed_check digs05
call :installed_check rubicon2
call :installed_check ne_ruins
call :installed_check honey
call :installed_check apsp3
call :installed_check something_wicked
call :installed_check fmb_bdg2
call :installed_check ivory1b
call :installed_check zendar1d
echo.
echo Selected other custom maps released from 2006 through 2019:
echo %is_thehand_installed%  1: thehand - The Hand That Feeds You ^(2007^)
echo %is_fmb_bdg_installed%  2: fmb_bdg - This Onion ^(2007^)
echo %is_apsp2_installed%  3: apsp2 - Plumbers Don't Wear Ties ^(2009^)
echo %is_arwop_installed%  4: arwop - A Roman Wilderness Of Pain ^(2009^)
echo %is_digs05_installed%  5: digs05 - The Anomaly ^(2011^)
echo %is_rubicon2_installed%  6: rubicon2 - Rubicon 2 ^(2011^)
echo %is_ne_ruins_installed%  7: ne_ruins - The Altar of Storms ^(2011^)
echo %is_honey_installed%  8: honey - Honey ^(2012^)
echo %is_apsp3_installed%  9: apsp3 - Subterranean Library ^(2012^)
echo %is_something_wicked_installed% 10: something_wicked - Something Wicked This Way Comes ^(2012^)
echo %is_fmb_bdg2_installed% 11: fmb_bdg2 - For My Babies - Bin Dunne Gorne 2 ^(2013^)
echo %is_ivory1b_installed% 12: ivory1b - The Ivory Tower ^(2013^)
echo %is_zendar1d_installed% 13: zendar1d - The Horde of Zendar ^(2013^)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set base_game=quoth
set start_map=thehand
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/thehand.zip
pause
goto :menu

:2
set start_map=fmb_bdg1
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/fmb_bdg.zip
pause
goto :menu

:3
set base_game=quoth
set start_map=apsp2
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/apsp2.zip
pause
goto :menu

:4
set start_map=start
set startdemos=demo1
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/arwop.zip
pause
goto :menu

:5
set start_map=digs05
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/digs05.zip
pause
goto :menu

:6
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/rubicon2.zip
pause
goto :menu

:7
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ne_ruins.zip
pause
goto :menu

:8
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/honey.zip
pause
goto :menu

:9
set base_game=quoth
set start_map=apsp3
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/apsp3.zip
pause
goto :menu

:10
set start_map=wickedstart
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/something_wicked.zip
pause
goto :menu

:11
set start_map=start_____
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/fmb_bdg2.zip
pause
goto :menu

:12
set start_map=ivory
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ivory1b.zip
pause
goto :menu

:13
set start_map=zendar
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/zendar1d.zip
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
