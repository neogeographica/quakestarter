@echo off

REM Installer for stuff that has been removed from the main menus.
REM Periodically things will get culled from here as well.

REM set the default value to return if "check" arg is used
set show_legacies_menu=false

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
set show_rating=false
set show_version=false
call :installed_check mappi rating
call :installed_check e1m5quotha rating
call :installed_check mstalk1c rating
call :installed_check func_mapjam1 rating
call :installed_check ad_v1_70final version

REM if called with "check" arg just decide whether to show this menu at all
if "%~1"=="check" (
  if "%show_rating%"=="true" goto :checksuccess
  if "%show_version%"=="true" goto :checksuccess
  goto :eof
)

if "%show_rating%"=="false" (
  if "%show_version%"=="false" (
    goto :eof
  )
)

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
echo.
echo Releases shown here were in the installer menus in previous versions but
echo have since been removed.
echo.
if not "%force_show_legacies%"=="true" (
  echo Only currently installed releases will be shown here, since the
  echo force_show_legacies option is false in the config.
  echo.
)
if "%show_rating%"=="true" (
  echo Dropped because of a change in rating or criteria:
  if "%show_mappi%"=="true" (
    echo %is_mappi_installed%  1: mappi - mappi - Red Slammer ^(2010^)
  )
  if "%show_e1m5quotha%"=="true" (
    echo %is_e1m5quotha_installed%  2: e1m5quotha - Gloomier Keep ^(2012^)
  )
  if "%show_mstalk1c%"=="true" (
    echo %is_mstalk1c_installed%  3: mstalk1c - Midnight Stalker ^(2013^)
  )
  if "%show_func_mapjam1%"=="true" (
    echo %is_func_mapjam1_installed%  4: func_mapjam1 - Func Map Jam 1 - Honey Theme ^(2014^)
  )
  echo.
)
if "%show_version%"=="true" (
  echo Dropped because superseded by a newer version:
  if "%show_ad_v1_70final%"=="true" (
    echo %is_ad_v1_70final_installed%  5: ad_v1_70final - Arcane Dimensions 1.7 ^(2017^)
  )
  echo.
)
set menu_choice=:eof
set /p menu_choice=choose a number or just press Enter to exit:
echo.
goto %menu_choice%

:1
if not "%show_mappi%"=="true" (
  goto :eof
)
set start_map=mappi
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/mappi.zip
pause
goto :menu

:2
if not "%show_e1m5quotha%"=="true" (
  goto :eof
)
set base_game=quoth
set start_map=e1m5quotha
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/e1m5quotha.zip
pause
goto :menu

:3
if not "%show_mstalk1c%"=="true" (
  goto :eof
)
set start_map=mstalk
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/mstalk1c.zip
pause
goto :menu

:4
if not "%show_func_mapjam1%"=="true" (
  goto :eof
)
set modsettings[0]=scr_conspeed 1000    
set modsettings[1]=r_wateralpha 0.65    
set modsettings[2]=r_oldwater 1 
set modsettings[3]= 
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/func_mapjam1.zip
pause
goto :menu

:5
if not "%show_ad_v1_70final%"=="true" (
  goto :eof
)
set patch_url=https://www.quaddicted.com/filebase/ad_v1_70patch1.zip
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" https://www.quaddicted.com/filebase/ad_v1_70final.zip
pause
goto :menu


REM functions used above

:installed_check
if exist "%basedir%\%1" (
  set is_%1_installed=*
  set show_%1=true
  set show_%2=true
) else (
  set is_%1_installed= 
  if "%force_show_legacies%"=="true" (
    set show_%1=true
    set show_%2=true
  ) else (
    set show_%1=false
  )
)
goto :eof

:checksuccess
endlocal
set show_legacies_menu=true
goto :eof
