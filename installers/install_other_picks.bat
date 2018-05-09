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
call :installed_check czg07
call :installed_check koohoo
call :installed_check czg03
call :installed_check gmsp3
call :installed_check ac
call :installed_check e1m1rmx
call :installed_check menk
call :installed_check kinn_marcher
call :installed_check lunsp1
call :installed_check red777
call :installed_check fmb_bdg
call :installed_check apsp2
call :installed_check arwop
call :installed_check mappi
call :installed_check rubicon2
call :installed_check ne_ruins
echo(
echo A selection of other maps ^(part 1^):
echo %czg07_installed%  1: czg07 - Insomnia ^(2000^)
echo %koohoo_installed%  2: koohoo - The Castle of Koohoo ^(2001^)
echo %czg03_installed%  3: czg03 - Ceremonial Circles ^(2001^)
echo %gmsp3_installed%  4: gmsp3 - Day of the Lords ^(2003^)
echo %ac_installed%  5: ac - Adamantine Cruelty ^(2004^)
echo %e1m1rmx_installed%  6: e1m1rmx - The Slipgate Duplex ^(2004^)
echo %menk_installed%  7: menk - Menkalinan ^(2004^)
echo %kinn_marcher_installed%  8: kinn_marcher - The Marcher Fortress ^(2005^)
echo %lunsp1_installed%  9: lunsp1 - Concentric Devastation ^(2005^)
echo %red777_installed% 10: red777 - Red 777 ^(2005^)
echo %fmb_bdg_installed% 11: fmb_bdg - This Onion ^(2007^)
echo %apsp2_installed% 12: apsp2 - Plumbers Don't Wear Ties ^(2009^)
echo %arwop_installed% 13: arwop - A Roman Wilderness Of Pain ^(2009^)
echo %mappi_installed% 14: mappi - Red Slammer ^(2010^)
echo %rubicon2_installed% 15: rubicon2 - Rubicon 2 ^(2011^)
echo %ne_ruins_installed% 16: ne_ruins - The Altar of Storms ^(2011^)
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if not exist czg07 (
  call "%~dp0\_mod_install.cmd" czg07
)
if exist czg07 (
  call "%~dp0\_mod_launch.cmd" czg07 czg07
)
pause
goto :menu

:2
if not exist koohoo (
  call "%~dp0\_mod_install.cmd" koohoo
)
if exist koohoo (
  call "%~dp0\_mod_launch.cmd" koohoo start
)
pause
goto :menu

:3
if not exist czg03 (
  call "%~dp0\_mod_install.cmd" czg03
)
if exist czg03 (
  call "%~dp0\_mod_launch.cmd" czg03 czg03
)
pause
goto :menu

:4
if not exist gmsp3 (
  call "%~dp0\_mod_install.cmd" gmsp3
)
if exist gmsp3 (
  call "%~dp0\_mod_launch.cmd" gmsp3 gmsp3v2
)
pause
goto :menu

:5
if not exist ac (
  call "%~dp0\_mod_install.cmd" ac
)
if exist ac (
  call "%~dp0\_mod_launch.cmd" ac acstart
)
pause
goto :menu

:6
if not exist e1m1rmx (
  call "%~dp0\_mod_install.cmd" e1m1rmx
)
if exist e1m1rmx (
  call "%~dp0\_mod_launch.cmd" e1m1rmx e1m1rmx
)
pause
goto :menu

:7
if not exist menk (
  call "%~dp0\_mod_install.cmd" menk
)
if exist menk (
  call "%~dp0\_mod_launch.cmd" menk menkstart
)
pause
goto :menu

:8
if not exist kinn_marcher (
  call "%~dp0\_mod_install.cmd" kinn_marcher
)
if exist kinn_marcher (
  call "%~dp0\_mod_launch.cmd" kinn_marcher marcher
)
pause
goto :menu

:9
if not exist lunsp1 (
  call "%~dp0\_mod_install.cmd" lunsp1
)
if exist lunsp1 (
  call "%~dp0\_mod_launch.cmd" lunsp1 lunsp1
)
pause
goto :menu

:10
REM for Red 777 also install Quoth if necessary
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip quoth
)
if exist quoth (
  if not exist red777 (
    call "%~dp0\_mod_install.cmd" red777
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "red777" install.
  echo(
  pause
  goto :menu
)
if exist red777 (
  call "%~dp0\_mod_launch.cmd" red777 red777 quoth
  if exist red777 (
    echo If you launch "red777" outside of this installer, make sure to specify
    echo Quoth as the base game.
    echo(
  )
)
pause
goto :menu

:11
if not exist fmb_bdg (
  call "%~dp0\_mod_install.cmd" fmb_bdg
)
if exist fmb_bdg (
  call "%~dp0\_mod_launch.cmd" fmb_bdg fmb_bdg1
)
pause
goto :menu

:12
REM for Plumbers Don't Wear Ties also install Quoth if necessary
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip quoth
)
if exist quoth (
  if not exist apsp2 (
    call "%~dp0\_mod_install.cmd" apsp2
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "apsp2" install.
  echo(
  pause
  goto :menu
)
if exist apsp2 (
  call "%~dp0\_mod_launch.cmd" apsp2 apsp2 quoth
  if exist apsp2 (
    echo If you launch "apsp2" outside of this installer, make sure to specify
    echo Quoth as the base game.
    echo(
  )
)
pause
goto :menu

:13
if not exist arwop (
  call "%~dp0\_mod_install.cmd" arwop
)
if exist arwop (
  call "%~dp0\_mod_launch.cmd" arwop start
)
pause
goto :menu

:14
if not exist mappi (
  call "%~dp0\_mod_install.cmd" mappi
)
if exist mappi (
  call "%~dp0\_mod_launch.cmd" mappi mappi
)
pause
goto :menu

:15
if not exist rubicon2 (
  call "%~dp0\_mod_install.cmd" rubicon2
)
if exist rubicon2 (
  call "%~dp0\_mod_launch.cmd" rubicon2 start
)
pause
goto :menu

:16
if not exist ne_ruins (
  call "%~dp0\_mod_install.cmd" ne_ruins
)
if exist ne_ruins (
  call "%~dp0\_mod_launch.cmd" ne_ruins start
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
