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
call :installed_check arcane rating
call :installed_check koohoo rating
call :installed_check czgtoxic rating
call :installed_check sm82 rating
call :installed_check ant rating
call :installed_check fmb_bdg rating
call :installed_check retrojam4dlc_pulsar rating
call :installed_check plaw02 rating
call :installed_check markiesm1v2 rating
call :installed_check copper_v1_17 version
call :installed_check ctsj2 version

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
echo.
echo Releases shown here were in the installer menus in previous versions but have
echo since been removed. If a release stays on this legacies menu for six 
echo uninterrupted months, it will be removed from the legacies menu too.
echo.
if not "%force_show_legacies%"=="true" (
  echo Only currently installed releases will be shown here, since the
  echo force_show_legacies option is false in the config.
  echo.
)
if "%show_rating%"=="true" (
  echo Dropped because of a change in rating or criteria:
  if "%show_arcane%"=="true" (
    echo %is_arcane_installed%  1: arcane - Arcane ^(1997^)
  )
  if "%show_koohoo%"=="true" (
    echo %is_koohoo_installed%  2: koohoo - The Castle of Koohoo ^(2001^)
  )
  if "%show_czgtoxic%"=="true" (
    echo %is_czgtoxic_installed%  3: czgtoxic - Biotoxin ^(2001^)
  )
  if "%show_sm82%"=="true" (
    echo %is_sm82_installed%  4: sm82 - Rubicondom ^(2005^)
  )
  if "%show_ant%"=="true" (
    echo %is_ant_installed%  5: ant - Antediluvian ^(2005^)
  )
  if "%show_fmb_bdg%"=="true" (
    echo %is_fmb_bdg_installed%  6: fmb_bdg - This Onion ^(2007^)
  )
  if "%show_retrojam4dlc_pulsar%"=="true" (
    echo %is_retrojam4dlc_pulsar_installed%  7: retrojam4dlc_pulsar - The Elder Reality ^(2016^)
  )
  if "%show_plaw02%"=="true" (
    echo %is_plaw02_installed%  8: plaw02 - Waldsterben ^(2022^)
  )
  if "%show_markiesm1v2%"=="true" (
    echo %is_markiesm1v2_installed%  9: markiesm1v2 - Slip Tripping ^(2022^)
  )
  echo.
)
if "%show_version%"=="true" (
  echo Dropped because superseded by a newer version:
  if "%show_copper_v1_17%"=="true" (
    echo %is_copper_v1_17_installed% 10: copper_v1_17 - Copper 1.17 ^(2021^)
  )
  if "%show_ctsj2%"=="true" (
    echo %is_ctsj2_installed% 11: ctsj2 - Coppertone Summer Jam 2 v1.0 ^(2022^)
  )
  echo.
)
echo Enter a number to install/launch/manage one of the releases above.
echo.
echo Or, to just view its Quaddicted page, use Shift+Enter to submit your
echo choice; keep holding shift until the webpage opens.
echo.
set menu_choice=:eof
set /p menu_choice=enter your choice or just press Enter to exit:
echo.
goto %menu_choice%


REM Arcane should age out after 3/20/2023
:1
if not "%show_arcane%"=="true" (
  goto :eof
)
set start_map=arcane
call "%scriptspath%_handle_mod_choice.cmd" arcane
goto :menu

REM The Castle of Koohoo should age out after 4/6/2023
:2
if not "%show_koohoo%"=="true" (
  goto :eof
)
set start_map=start
set modsettings[0]=r_wateralpha 0.6
set modsettings[1]=r_shadows 0
set modsettings[2]=gl_flashblend 0
set modsettings[3]=gl_ztrick 0
set modsettings[4]=gl_keeptjunctions 1
set modsettings[5]=
call "%scriptspath%_handle_mod_choice.cmd" koohoo
goto :menu

REM Biotoxin should age out after 4/6/2023
:3
if not "%show_czgtoxic%"=="true" (
  goto :eof
)
set start_map=czgtoxic
call "%scriptspath%_handle_mod_choice.cmd" czgtoxic
goto :menu

REM Rubicondom should age out six months after v3.7.0
:4
if not "%show_sm82%"=="true" (
  goto :eof
)
set start_map=sm82
call "%scriptspath%_handle_mod_choice.cmd" sm82
goto :menu

REM Antediluvian should age out after 4/6/2023
:5
if not "%show_ant%"=="true" (
  goto :eof
)
set start_map=ant
call "%scriptspath%_handle_mod_choice.cmd" ant
goto :menu

REM This Onion should age out after 3/20/2023
:6
if not "%show_fmb_bdg%"=="true" (
  goto :eof
)
set start_map=fmb_bdg1
call "%scriptspath%_handle_mod_choice.cmd" fmb_bdg
goto :menu

REM The Elder Reality should age out after 4/6/2023
:7
if not "%show_retrojam4dlc_pulsar%"=="true" (
  goto :eof
)
set start_map=retrojam4dlc_pulsar
call "%scriptspath%_handle_mod_choice.cmd" retrojam4dlc_pulsar
goto :menu

REM Waldsterben should age out after 4/6/2023
:8
if not "%show_plaw02%"=="true" (
  goto :eof
)
set base_game=%latest_copper%
set start_map=plaw02
set skip_quakerc_gen=true
REM Because this archive is packaged oddly, we need to remove the top level
REM "src" dir for it to install correctly. We'll add the src dir contents
REM back in through the patch.
set junkdirs=src
set patch_url=https://neogeographica-downloads.s3.amazonaws.com/tools/quakestarter/plaw02_source.zip
call "%scriptspath%_handle_mod_choice.cmd" plaw02
goto :menu

REM Slip Tripping should age out after 4/6/2023
:9
if not "%show_markiesm1v2%"=="true" (
  goto :eof
)
set start_map=markiesm1
call "%scriptspath%_handle_mod_choice.cmd" markiesm1v2
goto :menu

REM Copper 1.17 should age out after 1/10/2023
:10
if not "%show_copper_v1_17%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" copper_v1_17
goto :menu

REM Coppertone Summer Jam 2 v1.0 should age out after 2/11/2023
:11
if not "%show_ctsj2%"=="true" (
  goto :eof
)
set start_map=start
set skip_quakerc_gen=true
call "%scriptspath%_handle_mod_choice.cmd" ctsj2
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
