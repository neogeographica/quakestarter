@echo off

REM Installer for mapsets that fit the following criteria:
REM * released after Nehahra and before Arcane Dimensions
REM * at least four non-startmaps
REM * Quaddicted editor rating "Excellent"
REM * Quaddicted user rating 4.0 or better

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
call :installed_check oum
call :installed_check contract
call :installed_check terra
call :installed_check chapters
call :installed_check travail
call :installed_check warpspasm
call :installed_check nsoe2
call :installed_check arcanum
call :installed_check rrp
echo(
echo "Modern" custom episodes to install:
echo 1: oum - Operation: Urth Majik (2001)%oum_installed%
echo 2: contract - Contract Revoked (2002)%contract_installed%
echo 3: terra - Terra (2005)%terra_installed%
echo 4: chapters - Contract Revoked: The Lost Chapters (2005)%chapters_installed%
echo 5: travail - Travail (2007)%travail_installed%
echo 6: warpspasm - Warp Spasm (2007)%warpspasm_installed%
echo 7: nsoe2 - Soul of Evil: Indian Summer (2008)%nsoe2_installed%
echo 8: arcanum - Arcanum (2011)%arcanum_installed%
echo 9: rrp - Rubicon Rumble Pack (2014)%rrp_installed%
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if exist oum (
  echo The "oum" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" oum
)
goto :menu

:2
if exist contract (
  echo The "contract" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" contract
)
goto :menu

:3
REM Terra doesn't normally have its own gamedir, but let's give it one
if exist terra (
  echo The "terra" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" terra
  md terra 2> nul
  md terra\maps 2> nul
  move id1\maps\terra?.bsp terra\maps > nul
  move id1\maps\terra.txt terra > nul
)
goto :menu

:4
if exist chapters (
  echo The "chapters" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" chapters
)
goto :menu

:5
REM for Travail also install the soundtrack
set quake_travail_soundtrack_markv_fix_success=
if exist travail (
  echo The "travail" gamedir already exists.
) else (
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
)
goto :menu

:6
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
  if exist warpspasm (
    echo The "warpspasm" gamedir already exists.
  ) else (
    call "%~dp0\_mod_install.cmd" warpspasm
    call :warpspasm_fix
  )
) else (
  echo Failed to install required base mod "quoth". Skipping "warpspasm" install.
)
goto :menu

:7
if exist nsoe2 (
  echo The "nsoe2" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" nsoe2
)
goto :menu

:8
if exist arcanum (
  echo The "arcanum" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" arcanum
  call :arcanum_fix
)
goto :menu

:9
if exist rrp (
  echo The "rrp" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" rrp
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

REM Mark V as of build 1020 does not correctly extract arcanum
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
md arcanum 2> nul
echo Mark V has issues installing "arcanum".
echo You can get "arcanum.zip" from the "id1\_library" folder and\
echo extract it manually into the "id1\arcanum" folder.
goto :eof

:warpspasm_fix
del /q warpspasm\dll 2> nul
goto :eof

:net45_check
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release > nul
if errorlevel 1 (
  set net45_installed=false
) else (
  set net45_installed=true
)
goto :eof
