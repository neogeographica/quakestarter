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
echo A selection of other maps to install ^(part 1^):
echo 1: czg07 - Insomnia ^(2000^)%czg07_installed%
echo 2: koohoo - The Castle of Koohoo ^(2001^)%koohoo_installed%
echo 3: czg03 - Ceremonial Circles ^(2001^)%czg03_installed%
echo 4: gmsp3 - Day of the Lords ^(2003^)%gmsp3_installed%
echo 5: ac - Adamantine Cruelty ^(2004^)%ac_installed%
echo 6: e1m1rmx - The Slipgate Duplex ^(2004^)%e1m1rmx_installed%
echo 7: menk - Menkalinan ^(2004^)%menk_installed%
echo 8: kinn_marcher - The Marcher Fortress ^(2005^)%kinn_marcher_installed%
echo 9: lunsp1 - Concentric Devastation ^(2005^)%lunsp1_installed%
echo 10: red777 - Red 777 ^(2005^)%red777_installed%
echo 11: fmb_bdg - This Onion ^(2007^)%fmb_bdg_installed%
echo 12: apsp2 - Plumbers Don't Wear Ties ^(2009^)%apsp2_installed%
echo 13: arwop - A Roman Wilderness Of Pain ^(2009^)%arwop_installed%
echo 14: mappi - Red Slammer ^(2010^)%mappi_installed%
echo 15: rubicon2 - Rubicon 2 ^(2011^)%rubicon2_installed%
echo 16: ne_ruins - The Altar of Storms ^(2011^)%ne_ruins_installed%
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
REM Ceremonial Circles doesn't normally have its own gamedir, but let's give it one
if not exist czg03 (
  call "%~dp0\_mod_install.cmd" czg03
  md czg03 2> nul
  md czg03\maps 2> nul
  move id1\maps\czg03.bsp czg03\maps > nul
  move id1\maps\czg03.txt czg03 > nul
)
if exist czg03 (
  call "%~dp0\_mod_launch.cmd" czg03 czg03
)
pause
goto :menu

:4
REM Day of the Lords doesn't normally have its own gamedir, but let's give it one
if not exist gmsp3 (
  call "%~dp0\_mod_install.cmd" gmsp3
  md gmsp3 2> nul
  md gmsp3\maps 2> nul
  move id1\maps\gmsp3v2.bsp gmsp3\maps > nul
  move id1\maps\gmsp3.txt gmsp3 > nul
)
if exist gmsp3 (
  call "%~dp0\_mod_launch.cmd" gmsp3 gmsp3v2
)
pause
goto :menu

:5
REM Adamantine Cruelty doesn't normally have its own gamedir, but let's give it one
if not exist ac (
  call "%~dp0\_mod_install.cmd" ac
  md ac 2> nul
  md ac\maps 2> nul
  move id1\maps\ac.bsp ac\maps > nul
  move id1\maps\acstart.bsp ac\maps > nul
  move id1\maps\ac.txt ac > nul
)
if exist ac (
  call "%~dp0\_mod_launch.cmd" ac acstart
)
pause
goto :menu

:6
REM The Slipgate Duplex doesn't normally have its own gamedir, but let's give it one
if not exist e1m1rmx (
  call "%~dp0\_mod_install.cmd" e1m1rmx
  md e1m1rmx 2> nul
  md e1m1rmx\maps 2> nul
  move id1\maps\e1m1rmx.bsp e1m1rmx\maps > nul
  move id1\maps\e1m1rmx.map e1m1rmx\maps > nul
  move id1\maps\e1m1rmx_q3.map e1m1rmx\maps > nul
  move id1\maps\e1m1rmx.txt e1m1rmx > nul
)
if exist e1m1rmx (
  call "%~dp0\_mod_launch.cmd" e1m1rmx e1m1rmx
)
pause
goto :menu

:7
REM Menkalinan doesn't normally have its own gamedir, but let's give it one
if not exist menk (
  call "%~dp0\_mod_install.cmd" menk
  md menk 2> nul
  md menk\maps 2> nul
  move id1\maps\menk.bsp menk\maps > nul
  move id1\maps\menkstart.bsp menk\maps > nul
  move id1\maps\menk.txt menk > nul
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
REM note that the "quoth" folder name is required for Quoth
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip
  if exist quoth2pt2full (
    move quoth2pt2full quoth > nul
    del /q id1\_library\quoth2pt2full.zip
  )
)
REM Red 777 doesn't normally have its own gamedir, but let's give it one
if exist quoth (
  if not exist red777 (
    call "%~dp0\_mod_install.cmd" red777
    md red777 2> nul
    md red777\maps 2> nul
    move id1\maps\red777.bsp red777\maps > nul
    move id1\maps\red777.txt red777 > nul
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "red777" install.
  echo(
  pause
  goto :menu
)
if exist red777 (
  call "%~dp0\_mod_launch.cmd" red777 red777 quoth
  echo If you launch "red777" outside of this installer, make sure to specify
  echo Quoth as the base game.
  echo(
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
REM note that the "quoth" folder name is required for Quoth
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip
  if exist quoth2pt2full (
    move quoth2pt2full quoth > nul
    del /q id1\_library\quoth2pt2full.zip
  )
)
REM Plumbers Don't Wear Ties doesn't normally have its own gamedir, but let's give it one
if exist quoth (
  if not exist apsp2 (
    call "%~dp0\_mod_install.cmd" apsp2
    md apsp2 2> nul
    md apsp2\maps 2> nul
    move id1\maps\apsp2.bsp apsp2\maps > nul
    move id1\maps\apsp2.map apsp2\maps > nul
    move id1\maps\apsp2.txt apsp2 > nul
    move id1\maps\apsp2.rmf apsp2 > nul
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "apsp2" install.
  echo(
  pause
  goto :menu
)
if exist apsp2 (
  call "%~dp0\_mod_launch.cmd" apsp2 apsp2 quoth
  echo If you launch "apsp2" outside of this installer, make sure to specify
  echo Quoth as the base game.
  echo(
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
REM Red Slammer doesn't normally have its own gamedir, but let's give it one
if not exist mappi (
  call "%~dp0\_mod_install.cmd" mappi
  md mappi 2> nul
  md mappi\maps 2> nul
  move id1\maps\mappi.bsp mappi\maps > nul
  move id1\maps\mappi.txt mappi > nul
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
  set %1_installed= - ready to play
) else (
  set %1_installed=
)
goto :eof
