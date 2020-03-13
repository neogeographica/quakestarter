@echo off

REM Installer for maps that fit the following criteria:
REM * it (or a variant) is NOT included in other selected episodes
REM * Quaddicted editor rating "Excellent"
REM * Quaddicted user rating 4.5 or better (normalized Bayesian average)

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
call :installed_check honey
call :installed_check e1m5quotha
call :installed_check apsp3
call :installed_check something_wicked
call :installed_check fmb_bdg2
call :installed_check mstalk1c
call :installed_check ivory1b
call :installed_check func_mapjam1
call :installed_check func_mapjam2
call :installed_check func_mapjam3
call :installed_check retrojam6
call :installed_check grim_rezipped
echo(
echo A selection of other maps ^(part 2^):
echo %honey_installed% 17: honey - Honey ^(2012^)
echo %e1m5quotha_installed% 18: e1m5quotha - Gloomier Keep ^(2012^)
echo %apsp3_installed% 19: apsp3 - Subterranean Library ^(2012^)
echo %something_wicked_installed% 20: something_wicked - Something Wicked This Way Comes ^(2012^)
echo %fmb_bdg2_installed% 21: fmb_bdg2 - For My Babies - Bin Dunne Gorne 2 ^(2013^)
echo %mstalk1c_installed% 22: mstalk1c - Midnight Stalker ^(2013^)
echo %ivory1b_installed% 23: ivory1b - The Ivory Tower ^(2013^)
echo %func_mapjam1_installed% 24: func_mapjam1 - Func Map Jam 1 - Honey Theme ^(2014^)
echo %func_mapjam2_installed% 25: func_mapjam2 - Func Map Jam 2 - IKblue/IKwhite Theme ^(2014^)
echo %func_mapjam3_installed% 26: func_mapjam3 - Func Map Jam 3 - Zerstoerer theme ^(2014^)
echo %retrojam6_installed% 27: retrojam6 - Retro Jam 6 - Egyptian theme ^(2017^)
echo %grim_rezipped_installed% 28: grim_rezipped - The Grim Outpost ^(2018^)
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:17
if not exist honey (
  call "%~dp0\_mod_install.cmd" honey
)
if exist honey (
  call "%~dp0\_mod_launch.cmd" honey start
)
pause
goto :menu

:18
REM for Gloomier Keep also install Quoth if necessary
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip quoth
)
if exist quoth (
  if not exist e1m5quotha (
    call "%~dp0\_mod_install.cmd" e1m5quotha
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "e1m5quotha"
  echo install.
  echo(
  pause
  goto :menu
)
if exist e1m5quotha (
  call "%~dp0\_mod_launch.cmd" e1m5quotha e1m5quotha quoth
  if exist e1m5quotha (
    echo If you launch "e1m5quotha" outside of this installer, make sure to
    echo specify Quoth as the base game.
    echo(
  )
)
pause
goto :menu

:19
REM for Subterranean Library also install Quoth if necessary
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip quoth
)
if exist quoth (
  if not exist apsp3 (
    call "%~dp0\_mod_install.cmd" apsp3
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "apsp3" install.
  echo(
  pause
  goto :menu
)
if exist apsp3 (
  call "%~dp0\_mod_launch.cmd" apsp3 apsp3 quoth
  if exist apsp3 (
    echo If you launch "apsp3" outside of this installer, make sure to specify
    echo Quoth as the base game.
    echo(
  )
)
pause
goto :menu

:20
if not exist something_wicked (
  call "%~dp0\_mod_install.cmd" something_wicked
)
if exist something_wicked (
  call "%~dp0\_mod_launch.cmd" something_wicked wickedstart
)
pause
goto :menu

:21
if not exist fmb_bdg2 (
  call "%~dp0\_mod_install.cmd" fmb_bdg2
  del /q fmb_bdg2\bat
)
if exist fmb_bdg2 (
  call "%~dp0\_mod_launch.cmd" fmb_bdg2 start_____
)
pause
goto :menu

:22
if not exist mstalk1c (
  call "%~dp0\_mod_install.cmd" mstalk1c
)
if exist mstalk1c (
  call "%~dp0\_mod_launch.cmd" mstalk1c mstalk
)
pause
goto :menu

:23
if not exist ivory1b (
  call "%~dp0\_mod_install.cmd" ivory1b
)
if exist ivory1b (
  call "%~dp0\_mod_launch.cmd" ivory1b ivory
)
pause
goto :menu

:24
if not exist func_mapjam1 (
  call "%~dp0\_mod_install.cmd" func_mapjam1
)
if exist func_mapjam1 (
  call "%~dp0\_mod_launch.cmd" func_mapjam1
)
pause
goto :menu

:25
if not exist func_mapjam2 (
  call "%~dp0\_mod_install.cmd" func_mapjam2
)
if exist func_mapjam2 (
  call "%~dp0\_mod_launch.cmd" func_mapjam2
)
pause
goto :menu

:26
REM for Func Map Jam 3 also install the patch
set jam3_mfx_fix_success=
if not exist func_mapjam3 (
  call "%~dp0\_mod_install.cmd" func_mapjam3
  if exist func_mapjam3 (
    call "%~dp0\_mod_patch_install.cmd" http://www.quaddicted.com/filebase/jam3_mfx_fix.zip func_mapjam3
  )
)
if "%jam3_mfx_fix_success%"=="false" (
  rd /q /s func_mapjam3
  echo Failed to apply patch; rolled back the mod install. Maybe try again?
  echo If you really want to install just the unpatched mod, you can enter
  echo "install func_mapjam3" in the Mark V console.
  echo(
  pause
  goto :menu
)
if exist func_mapjam3 (
  echo Note that this mod happens to include the original Zerstoerer campaign
  echo maps, but for the Func Jam 3 maps you will want to pick maps with names
  echo that begin with "jam3_".
  echo(
  call "%~dp0\_mod_launch.cmd" func_mapjam3
)
pause
goto :menu

:27
if not exist retrojam6 (
  call "%~dp0\_mod_install.cmd" retrojam6
)
if exist retrojam6 (
  call "%~dp0\_mod_launch.cmd" retrojam6
)
pause
goto :menu

:28
if not exist grim_rezipped (
  call "%~dp0\_mod_install.cmd" grim_rezipped
)
if exist grim_rezipped (
  call "%~dp0\_mod_launch.cmd" grim_rezipped grim
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
