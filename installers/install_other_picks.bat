@echo off

REM Installer for maps that fit the following criteria:
REM * released in 2016 or earlier
REM * it (or a variant) is NOT included in Arcane Dimensions
REM * it (or a variant) is NOT included in other selected episodes
REM * Quaddicted editor rating "Excellent"
REM * Quaddicted user rating 4.5 or better

REM save working dir and change to dir that holds this script
pushd "%~dp0"

REM set the Mark V executable to use
set markv_exe=mark_v.exe

REM CD up to Mark V dir if necessary
if not exist "%markv_exe%" (
  cd ..
  if not exist "%markv_exe%" (
    echo Couldn't find "%markv_exe%" in this folder or parent folder.
    goto :exit 
  )
)

:menu
call :installed_check czg07
call :installed_check gmsp3
call :installed_check kinn_marcher
call :installed_check rubicon2
call :installed_check ne_ruins
call :installed_check honey
call :installed_check apsp3
call :installed_check ivory1b
call :installed_check func_mapjam2
call :installed_check mapjam6
echo(
echo A selection of other maps to install:
echo 1: czg07 - Insomnia (2000)%czg07_installed%
echo 2: gmsp3 - Day of the Lords (2003)%gmsp3_installed%
echo 3: kinn_marcher - The Marcher Fortress (2005)%kinn_marcher_installed%
echo 4: rubicon2 - Rubicon 2 (2011)%rubicon2_installed%
echo 5: ne_ruins - The Altar of Storms (2011)%ne_ruins_installed%
echo 6: honey - Honey (2012)%honey_installed%
echo 7: apsp3 - Subterranean Library (2012)%apsp3_installed%
echo 8: ivory1b - The Ivory Tower (2013)%ivory1b_installed%
echo 9: func_mapjam2 - Func Map Jam 2 (2014)%func_mapjam2_installed%
echo 10: mapjam6 - Func Map Jam 6 (2015)%mapjam6_installed%
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if exist czg07 (
  echo The "czg07" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" czg07
)
goto :menu

:2
REM Day of the Lords doesn't normally have its own gamedir, but let's give it one
if exist gmsp3 (
  echo The "gmsp3" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" gmsp3
  md gmsp3 2> nul
  md gmsp3\maps 2> nul
  move id1\maps\gmsp3v2.bsp gmsp3\maps > nul
  move id1\maps\gmsp3.txt gmsp3 > nul
)
goto :menu

:3
if exist kinn_marcher (
  echo The "kinn_marcher" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" kinn_marcher
)
goto :menu

:4
if exist rubicon2 (
  echo The "rubicon2" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" rubicon2
)
goto :menu

:5
if exist ne_ruins (
  echo The "ne_ruins" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" ne_ruins
)
goto :menu

:6
if exist honey (
  echo The "honey" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" honey
)
goto :menu

:7
REM for Subterranean Library also install Quoth if necessary
REM note that the "quoth" folder name is required for Quoth
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip
  if exist quoth2pt2full (
    move quoth2pt2full quoth > nul
    del /q id1\_library\quoth2pt2full.zip
  )
)
if exist quoth (
  if exist apsp3 (
    echo The "apsp3" gamedir already exists.
  ) else (
    call "%~dp0\_mod_install.cmd" apsp3
    call :apsp3_fix
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "apsp3" install.
)
echo Make sure to specify Quoth as the base game when playing "apsp3".
goto :menu

:8
if exist ivory1b (
  echo The "ivory1b" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" ivory1b
)
goto :menu

:9
if exist func_mapjam2 (
  echo The "func_mapjam2" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" func_mapjam2
  call :func_mapjam2_fix
)
goto :menu

:10
if exist mapjam6 (
  echo The "mapjam6" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" mapjam6
  call :mapjam6_fix
)
goto :menu

:menu_exit
pause
popd
goto :eof


REM functions used above

:installed_check
if exist "%1" (
  set %1_installed= - already installed
) else (
  set %1_installed=
)
goto :eof

REM Mark V as of build 1020 does not correctly extract apsp3
REM so we'll do it from this batch file if possible.
:apsp3_fix
if exist apsp3\maps\apsp3.bsp (
  goto :eof
)
del /q id1\apsp3.* 2> nul
del /q id1\maps\apsp3.bsp 2> nul
del /q id1\sound\ambience\blood.wav 2> nul
REM delete these uncommon dirs if empty
rd id1\sound\ambience 2> nul
rd id1\sound 2> nul
call :net45_check
if "%net45_installed%"=="true" (
  echo Fixing some install issues...
  powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('id1\_library\apsp3.zip', '.'); }"
)
if exist apsp3\maps\apsp3.bsp (
  goto :eof
)
md apsp3 2> nul
echo Mark V has issues installing "apsp3".
echo You can get "apsp3.zip" from the "id1\_library folder" and
echo extract it manually into the "id1\apsp3" folder.
goto :eof

REM Mark V as of build 1020 does not correctly extract func_mapjam2
REM so we'll do it from this batch file if possible.
:func_mapjam2_fix
if exist func_mapjam2\maps\jam2_cocerello.bsp (
  goto :eof
)
del /q id1\maps\jam2_*.* 2> nul
call :net45_check
if "%net45_installed%"=="true" (
  echo Fixing some install issues...
  powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('id1\_library\func_mapjam2.zip', 'func_mapjam2'); }"
)
if exist func_mapjam2\maps\jam2_cocerello.bsp (
  goto :eof
)
md func_mapjam2 2> nul
echo Mark V has issues installing "func_mapjam2".
echo You can get "func_mapjam2.zip" from the "id1\_library folder" and
echo extract it manually into the "id1\func_mapjam2" folder.
goto :eof

REM Mark V as of build 1020 does not correctly extract mapjam6
REM so we'll do it from this batch file if possible.
:mapjam6_fix
if exist mapjam6\maps\start.bsp (
  goto :eof
)
del /q id1\maps\jam6_*.* 2> nul
del /q id1\maps\start.bsp 2> nul
del /q id1\maps\start.lit 2> nul
call :net45_check
if "%net45_installed%"=="true" (
  echo Fixing some install issues...
  powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('id1\_library\mapjam6.zip', 'mapjam6'); }"
)
if exist mapjam6\maps\start.bsp (
  goto :eof
)
md mapjam6 2> nul
echo Mark V has issues installing "mapjam6".
echo You can get "mapjam6.zip" from the "id1\_library folder" and
echo extract it manually into the "id1\mapjam6" folder.
goto :eof

:net45_check
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release > nul 2>&1
if %errorlevel% equ 0 (
  set net45_installed=true
) else (
  set net45_installed=false
)
goto :eof
