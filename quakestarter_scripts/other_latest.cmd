@echo off

REM Installer for mapsets that fit the following criteria:
REM * released from 2020 through 2022
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
call :installed_check ad_heresp1
call :installed_check zigisp1
call :installed_check ad_heresp2
call :installed_check purifier
echo.
echo Selected other custom maps released from 2020 through 2022:
echo %is_ad_heresp1_installed%  1: ad_heresp1 - Oxyblack Fortress
echo %is_zigisp1_installed%  2: zigisp1 - A Verdant Dawn
echo %is_ad_heresp2_installed%  3: ad_heresp2 - Imhotep's Legacy
echo %is_purifier_installed%  4: purifier - The Purifier
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set base_game=%latest_ad%
set start_map=ad_heresp1
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ad_heresp1.zip
pause
goto :menu

:2
set start_map=zigisp1
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/zigisp1.zip
pause
goto :menu

:3
set base_game=%latest_ad%
set start_map=ad_heresp2
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ad_heresp2.zip
pause
goto :menu

:4
set start_map=purifier
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/purifier.zip
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
