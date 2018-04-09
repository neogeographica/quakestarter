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
echo 1: dopa - Dimension of the Past ^(2016^)%dopa_installed%
echo 2: gotshun-never-released_levels - The "lost" levels ^(2016^)%gotshun-never-released_levels_installed%
echo 3: func_mapjam9_2 - Func Map Jam 9 - Contract Revoked / Knave theme ^(2017^)%func_mapjam9_2_installed%
echo 4: qump - Quake Upstart Mapping Project ^(2017^)%qump_installed%
echo 5: ad_v1_70final - Arcane Dimensions 1.7 ^(2017^)%ad_v1_70final_installed%
echo 6: dm4jam - DM4 Jam ^(2018^)%dm4jam_installed%
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
REM The "lost" levels doesn't normally have its own gamedir, but let's give it one
if not exist gotshun-never-released_levels (
  if not exist "hipnotic\pak0.pak" (
    echo This content requires missionpack 1 to currently be installed.
    echo(
    pause
    goto :menu
  ) else (
    call "%~dp0\_mod_install.cmd" gotshun-never-released_levels
    md gotshun-never-released_levels 2> nul
    md gotshun-never-released_levels\maps 2> nul
    move id1\maps\q1map1.bsp gotshun-never-released_levels\maps > nul
    move id1\maps\e1u?.bsp gotshun-never-released_levels\maps > nul
    move id1\maps\e1sl1.bsp gotshun-never-released_levels\maps > nul
    move id1\maps\e2u?.bsp gotshun-never-released_levels\maps > nul
    move id1\maps\e2sl1.bsp gotshun-never-released_levels\maps > nul
    move id1\maps\finale.bsp gotshun-never-released_levels\maps > nul
    move id1\maps\readme.txt gotshun-never-released_levels > nul
  )
)
if exist gotshun-never-released_levels (
  call "%~dp0\_mod_launch.cmd" gotshun-never-released_levels q1map1 hipnotic
  echo If you launch "gotshun-never-released_levels" outside of this installer, make sure to specify
  echo missionpack 1 as the base game.
  echo(
)
pause
goto :menu

:3
REM for Func Map Jam 9 also install Quoth if necessary
REM note that the "quoth" folder name is required for Quoth
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip
  if exist quoth2pt2full (
    move quoth2pt2full quoth > nul
    del /q id1\_library\quoth2pt2full.zip
  )
)
if exist quoth (
  if not exist func_mapjam9_2 (
    call "%~dp0\_mod_install.cmd" func_mapjam9_2
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "func_mapjam9_2" install.
  echo(
  pause
  goto :menu
)
if exist func_mapjam9_2 (
  call "%~dp0\_mod_launch.cmd" func_mapjam9_2 start quoth
  echo If you launch "func_mapjam9_2" outside of this installer, make sure to specify
  echo Quoth as the base game.
  echo(
)
goto :menu

:4
REM Quake Upstart Mapping Project doesn't normally have its own gamedir, but let's give it one
if not exist qump (
  call "%~dp0\_mod_install.cmd" qump
  md qump 2> nul
  md qump\gfx 2> nul
  md qump\gfx\env 2> nul
  md qump\maps 2> nul
  md qump\maps\source 2> nul
  md qump\music 2> nul
  move id1\gfx\env\moonhigh_*.tga qump\gfx\env > nul
  move id1\gfx\env\stormydays_*.tga qump\gfx\env > nul
  move id1\gfx\env\voidsmoke_*.tga qump\gfx\env > nul
  move id1\maps\qump_*.* qump\maps > nul
  move id1\maps\start.bsp qump\maps > nul
  move id1\maps\start.lit qump\maps > nul
  move id1\maps\source\qump_*.* qump\maps\source > nul
  move id1\maps\source\start.map qump\maps\source > nul
  move id1\music\track12.ogg qump\music > nul
  move "id1\qump read me.txt" qump > nul
  REM delete these uncommon dirs if empty
  rd id1\gfx\env 2> nul
  rd id1\gfx 2> nul
  rd id1\maps\source 2> nul
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
  echo Note that the included map ad_sepulcher is not playable with the
  echo Mark V engine, at the time of writing this.
  echo The latest version of the Quakespasm engine is recommended for that map.
  echo(
  call "%~dp0\_mod_launch.cmd" ad_v1_70final start
)
pause
goto :menu

:6
if not exist dm4jam (
  call "%~dp0\_mod_install.cmd" dm4jam
  call :dm4jam_fix
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
  set %1_installed= - ready to play
) else (
  set %1_installed=
)
goto :eof

REM Mark V does not correctly extract dm4jam
REM so we'll do it from this batch file if possible.
:dm4jam_fix
if exist dm4jam\demo1.dem (
  goto :eof
)
del /q id1\maps\dm4jam_*.* 2> nul
del /q id1\maps\start.* 2> nul
call :net45_check
if "%net45_installed%"=="true" (
  echo Fixing some install issues...
  powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('id1\_library\dm4jam.zip', 'dm4jam'); }"
)
if exist dm4jam\demo1.dem (
  goto :eof
)
md dm4jam 2> nul
echo Mark V has issues installing "dm4jam".
echo You can get "dm4jam.zip" from the "id1\_library" folder and
echo extract it manually into the "dm4jam" folder.
goto :eof

:net45_check
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release > nul 2>&1
if %errorlevel% equ 0 (
  set net45_installed=true
) else (
  set net45_installed=false
)
goto :eof
