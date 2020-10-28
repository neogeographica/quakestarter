@echo off

REM Installer for maps that fit the following criteria:
REM * it (or a variant) is NOT included in other selected episodes
REM * Quaddicted editor rating "Excellent"
REM * Quaddicted user rating 4.5 or better (normalized Bayesian average)

setlocal

REM remember dir where this script lives
set scriptsdir=%~dp0

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
  echo Couldn't find the id1 folder in this script's folder or parent folder.
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
set has_startdemos=false
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
echo.
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
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set start_map=czg07
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/czg07.zip
pause
goto :menu

:2
set start_map=start
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/koohoo.zip
pause
goto :menu

:3
set start_map=czg03
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/czg03.zip
pause
goto :menu

:4
set start_map=gmsp3v2
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/gmsp3.zip
pause
goto :menu

:5
set start_map=acstart
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ac.zip
pause
goto :menu

:6
set start_map=e1m1rmx
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/e1m1rmx.zip
pause
goto :menu

:7
set start_map=menkstart
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/menk.zip
pause
goto :menu

:8
set start_map=marcher
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/kinn_marcher.zip
pause
goto :menu

:9
set start_map=lunsp1
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/lunsp1.zip
pause
goto :menu

:10
set base_game=quoth
set start_map=red777
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/red777.zip
pause
goto :menu

:11
set start_map=fmb_bdg1
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/fmb_bdg.zip
pause
goto :menu

:12
set base_game=quoth
set start_map=apsp2
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/apsp2.zip
pause
goto :menu

:13
set start_map=start
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/arwop.zip
pause
goto :menu

:14
set start_map=mappi
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/mappi.zip
pause
goto :menu

:15
set start_map=start
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/rubicon2.zip
pause
goto :menu

:16
set start_map=start
call "%scriptsdir%\_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ne_ruins.zip
pause
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set %1_installed=*
) else (
  set %1_installed= 
)
goto :eof
