@echo off

REM Installer for mapsets that fit the following criteria:
REM * released in 2016 or later
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
call :installed_check dopa
call :installed_check gotshun-never-released_levels
call :installed_check func_mapjam9_2
call :installed_check qump
call :installed_check ad_v1_70final
call :installed_check dm4jam
echo(
echo Custom episodes released in 2016 or later:
echo %dopa_installed%  1: dopa - Dimension of the Past ^(2016^)
echo %gotshun-never-released_levels_installed%  2: gotshun-never-released_levels - The "lost" levels ^(2016^)
echo %func_mapjam9_2_installed%  3: func_mapjam9_2 - Func Map Jam 9 - Contract Revoked / Knave theme ^(2017^)
echo %qump_installed%  4: qump - Quake Upstart Mapping Project ^(2017^)
echo %ad_v1_70final_installed%  5: ad_v1_70final - Arcane Dimensions 1.7 ^(2017^)
echo %dm4jam_installed%  6: dm4jam - DM4 Jam ^(2018^)
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if not exist dopa (
  call "%~dp0\_mod_install.cmd" dopa
)
if exist dopa (
  call "%~dp0\_mod_launch.cmd" dopa start
)
pause
goto :menu

:2
if not exist gotshun-never-released_levels (
  if not exist "hipnotic\pak0.pak" (
    echo This content requires missionpack 1 to currently be installed.
    echo(
    pause
    goto :menu
  ) else (
    call "%~dp0\_mod_install.cmd" gotshun-never-released_levels
  )
)
if exist gotshun-never-released_levels (
  call "%~dp0\_mod_launch.cmd" gotshun-never-released_levels q1map1 hipnotic
  if exist gotshun-never-released_levels (
    echo If you launch "gotshun-never-released_levels" outside of this installer,
    echo make sure to specify missionpack 1 as the base game.
    echo(
  )
)
pause
goto :menu

:3
REM for Func Map Jam 9 also install Quoth if necessary
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip quoth
)
if exist quoth (
  if not exist func_mapjam9_2 (
    call "%~dp0\_mod_install.cmd" func_mapjam9_2
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "func_mapjam9_2" 
  echo install.
  echo(
  pause
  goto :menu
)
if exist func_mapjam9_2 (
  call "%~dp0\_mod_launch.cmd" func_mapjam9_2 start quoth
  if exist func_mapjam9_2 (
    echo If you launch "func_mapjam9_2" outside of this installer, make sure to
    echo specify Quoth as the base game.
    echo(
  )
)
pause
goto :menu

:4
if not exist qump (
  call "%~dp0\_mod_install.cmd" qump
)
if exist qump (
  call "%~dp0\_mod_launch.cmd" qump start
)
pause
goto :menu

:5
REM for Arcane Dimensions 1.7 also install the patch
set ad_v1_70patch1_success=
if not exist ad_v1_70final (
  call "%~dp0\_mod_install.cmd" ad_v1_70final
  if exist ad_v1_70final (
    call "%~dp0\_mod_patch_install.cmd" http://www.quaddicted.com/filebase/ad_v1_70patch1.zip ad_v1_70final
  )
)
if "%ad_v1_70patch1_success%"=="false" (
  rd /q /s ad_v1_70final
  echo Failed to apply patch; rolled back the mod install. Maybe try again?
  echo If you really want to install just the unpatched mod, you can enter
  echo "install ad_v1_70final" in the Mark V console.
  echo(
  pause
  goto :menu
)
if exist ad_v1_70final (
  call "%~dp0\_mod_launch.cmd" ad_v1_70final start
)
pause
goto :menu

:6
if not exist dm4jam (
  call "%~dp0\_mod_install.cmd" dm4jam
)
if exist dm4jam (
  call "%~dp0\_mod_launch.cmd" dm4jam start
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
