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
echo A selection of other maps to install (part 2):
echo 17: honey - Honey (2012)%honey_installed%
echo 18: e1m5quotha - Gloomier Keep (2012)%e1m5quotha_installed%
echo 19: apsp3 - Subterranean Library (2012)%apsp3_installed%
echo 20: something_wicked - Something Wicked This Way Comes (2012)%something_wicked_installed%
echo 21: fmb_bdg2 - For My Babies - Bin Dunne Gorne 2 (2013)%fmb_bdg2_installed%
echo 22: mstalk1c - Midnight Stalker (2013)%mstalk1c_installed%
echo 23: ivory1b - The Ivory Tower (2013)%ivory1b_installed%
echo 24: func_mapjam1 - Func Map Jam 1 - Honey Theme (2014)%func_mapjam1_installed%
echo 25: func_mapjam2 - Func Map Jam 2 - IKblue/IKwhite Theme (2014)%func_mapjam2_installed%
echo 26: func_mapjam3 - Func Map Jam 3 - Zerstoerer theme (2014)%func_mapjam3_installed%
echo 27: retrojam6 - Retro Jam 6 - Egyptian theme (2017)%retrojam6_installed%
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:17
if exist honey (
  echo The "honey" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" honey
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
  if exist e1m5quotha (
    echo The "e1m5quotha" gamedir already exists.
  ) else (
    call "%~dp0\_mod_install.cmd" e1m5quotha
    md e1m5quotha 2> nul
    md e1m5quotha\maps 2> nul
    move id1\maps\e1m5quoth*.bsp e1m5quotha\maps > nul
    move id1\maps\e1m5quotha.txt e1m5quotha > nul
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "e1m5quotha" install.
  pause
  goto :menu
)
echo Make sure to specify Quoth as the base game when playing "e1m5quotha".
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
  if exist apsp3 (
    echo The "apsp3" gamedir already exists.
  ) else (
    call "%~dp0\_mod_install.cmd" apsp3
    call :apsp3_fix
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "apsp3" install.
  pause
  goto :menu
)
echo Make sure to specify Quoth as the base game when playing "apsp3".
pause
goto :menu

:20
if exist something_wicked (
  echo The "something_wicked" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" something_wicked
)
pause
goto :menu

:21
if exist fmb_bdg2 (
  echo The "fmb_bdg2" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" fmb_bdg2
  del /q fmb_bdg2\bat
)
pause
goto :menu

:22
if exist mstalk1c (
  echo The "mstalk1c" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" mstalk1c
)
pause
goto :menu

:23
if exist ivory1b (
  echo The "ivory1b" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" ivory1b
)
pause
goto :menu

:24
if exist func_mapjam1 (
  echo The "func_mapjam1" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" func_mapjam1
  call :func_mapjam1_fix
)
pause
goto :menu

:25
if exist func_mapjam2 (
  echo The "func_mapjam2" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" func_mapjam2
  call :func_mapjam2_fix
)
pause
goto :menu

:26
REM for Func Map Jam 3 also install the patch
REM can't use normal patch installer tho since it only includes bsp/lit files
set jam3_mfx_fix_success=
if exist func_mapjam3 (
  echo The "func_mapjam3" gamedir already exists.
) else (
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
      set jam3_mfx_fix_success=true
    ) else (
      echo Failed to extract patch files from: "id1\_library\jam3_mfx_fix.zip"
      echo Leaving that zipfile in place for investigation.
    )
  )
)
if "%jam3_mfx_fix_success%"=="false" (
  rd /q /s func_mapjam3
  echo Failed to apply patch; rolled back the mod install. Maybe try again?
  echo If you really want to install just the unpatched mod, you can enter
  echo "install func_mapjam3" in the Mark V console.
  pause
  goto :menu
)
echo Note that you do NOT normally want to choose the "start" map when playing
echo this mod, as that will start the original Zerstoerer campaign. Instead
echo choose a specific jam3_* map to play.
pause
goto :menu

:27
if exist retrojam6 (
  echo The "retrojam6" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" retrojam6
)
pause
goto :menu

:menu_exit
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
md apsp3 2> nul
echo Mark V has issues installing "apsp3".
echo You can get "apsp3.zip" from the "id1\_library folder" and
echo extract it manually into the "apsp3" folder.
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
md func_mapjam1 2> nul
echo Mark V has issues installing "func_mapjam1".
echo You can get "func_mapjam1.zip" from the "id1\_library folder" and
echo extract it manually into the "func_mapjam1" folder.
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
md func_mapjam2 2> nul
echo Mark V has issues installing "func_mapjam2".
echo You can get "func_mapjam2.zip" from the "id1\_library folder" and
echo extract it manually into the "func_mapjam2" folder.
goto :eof

:net45_check
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release > nul 2>&1
if %errorlevel% equ 0 (
  set net45_installed=true
) else (
  set net45_installed=false
)
goto :eof
