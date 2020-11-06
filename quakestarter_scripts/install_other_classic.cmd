@echo off

REM Installer for maps that fit the following criteria:
REM * released through 2005
REM * Quaddicted editor rating "Excellent"
REM * Quaddicted user rating 4.5 or better (normalized Bayesian average)

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
set skip_quakerc_gen=false
set modsettings[0]=
set startdemos=
cls
call :installed_check czg07
call :installed_check koohoo
call :installed_check czg03
call :installed_check gmsp3
call :installed_check ac
call :installed_check e1m1rmx
call :installed_check menk
call :installed_check kinn_marcher
echo.
echo Selected other custom maps released through 2005:
echo %czg07_installed%  1: czg07 - Insomnia ^(2000^)
echo %koohoo_installed%  2: koohoo - The Castle of Koohoo ^(2001^)
echo %czg03_installed%  3: czg03 - Ceremonial Circles ^(2001^)
echo %gmsp3_installed%  4: gmsp3 - Day of the Lords ^(2003^)
echo %ac_installed%  5: ac - Adamantine Cruelty ^(2004^)
echo %e1m1rmx_installed%  6: e1m1rmx - The Slipgate Duplex ^(2004^)
echo %menk_installed%  7: menk - Menkalinan ^(2004^)
echo %kinn_marcher_installed%  8: kinn_marcher - The Marcher Fortress ^(2005^)
echo.
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
set start_map=czg07
set modsettings[0]=r_wateralpha 1
set modsettings[1]=gl_flashblend 0
set modsettings[2]=r_shadows 0
set modsettings[3]=gl_subdivide_size 1024
set modsettings[4]=r_maxsurfs 900
set modsettings[5]=r_maxedges 2800
set modsettings[6]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/czg07.zip
pause
goto :menu

:2
set start_map=start
set modsettings[0]=r_wateralpha 0.6
set modsettings[1]=r_shadows 0
set modsettings[2]=gl_flashblend 0
set modsettings[3]=gl_ztrick 0
set modsettings[4]=gl_keeptjunctions 1
set modsettings[5]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/koohoo.zip
pause
goto :menu

:3
set start_map=czg03
set modsettings[0]=r_wateralpha 1
set modsettings[1]=r_shadows 0
set modsettings[2]=gl_flashblend 0
set modsettings[3]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/czg03.zip
pause
goto :menu

:4
set start_map=gmsp3v2
set modsettings[0]=r_maxsurfs 1200
set modsettings[1]=r_maxedges 4000
set modsettings[2]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/gmsp3.zip
pause
goto :menu

:5
set start_map=acstart
set modsettings[0]=r_wateralpha 0.3
set modsettings[1]=r_maxedges 4000
set modsettings[2]=r_maxsurfs 4000
set modsettings[3]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ac.zip
pause
goto :menu

:6
set start_map=e1m1rmx
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/e1m1rmx.zip
pause
goto :menu

:7
set start_map=menkstart
set modsettings[0]=r_maxedges 10000
set modsettings[1]=r_maxsurfs 10000
set modsettings[2]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/menk.zip
pause
goto :menu

:8
set start_map=marcher
set modsettings[0]=r_maxedges 100000
set modsettings[1]=r_maxsurfs 100000
set modsettings[2]=r_waterwarp 0
set modsettings[3]=gl_clear 1
set modsettings[4]=r_clearcolor 2
set modsettings[5]=gl_farclip 16384
set modsettings[6]=r_farclip 16384
set modsettings[7]=
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/kinn_marcher.zip
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
