@echo off

REM Installer for mapsets that fit the following criteria:
REM * Nehahra and previous releases
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
call :installed_check prodigy_se
call :installed_check bbelief
call :installed_check mexx9
call :installed_check zer
call :installed_check descent
call :installed_check nehahra
echo(
echo "Classic" custom episodes to install:
echo 1: prodigy_se - Prodigy Special Edition (1997)%prodigy_se_installed%
echo 2: bbelief - Beyond Belief (1997)%bbelief_installed%
echo 3: mexx9 - Penumbra of Domination (1997)%mexx9_installed%
echo 4: zer - Zerstorer (1997)%zer_installed%
echo 5: descent - (The Final) Descent (2000)%descent_installed%
echo 6: nehahra - Nehahra (2000)%nehahra_installed%
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if exist prodigy_se (
  echo The "prodigy_se" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" prodigy_se
)
pause
goto :menu

:2
REM for Beyond Belief also install the patch
set bbelief6_fix_success=
if exist bbelief (
  echo The "bbelief" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" bbelief
  if exist bbelief (
    call "%~dp0\_mod_patch_install.cmd" bbelief6_fix bbelief
  )
)
if "%bbelief6_fix_success%"=="false" (
  rd /q /s bbelief
  echo Failed to apply patch; rolled back the mod install. Maybe try again?
  echo If you really want to install just the unpatched mod, you can enter
  echo "install bbelief" in the Mark V console.
)
pause
goto :menu

:3
if exist mexx9 (
  echo The "mexx9" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" mexx9
)
pause
goto :menu

:4
REM for Zerstorer also install the patches
set zer11_success=
set zerend_fix_success=
if exist zer (
  echo The "zer" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" zer
  if exist zer (
    call "%~dp0\_mod_patch_install.cmd" zer11 zer
    call "%~dp0\_mod_patch_install.cmd" zerend_fix zer
  )
)
set good_zer_patches=true
if "%zer11_success%"=="false" (
  set good_zer_patches=false
)
if "%zerend_fix_success%"=="false" (
  set good_zer_patches=false
)
if "%good_zer_patches%"=="false" (
  rd /q /s zer
  echo Failed to apply patch; rolled back the mod install. Maybe try again?
  echo If you really want to install just the unpatched mod, you can enter
  echo "install zer" in the Mark V console.
)
pause
goto :menu

:5
if exist descent (
  echo The "descent" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" descent
)
pause
goto :menu

:6
if exist nehahra (
  echo The "nehahra" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" nehahra
  call :nehahra_fix
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

:nehahra_fix
move nehahra\pirit.txt nehahra\readme_spirit.txt > nul 2>&1
goto :eof
