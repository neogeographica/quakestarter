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
call :installed_check fmb_bdg
call :installed_check apsp2
call :installed_check arwop
call :installed_check rubicon2
call :installed_check ne_ruins
call :installed_check honey
call :installed_check apsp3
call :installed_check something_wicked
call :installed_check fmb_bdg2
call :installed_check ivory1b
echo.
echo Selected other custom maps released from 2006 through 2019:
echo %fmb_bdg_installed%  1: fmb_bdg - This Onion ^(2007^)
echo %apsp2_installed%  2: apsp2 - Plumbers Don't Wear Ties ^(2009^)
echo %arwop_installed%  3: arwop - A Roman Wilderness Of Pain ^(2009^)
echo %rubicon2_installed%  4: rubicon2 - Rubicon 2 ^(2011^)
echo %ne_ruins_installed%  5: ne_ruins - The Altar of Storms ^(2011^)
echo %honey_installed%  6: honey - Honey ^(2012^)
echo %apsp3_installed%  7: apsp3 - Subterranean Library ^(2012^)
echo %something_wicked_installed%  8: something_wicked - Something Wicked This Way Comes ^(2012^)
echo %fmb_bdg2_installed%  9: fmb_bdg2 - For My Babies - Bin Dunne Gorne 2 ^(2013^)
echo %ivory1b_installed% 10: ivory1b - The Ivory Tower ^(2013^)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set start_map=fmb_bdg1
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/fmb_bdg.zip
pause
goto :menu

:2
set base_game=quoth
set start_map=apsp2
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/apsp2.zip
pause
goto :menu

:3
set start_map=start
set startdemos=demo1
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/arwop.zip
pause
goto :menu

:4
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/rubicon2.zip
pause
goto :menu

:5
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ne_ruins.zip
pause
goto :menu

:6
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/honey.zip
pause
goto :menu

:7
set base_game=quoth
set start_map=apsp3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/apsp3.zip
pause
goto :menu

:8
set start_map=wickedstart
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/something_wicked.zip
pause
goto :menu

:9
set start_map=start_____
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/fmb_bdg2.zip
pause
goto :menu

:10
set start_map=ivory
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ivory1b.zip
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
