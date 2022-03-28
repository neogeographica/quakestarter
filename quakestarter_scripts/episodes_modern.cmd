@echo off

REM Installer for mapsets that fit the following criteria:
REM * released after Nehahra (in 2000) and before Arcane Dimensions
REM * a start map and at least four non-startmaps
REM * Quaddicted user rating 3.9 or better (normalized Bayesian average)

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
call :installed_check oum
call :installed_check rapture
call :installed_check soe_full
call :installed_check contract
call :installed_check terra
call :installed_check chapters
call :installed_check warpspasm
call :installed_check travail
call :installed_check rmx-pack
call :installed_check nsoe2
call :installed_check arcanum
call :installed_check dmc3
call :installed_check unforgiven
call :installed_check rrp
call :installed_check func_mapjam5
call :installed_check mapjam6
echo.
echo Selected custom episodes/hubs released from mid-2000 through 2015:
echo %is_oum_installed%  1: oum - Operation: Urth Majik ^(2001^)
echo %is_rapture_installed%  2: rapture - Rapture ^(2001^)
echo %is_soe_full_installed%  3: soe_full - Soul of Evil ^(2002^)
echo %is_contract_installed%  4: contract - Contract Revoked ^(2002^)
echo %is_terra_installed%  5: terra - Terra ^(2005^)
echo %is_chapters_installed%  6: chapters - Contract Revoked: The Lost Chapters ^(2005^)
echo %is_warpspasm_installed%  7: warpspasm - Warp Spasm ^(2007^)
echo %is_travail_installed%  8: travail - Travail ^(2007^)
echo %is_rmx-pack_installed%  9: rmx-pack - Remix Map Pack ^(2008^)
echo %is_nsoe2_installed% 10: nsoe2 - Soul of Evil: Indian Summer ^(2008^)
echo %is_arcanum_installed% 11: arcanum - Arcanum ^(2011^)
echo %is_dmc3_installed% 12: dmc3 - Deathmatch Classics Vol. 3 ^(2011^)
echo %is_unforgiven_installed% 13: unforgiven - Unforgiven ^(2011^)
echo %is_rrp_installed% 14: rrp - Rubicon Rumble Pack ^(2014^)
echo %is_func_mapjam5_installed% 15: func_mapjam5 - Func Map Jam 5 - The Qonquer Map Jam ^(2015^)
echo %is_mapjam6_installed% 16: mapjam6 - Func Map Jam 6 - Fire and Brimstone ^(2015^)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/oum.zip
pause
goto :menu

:2
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/rapture.zip
pause
goto :menu

:3
set start_map=start
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/soe_full.zip
pause
goto :menu

:4
set start_map=start
REM This demo1 is just a game against reaperbots? Not sure it's really meant
REM to be used for startdemos.
REM set startdemos=demo1
set modsettings[0]=r_wateralpha 0.5
set modsettings[1]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/contract.zip
pause
goto :menu

:5
set start_map=terra1
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/terra.zip
pause
goto :menu

:6
set start_map=start
set extra_launch_args=-hipnotic
set postlaunch_msg[0]=If you launch "chapters" outside of this installer, make sure to specify
set postlaunch_msg[1]=missionpack 1 as the base game ^("-hipnotic" arg^). In this case, that base
set postlaunch_msg[2]=game is necessary even if you don't have missionpack 1 currently installed.
set postlaunch_msg[3]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/chapters.zip
pause
goto :menu

:7
set base_game=quoth
set start_map=start
set skip_quakerc_gen=true
set startdemos=demo1 demo2 demo3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/warpspasm.zip
pause
goto :menu

:8
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/quake_travail_soundtrack.zip
set start_map=start
set startdemos=demo1 demo2 demo3
set modsettings[0]=r_oldwater 0
set modsettings[1]=r_waterquality 32
set modsettings[2]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/travail.zip
pause
goto :menu

:9
set start_map=start
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/rmx-pack.zip
pause
goto :menu

:10
set start_map=start
set startdemos=demo1 demo2
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/nsoe2.zip
pause
goto :menu

:11
set patch_url=https://www.quaddicted.com/filebase/drake290111.zip
REM unlike other patches the Drake mod is really truly always required here
set patch_required=true
set start_map=arcstart
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/arcanum.zip
pause
goto :menu

:12
set start_map=dmc3
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/dmc3.zip
pause
goto :menu

:13
set start_map=unfstart
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/unforgiven.zip
pause
goto :menu

:14
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/rrp.zip
pause
goto :menu

:15
set patch_url=https://www.quaddicted.com/files/mods/QuickerQonquer.zip
set patch_skipfiles=maps\QArena.bsp maps\QStart.bsp
set start_map=start
set startdemos=demo1
set modsettings[0]=scr_conspeed 1000
set modsettings[1]=r_wateralpha 0.65
set modsettings[2]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam5.zip
pause
goto :menu

:16
set start_map=start
set startdemos=demo1
set modsettings[0]=r_wateralpha 1
set modsettings[1]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/mapjam6.zip
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
