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
echo Modern ^(pre-2016^) custom episodes to install:
echo 1: oum - Operation: Urth Majik ^(2001^)%oum_installed%
echo 2: rapture - Rapture ^(2001^)%rapture_installed%
echo 3: soe_full - Soul of Evil ^(2002^)%soe_full_installed%
echo 4: contract - Contract Revoked ^(2002^)%contract_installed%
echo 5: terra - Terra ^(2005^)%terra_installed%
echo 6: chapters - Contract Revoked: The Lost Chapters ^(2005^)%chapters_installed%
echo 7: travail - Travail ^(2007^)%travail_installed%
echo 8: warpspasm - Warp Spasm ^(2007^)%warpspasm_installed%
echo 9: rmx-pack - Remix Map Pack ^(2008^)%rmx-pack_installed%
echo 10: nsoe2 - Soul of Evil: Indian Summer ^(2008^)%nsoe2_installed%
echo 11: arcanum - Arcanum ^(2011^)%arcanum_installed%
echo 12: dmc3 - Deathmatch Classics Vol. 3 ^(2011^)%dmc3_installed%
echo 13: unforgiven - Unforgiven ^(2011^)%unforgiven_installed%
echo 14: rrp - Rubicon Rumble Pack ^(2014^)%rrp_installed%
echo 15: func_mapjam5 - Func Map Jam 5 - The Qonquer Map Jam ^(2015^)%func_mapjam5_installed%
echo 16: mapjam6 - Func Map Jam 6 - Fire and Brimstone ^(2015^)%mapjam6_installed%
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
REM Terra doesn't normally have its own gamedir, but let's give it one
if not exist terra (
  call "%~dp0\_mod_install.cmd" terra
  md terra 2> nul
  md terra\maps 2> nul
  move id1\maps\terra?.bsp terra\maps > nul
  move id1\maps\terra.txt terra > nul
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
  echo If you launch "chapters" outside of this installer, make sure to specify
  echo missionpack 1 as the base game. In this case, that base game is necessary
  echo even if you don't have missionpack 1 currently installed.
  echo(
)
pause
goto :menu

:7
REM for Travail also install the soundtrack
set quake_travail_soundtrack_markv_fix_success=
if not exist travail (
  call "%~dp0\_mod_install.cmd" travail
  if exist travail (
    call "%~dp0\_mod_patch_install.cmd" http://www.eclecticmenagerie.com/jl/quake/quake_travail_soundtrack_markv.zip travail music_placeholder_delete_me.pak
  )
)
if "%quake_travail_soundtrack_markv_fix_success%"=="false" (
  rd /q /s travail
  echo Failed to get mod soundtrack; rolled back the mod install. Maybe try again?
  echo If you want to install just the mod without its soundtrack, you can enter
  echo "install travail" in the Mark V console.
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
REM note that the "quoth" folder name is required for Quoth
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip
  if exist quoth2pt2full (
    move quoth2pt2full quoth > nul
    del /q id1\_library\quoth2pt2full.zip
  )
)
if exist quoth (
  if not exist warpspasm (
    call "%~dp0\_mod_install.cmd" warpspasm
    call :warpspasm_fix
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "warpspasm" install.
  echo(
  pause
  goto :menu
)
if exist warpspasm (
  call "%~dp0\_mod_launch.cmd" warpspasm start quoth
  echo If you launch "warpspasm" outside of this installer, make sure to specify
  echo Quoth as the base game.
  echo(
)
pause
goto :menu

:9
REM Remix Map Pack doesn't normally have its own gamedir, but let's give it one
if not exist rmx-pack (
  call "%~dp0\_mod_install.cmd" rmx-pack
  md rmx-pack 2> nul
  md rmx-pack\gfx 2> nul
  md rmx-pack\gfx\env 2> nul
  md rmx-pack\maps 2> nul
  move id1\*rmx*.txt rmx-pack > nul
  move id1\gfx\env\elbrus256*.tga rmx-pack\gfx\env > nul
  move id1\maps\*rmx*.* rmx-pack\maps > nul
  move id1\maps\start.bsp rmx-pack\maps > nul
  REM delete these unneeded files
  del /q id1\fitz-rmx.bat
  del /q id1\gnu.txt
  del /q id1\mx.txt
  REM delete these uncommon dirs if empty
  rd id1\gfx\env 2> nul
  rd id1\gfx 2> nul
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
  call :arcanum_fix
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
REM Deathmatch Classics Vol. 3 doesn't normally have its own gamedir, but let's give it one
if not exist dmc3 (
  call "%~dp0\_mod_install.cmd" dmc3
  md dmc3 2> nul
  md dmc3\maps 2> nul
  md dmc3\maps\src 2> nul
  move id1\maps\dmc3.txt dmc3 > nul
  move id1\maps\dmc3*.bsp dmc3\maps > nul
  move id1\maps\src\dmc3*.map dmc3\maps\src > nul
  REM delete these uncommon dirs if empty
  rd id1\maps\src 2> nul
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
  echo Failed to apply the "Quicker Qonquer" patch; rolled back the mod install. Maybe try again?
  echo If you really want to install just the unpatched mod, you can enter
  echo "install func_mapjam5" in the Mark V console.
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
  call :mapjam6_fix
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
  set %1_installed= - ready to play
) else (
  set %1_installed=
)
goto :eof

REM Mark V does not correctly extract arcanum
REM so we'll do it from this batch file if possible.
:arcanum_fix
if exist arcanum\maps\arcstart.bsp (
  goto :eof
)
del /q id1\maps\arcanum?.bsp 2> nul
del /q id1\maps\arcstart.* 2> nul
call :net45_check
if "%net45_installed%"=="true" (
  echo Fixing some install issues...
  powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('id1\_library\arcanum.zip', 'arcanum'); }"
)
if exist arcanum\maps\arcstart.bsp (
  goto :eof
)
rd /s /q arcanum 2> nul
echo Mark V has issues installing "arcanum"; unable to fix.
echo You can get "arcanum.zip" from the "id1\_library" folder and
echo extract it manually into an "arcanum" mod folder.
echo You will also need to manually download and install the Drake mod into
echo the same folder, from: http://www.quaddicted.com/filebase/drake290111.zip
echo(
goto :eof

:warpspasm_fix
del /q warpspasm\dll 2> nul
goto :eof

REM Mark V does not correctly extract mapjam6
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
rd /s /q mapjam6 2> nul
echo Mark V has issues installing "mapjam6"; unable to fix.
echo You can get "mapjam6.zip" from the "id1\_library folder" and
echo extract it manually into a "mapjam6" mod folder.
echo(
goto :eof

:net45_check
powershell.exe -nologo -noprofile -command "& { trap { exit 1; } Add-Type -A 'System.IO.Compression.FileSystem'; }" > nul 2>&1
if %errorlevel% equ 0 (
  set net45_installed=true
) else (
  echo The installed version of the .Net Framework ^(and/or of PowerShell^) prevents
  echo the automatic fixing of some install issues. See the basic\1_setup.txt file
  echo for more details.
  echo(
  set net45_installed=false
)
goto :eof
