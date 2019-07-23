@echo off

REM Installer for mapsets that fit the following criteria:
REM * released after Nehahra and before Arcane Dimensions
REM * a start map and at least four non-startmaps
REM * Quaddicted editor rating "Excellent"
REM * Quaddicted user rating 4.0 or better (normalized Bayesian average)

REM save working dir and change to dir that holds this script
pushd "%~dp0"

REM set the Mark V executable to use
set markv_exe=mark_v.exe

REM CD up to Mark V dir if necessary
if not exist "%markv_exe%" (
  cd ..
  if not exist "%markv_exe%" (
    echo Couldn't find "%markv_exe%" in this folder or parent folder.
    pause
    goto :exit
  )
)

:menu
cls
call :installed_check oum
call :installed_check rapture
call :installed_check soe_full
call :installed_check contract
call :installed_check terra
call :installed_check chapters
call :installed_check travail
call :installed_check warpspasm
call :installed_check rmx-pack
call :installed_check nsoe2
call :installed_check arcanum
call :installed_check dmc3
call :installed_check unforgiven
call :installed_check rrp
call :installed_check func_mapjam5
call :installed_check mapjam6
echo(
echo Modern ^(pre-2016^) custom episodes:
echo %oum_installed%  1: oum - Operation: Urth Majik ^(2001^)
echo %rapture_installed%  2: rapture - Rapture ^(2001^)
echo %soe_full_installed%  3: soe_full - Soul of Evil ^(2002^)
echo %contract_installed%  4: contract - Contract Revoked ^(2002^)
echo %terra_installed%  5: terra - Terra ^(2005^)
echo %chapters_installed%  6: chapters - Contract Revoked: The Lost Chapters ^(2005^)
echo %travail_installed%  7: travail - Travail ^(2007^)
echo %warpspasm_installed%  8: warpspasm - Warp Spasm ^(2007^)
echo %rmx-pack_installed%  9: rmx-pack - Remix Map Pack ^(2008^)
echo %nsoe2_installed% 10: nsoe2 - Soul of Evil: Indian Summer ^(2008^)
echo %arcanum_installed% 11: arcanum - Arcanum ^(2011^)
echo %dmc3_installed% 12: dmc3 - Deathmatch Classics Vol. 3 ^(2011^)
echo %unforgiven_installed% 13: unforgiven - Unforgiven ^(2011^)
echo %rrp_installed% 14: rrp - Rubicon Rumble Pack ^(2014^)
echo %func_mapjam5_installed% 15: func_mapjam5 - Func Map Jam 5 - The Qonquer Map Jam ^(2015^)
echo %mapjam6_installed% 16: mapjam6 - Func Map Jam 6 - Fire and Brimstone ^(2015^)
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if not exist oum (
  call "%~dp0\_mod_install.cmd" oum
)
if exist oum (
  call "%~dp0\_mod_launch.cmd" oum start
)
pause
goto :menu

:2
if not exist rapture (
  call "%~dp0\_mod_install.cmd" rapture
)
if exist rapture (
  call "%~dp0\_mod_launch.cmd" rapture start
)
pause
goto :menu

:3
if not exist soe_full (
  call "%~dp0\_mod_install.cmd" soe_full
)
if exist soe_full (
  call "%~dp0\_mod_launch.cmd" soe_full start
)
pause
goto :menu

:4
if not exist contract (
  call "%~dp0\_mod_install.cmd" contract
)
if exist contract (
  call "%~dp0\_mod_launch.cmd" contract start
)
pause
goto :menu

:5
if not exist terra (
  call "%~dp0\_mod_install.cmd" terra
)
if exist terra (
  call "%~dp0\_mod_launch.cmd" terra terra1
)
pause
goto :menu

:6
if not exist chapters (
  call "%~dp0\_mod_install.cmd" chapters
)
if exist chapters (
  call "%~dp0\_mod_launch.cmd" chapters start hipnotic
  if exist chapters (
    echo If you launch "chapters" outside of this installer, make sure to specify
    echo missionpack 1 as the base game. In this case, that base game is
    echo necessary even if you don't have missionpack 1 currently installed.
    echo(
  )
)
pause
goto :menu

:7
REM for Travail also install the soundtrack
set quake_travail_soundtrack_markv_fix_success=
if not exist travail (
  call "%~dp0\_mod_install.cmd" travail
  if exist travail (
    call "%~dp0\_mod_patch_install.cmd" http://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/quake_travail_soundtrack_markv.zip travail music_placeholder_delete_me.pak
  )
)
if "%quake_travail_soundtrack_markv_fix_success%"=="false" (
  rd /q /s travail
  echo Failed to get mod soundtrack; rolled back the mod install. Maybe try
  echo again? If you want to install just the mod without its soundtrack, you
  echo can enter "install travail" in the Mark V console.
  echo(
  pause
  goto :menu
)
if exist travail (
  call "%~dp0\_mod_launch.cmd" travail start
)
pause
goto :menu

:8
REM for Warp Spasm also install Quoth if necessary
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip quoth
)
if exist quoth (
  if not exist warpspasm (
    call "%~dp0\_mod_install.cmd" warpspasm
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "warpspasm"
  echo install.
  echo(
  pause
  goto :menu
)
if exist warpspasm (
  call "%~dp0\_mod_launch.cmd" warpspasm start quoth
  if exist warpspasm (
    echo If you launch "warpspasm" outside of this installer, make sure to
    echo specify Quoth as the base game.
    echo(
  )
)
pause
goto :menu

:9
if not exist rmx-pack (
  call "%~dp0\_mod_install.cmd" rmx-pack
)
if exist rmx-pack (
  call "%~dp0\_mod_launch.cmd" rmx-pack start
)
pause
goto :menu

:10
if not exist nsoe2 (
  call "%~dp0\_mod_install.cmd" nsoe2
)
if exist nsoe2 (
  call "%~dp0\_mod_launch.cmd" nsoe2 start
)
pause
goto :menu

:11
REM for Arcanum also install the Drake mod
set drake290111_success=
if not exist arcanum (
  call "%~dp0\_mod_install.cmd" arcanum
  if exist arcanum (
    call "%~dp0\_mod_patch_install.cmd" http://www.quaddicted.com/filebase/drake290111.zip arcanum
  )
)
if "%drake290111_success%"=="false" (
  rd /q /s arcanum
  echo Failed to install the required "Drake" mod; rolled back the mod install.
  echo Maybe try again?
  echo(
  pause
  goto :menu
)
if exist arcanum (
  call "%~dp0\_mod_launch.cmd" arcanum arcstart
)
pause
goto :menu

:12
if not exist dmc3 (
  call "%~dp0\_mod_install.cmd" dmc3
)
if exist dmc3 (
  call "%~dp0\_mod_launch.cmd" dmc3 dmc3
)
pause
goto :menu

:13
if not exist unforgiven (
  call "%~dp0\_mod_install.cmd" unforgiven
)
if exist unforgiven (
  call "%~dp0\_mod_launch.cmd" unforgiven unfstart
)
pause
goto :menu

:14
if not exist rrp (
  call "%~dp0\_mod_install.cmd" rrp
)
if exist rrp (
  call "%~dp0\_mod_launch.cmd" rrp start
)
pause
goto :menu

:15
REM for Func Map Jam 5 also install the Quicker Qonquer mod
set QuickerQonquer_success=
if not exist func_mapjam5 (
  call "%~dp0\_mod_install.cmd" func_mapjam5
  if exist func_mapjam5 (
    call "%~dp0\_mod_patch_install.cmd" http://www.quaddicted.com/files/mods/QuickerQonquer.zip func_mapjam5 maps\QArena.bsp maps\QStart.bsp
  )
)
if "%QuickerQonquer_success%"=="false" (
  rd /q /s func_mapjam5
  echo Failed to apply the "Quicker Qonquer" patch; rolled back the mod install.
  echo Maybe try again? If you really want to install just the unpatched mod,
  echo you can enter "install func_mapjam5" in the Mark V console.
  echo(
  pause
  goto :menu
)
if exist func_mapjam5 (
  call "%~dp0\_mod_launch.cmd" func_mapjam5 start
)
pause
goto :menu

:16
if not exist mapjam6 (
  call "%~dp0\_mod_install.cmd" mapjam6
)
if exist mapjam6 (
  call "%~dp0\_mod_launch.cmd" mapjam6 start
)
pause
goto :menu

:menu_exit
popd
goto :eof


REM functions used above

:installed_check
if exist "%1" (
  set %1_installed=*
) else (
  set %1_installed= 
)
goto :eof
