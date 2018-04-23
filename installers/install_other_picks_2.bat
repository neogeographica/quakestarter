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
echo(
echo A selection of other maps to install ^(part 2^):
echo 17: honey - Honey ^(2012^)%honey_installed%
echo 18: e1m5quotha - Gloomier Keep ^(2012^)%e1m5quotha_installed%
echo 19: apsp3 - Subterranean Library ^(2012^)%apsp3_installed%
echo 20: something_wicked - Something Wicked This Way Comes ^(2012^)%something_wicked_installed%
echo 21: fmb_bdg2 - For My Babies - Bin Dunne Gorne 2 ^(2013^)%fmb_bdg2_installed%
echo 22: mstalk1c - Midnight Stalker ^(2013^)%mstalk1c_installed%
echo 23: ivory1b - The Ivory Tower ^(2013^)%ivory1b_installed%
echo 24: func_mapjam1 - Func Map Jam 1 - Honey Theme ^(2014^)%func_mapjam1_installed%
echo 25: func_mapjam2 - Func Map Jam 2 - IKblue/IKwhite Theme ^(2014^)%func_mapjam2_installed%
echo 26: func_mapjam3 - Func Map Jam 3 - Zerstoerer theme ^(2014^)%func_mapjam3_installed%
echo 27: retrojam6 - Retro Jam 6 - Egyptian theme ^(2017^)%retrojam6_installed%
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
REM note that the "quoth" folder name is required for Quoth
if not exist quoth (
  call "%~dp0\_mod_install.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip
  if exist quoth2pt2full (
    move quoth2pt2full quoth > nul
    del /q id1\_library\quoth2pt2full.zip
  )
)
REM Gloomier Keep doesn't normally have its own gamedir, but let's give it one
if exist quoth (
  if not exist e1m5quotha (
    call "%~dp0\_mod_install.cmd" e1m5quotha
    md e1m5quotha 2> nul
    md e1m5quotha\maps 2> nul
    move id1\maps\e1m5quoth*.bsp e1m5quotha\maps > nul
    move id1\maps\e1m5quotha.txt e1m5quotha > nul
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "e1m5quotha" install.
  echo(
  pause
  goto :menu
)
if exist e1m5quotha (
  call "%~dp0\_mod_launch.cmd" e1m5quotha e1m5quotha quoth
  echo If you launch "e1m5quotha" outside of this installer, make sure to specify
  echo Quoth as the base game.
  echo(
)
pause
goto :menu

:19
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
  if not exist apsp3 (
    call "%~dp0\_mod_install.cmd" apsp3
    call :apsp3_fix
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "apsp3" install.
  echo(
  pause
  goto :menu
)
if exist apsp3 (
  call "%~dp0\_mod_launch.cmd" apsp3 apsp3 quoth
  echo If you launch "apsp3" outside of this installer, make sure to specify
  echo Quoth as the base game.
  echo(
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
  call :func_mapjam1_fix
)
if exist func_mapjam1 (
  call "%~dp0\_mod_launch.cmd" func_mapjam1
)
pause
goto :menu

:25
if not exist func_mapjam2 (
  call "%~dp0\_mod_install.cmd" func_mapjam2
  call :func_mapjam2_fix
)
if exist func_mapjam2 (
  call "%~dp0\_mod_launch.cmd" func_mapjam2
)
pause
goto :menu

:26
REM for Func Map Jam 3 also install the patch
REM can't use normal patch installer tho since it only includes bsp/lit files
set jam3_mfx_fix_success=
if not exist func_mapjam3 (
  call "%~dp0\_mod_install.cmd" func_mapjam3
  if exist func_mapjam3 (
    set jam3_mfx_fix_success=false
    echo Installing patch "jam3_mfx_fix" for "func_mapjam3"...
    call "%~dp0\_mod_install.cmd" jam3_mfx_fix
    if exist id1\maps\jam3_mfx.bsp (
      echo Adding/patching files:
      echo func_mapjam3\maps
      echo   jam3_mfx.bsp
      move id1\maps\jam3_mfx.bsp func_mapjam3\maps > nul
      echo   jam3_mfx.lit
      move id1\maps\jam3_mfx.lit func_mapjam3\maps > nul
      del /q id1\_library\jam3_mfx_fix.zip
      echo Patched.
      echo(
      set jam3_mfx_fix_success=true
    ) else (
      echo Failed to extract patch files from: "id1\_library\jam3_mfx_fix.zip"
      echo Leaving that zipfile in place for investigation.
      echo(
    )
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

REM Mark V does not correctly extract apsp3
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
rd /s /q apsp3 2> nul
echo Mark V has issues installing "apsp3"; unable to fix.
echo You can get "apsp3.zip" from the "id1\_library folder" and
echo extract it manually into an "apsp3" mod folder.
echo(
goto :eof

REM Mark V does not correctly extract func_mapjam1
REM so we'll do it from this batch file if possible.
:func_mapjam1_fix
if exist func_mapjam1\maps\jam1_arrrcee.bsp (
  goto :eof
)
del /q id1\maps\jam1_*.* 2> nul
call :net45_check
if "%net45_installed%"=="true" (
  echo Fixing some install issues...
  powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('id1\_library\func_mapjam1.zip', 'func_mapjam1'); }"
)
if exist func_mapjam1\maps\jam1_arrrcee.bsp (
  goto :eof
)
rd /s /q func_mapjam1 2> nul
echo Mark V has issues installing "func_mapjam1"; unable to fix.
echo You can get "func_mapjam1.zip" from the "id1\_library folder" and
echo extract it manually into a "func_mapjam1" mod folder.
echo(
goto :eof

REM Mark V does not correctly extract func_mapjam2
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
rd /s /q func_mapjam2 2> nul
echo Mark V has issues installing "func_mapjam2"; unable to fix.
echo You can get "func_mapjam2.zip" from the "id1\_library folder" and
echo extract it manually into a "func_mapjam2" mod folder.
echo(
goto :eof

:net45_check
powershell.exe -nologo -noprofile -command "& { trap { exit 1; } Add-Type -A 'System.IO.Compression.FileSystem'; }" > nul 2>&1
if %errorlevel% equ 0 (
  set net45_installed=true
) else (
  echo The installed version of the .Net Framework ^(and/or of PowerShell^) prevents
  echo the automatic fixing of some install issues. See "readmes\basic\1_setup.txt"
  echo for more details.
  echo(
  set net45_installed=false
)
goto :eof
