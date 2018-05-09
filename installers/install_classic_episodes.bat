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
    pause
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
echo "Classic" custom episodes:
echo %prodigy_se_installed%  1: prodigy_se - Prodigy Special Edition ^(1997^)
echo %bbelief_installed%  2: bbelief - Beyond Belief ^(1997^)
echo %mexx9_installed%  3: mexx9 - Penumbra of Domination ^(1997^)
echo %zer_installed%  4: zer - Zerstoerer ^(1997^)
echo %descent_installed%  5: descent - ^(The Final^) Descent ^(2000^)
echo %nehahra_installed%  6: nehahra - Nehahra ^(2000^)
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if not exist prodigy_se (
  call "%~dp0\_mod_install.cmd" prodigy_se
)
if exist prodigy_se (
  call "%~dp0\_mod_launch.cmd" prodigy_se start
)
pause
goto :menu

:2
REM for Beyond Belief also install the patch
set bbelief6_fix_success=
if not exist bbelief (
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
  echo(
  pause
  goto :menu
)
if exist bbelief (
  call "%~dp0\_mod_launch.cmd" bbelief bbstart
)
pause
goto :menu

:3
if not exist mexx9 (
  call "%~dp0\_mod_install.cmd" mexx9
)
if exist mexx9 (
  call "%~dp0\_mod_launch.cmd" mexx9 mexx9
)
pause
goto :menu

:4
REM for Zerstoerer also install the patches
set zer11_success=
set zerend_fix_success=
if not exist zer (
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
  echo(
  pause
  goto :menu
)
if exist zer (
  call "%~dp0\_mod_launch.cmd" zer start
)
pause
goto :menu

:5
if not exist descent (
  call "%~dp0\_mod_install.cmd" descent
)
if exist descent (
  call "%~dp0\_mod_launch.cmd" descent start
)
pause
goto :menu

:6
if not exist nehahra (
  call "%~dp0\_mod_install.cmd" nehahra
)
if exist nehahra (
  call "%~dp0\_mod_launch.cmd" nehahra nehstart nehahra
  if exist nehahra (
    echo If you launch "nehahra" outside of this installer, make sure to specify
    echo Nehahra as the base game.
    echo(
  )
)
pause
goto :menu

:menu_exit
popd
goto :eof


REM functions used above

:installed_check
if exist "%1" (
  set %1_installed=*
) else (
  set %1_installed= 
)
goto :eof
