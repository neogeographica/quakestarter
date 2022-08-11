@echo off

REM Installer for mapsets that fit the following criteria:
REM * released within the past six months
REM * a high-profile high-quality release... completely subjective!
REM
REM See the commentary in the "echo" messages below.

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
call :installed_check plaw02
call :installed_check markiesm1v2
call :installed_check sm_217
call :installed_check ctsj2_1.2
echo.
echo This menu is a selection of high-profile releases from the past six months. A
echo release in this category can also eventually appear in one of the "The Next
echo Generation" categories (episodes or other) if it gains a high enough rating
echo on Quaddicted.
echo.
echo After six months, a release will be removed from this category. If it hasn't
echo made it into "The Next Generation" it will be added to the legacies menu.
echo.
echo %is_plaw02_installed%  1: plaw02 - Waldsterben
echo %is_markiesm1v2_installed%  2: markiesm1v2 - Slip Tripping
echo %is_sm_217_installed%  3: sm_217 - Remaster Textures
echo %is_ctsj2_1.2_installed%  4: ctsj2 - Coppertone Summer Jam 2 v1.2
echo.
echo Enter a number to install/launch/manage one of the releases above.
echo.
echo Or, to just view its webpage (at Quaddicted or elsewhere), use Shift+Enter to
echo submit your choice; keep holding shift until the webpage opens.
echo.
set menu_choice=:eof
set /p menu_choice=enter your choice or just press Enter to exit:
echo.
goto %menu_choice%

REM Waldsterben should age out after 8/22/2022
:1
set base_game=%latest_copper%
set start_map=plaw02
set skip_quakerc_gen=true
REM Because this archive is packaged oddly, we need to remove the top level
REM "src" dir for it to install correctly. We'll add the src dir contents
REM back in through the patch.
set junkdirs=src
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/plaw02_source.zip
call "%scriptspath%_handle_mod_choice.cmd" plaw02
goto :menu

REM Slip Tripping should age out after 10/2/2022
:2
set start_map=markiesm1
call "%scriptspath%_handle_mod_choice.cmd" markiesm1v2
goto :menu

REM Remaster Textures should age out after 11/11/2022
:3
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" sm_217
goto :menu

REM Coppertone Summer Jam 2 should age out after 2/8/2023
:4
set review_page=https://www.slipseer.com/index.php?resources/coppertone-summer-jam-2.103
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ctsj2_1.2 https://www.slipseer.com/index.php?resources/coppertone-summer-jam-2.103/version/130/download
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
) else (
  set is_%1_installed= 
)
goto :eof

