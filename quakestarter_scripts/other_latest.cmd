@echo off

REM Installer for mapsets that fit the following criteria:
REM * released from 2020 on
REM * Quaddicted user rating 4.45 or better (normalized Bayesian average)

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
set base_game=%latest_ad%
set start_map=ad_heresp1
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ad_heresp1
goto :menu

:2
set start_map=zigisp1
call "%scriptspath%_handle_mod_choice.cmd" zigisp1
goto :menu

:3
set base_game=%latest_ad%
set start_map=ad_heresp2
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ad_heresp2
goto :menu

:4
set start_map=purifier
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" purifier
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
) else (
  set is_%1_installed= 
)
goto :eof
