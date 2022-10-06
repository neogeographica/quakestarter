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
call :installed_check markiesm1v2
call :installed_check sm_217
call :installed_check ctsj2_1.2
call :installed_check sm220-108
call :installed_check qbj_1.05
echo.
echo This menu is a selection of high-profile releases from the past six months. A
echo release in this category can also eventually appear in one of the "The Next
echo Generation" categories (episodes or other) if it gains a high enough rating
echo on Quaddicted.
echo.
echo After six months, a release will be removed from this category. If it hasn't
echo made it into "The Next Generation" it will be added to the legacies menu.
echo.
echo %is_markiesm1v2_installed%  1: markiesm1v2 - Slip Tripping
echo %is_sm_217_installed%  2: sm_217 - Remaster Textures
echo %is_ctsj2_1.2_installed%  3: ctsj2_1.2 - Coppertone Summer Jam 2 v1.2
echo %is_sm220-108_installed%  4: sm220-108 - Prototype Jam 3 v1.08
echo %is_qbj_1.05_installed%  5: qbj_1.05 - Quake Brutalist Jam v1.05
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

REM Slip Tripping should age out after 10/2/2022
:1
set start_map=markiesm1
call "%scriptspath%_handle_mod_choice.cmd" markiesm1v2
goto :menu

REM Remaster Textures should age out after 11/11/2022
:2
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" sm_217
goto :menu

REM Coppertone Summer Jam 2 v1.2 should age out after 2/8/2023
:3
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ctsj2_1.2
goto :menu

REM Prototype Jam 3 v1.08 should age out after 2/29/2023
:4
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" sm220-108
goto :menu

REM Quake Brutalist Jam v1.05 should age out after 3/28/2023
:5
set review_page=https://www.slipseer.com/index.php?resources/quake-brutalist-jam.126/
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" qbj_1.05 https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/qbj_1.05.zip
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
) else (
  set is_%1_installed= 
)
goto :eof

