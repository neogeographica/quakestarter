@echo off

REM Installer for maps that fit the following criteria:
REM * released after Quoth (late 2005) through 2013
REM * Quaddicted user rating 4.35 or better (normalized Bayesian average)

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
call :installed_check red777
call :installed_check thehand
call :installed_check apsp2
call :installed_check arwop
call :installed_check rubicon2
call :installed_check ne_ruins
call :installed_check honey
call :installed_check scampsp1
call :installed_check apsp3
call :installed_check something_wicked
call :installed_check its_demo_v1_1
call :installed_check ivory1b
call :installed_check zendar1d
echo.
echo Selected other custom maps released from late 2005 through 2019:
echo %is_red777_installed%  1: red777 - Red 777 ^(2005^)
echo %is_thehand_installed%  2: thehand - The Hand That Feeds You ^(2007^)
echo %is_apsp2_installed%  3: apsp2 - Plumbers Don't Wear Ties ^(2009^)
echo %is_arwop_installed%  4: arwop - A Roman Wilderness Of Pain ^(2009^)
echo %is_rubicon2_installed%  5: rubicon2 - Rubicon 2 ^(2011^)
echo %is_ne_ruins_installed%  6: ne_ruins - The Altar of Storms ^(2011^)
echo %is_honey_installed%  7: honey - Honey ^(2012^)
echo %is_scampsp1_installed%  8: scampsp1 - Dead Memories ^(2012^)
echo %is_apsp3_installed%  9: apsp3 - Subterranean Library ^(2012^)
echo %is_something_wicked_installed% 10: something_wicked - Something Wicked This Way Comes ^(2012^)
echo %is_its_demo_v1_1_installed% 11: its_demo_v1_1 - In The Shadows [Demo v1.1] ^(2012^)
echo %is_ivory1b_installed% 12: ivory1b - The Ivory Tower ^(2013^)
echo %is_zendar1d_installed% 13: zendar1d - The Horde of Zendar ^(2013^)
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
set base_game=quoth
set start_map=red777
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" red777
goto :menu

:2
set base_game=quoth
set start_map=thehand
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" thehand
goto :menu

:3
set base_game=quoth
set start_map=apsp2
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" apsp2
goto :menu

:4
set start_map=start
set startdemos=demo1
call "%scriptspath%_handle_mod_choice.cmd" arwop
goto :menu

:5
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" rubicon2
goto :menu

:6
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ne_ruins
goto :menu

:7
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" honey
goto :menu

:8
set start_map=scampsp1
call "%scriptspath%_handle_mod_choice.cmd" scampsp1
goto :menu

:9
set base_game=quoth
set start_map=apsp3
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" apsp3
goto :menu

:10
set start_map=wickedstart
call "%scriptspath%_handle_mod_choice.cmd" something_wicked
goto :menu

:11
set start_map=start
set skip_quakerc_gen=true
set prelaunch_msg[0]=This mod supports some unique stealth gameplay; be sure to check the
set prelaunch_msg[1]=readme for tips!
set prelaunch_msg[2]=
call "%scriptspath%_handle_mod_choice.cmd" its_demo_v1_1
goto :menu

:12
set start_map=ivory
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ivory1b
goto :menu

:13
set start_map=zendar
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" zendar1d
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
) else (
  set is_%1_installed= 
)
goto :eof
