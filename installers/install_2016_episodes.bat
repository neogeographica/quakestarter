@echo off

REM Installer for DOPA and AD episodes.

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
call :installed_check dopa
call :installed_check ad_v1_50final
echo(
echo Custom episodes released in 2016:
echo 1: dopa - Dimension of the Past%dopa_installed%
echo 2: ad_v1_50final - Arcane Dimensions 1.5%ad_v1_50final_installed%
echo(
set menu_choice=menu_exit
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
if exist dopa (
  echo The "dopa" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" dopa
)
goto :menu

:2
REM for Arcane Dimensions 1.5 also install the patch
set ad_v1_50patch1_success=
if exist ad_v1_50final (
  echo The "ad_v1_50final" gamedir already exists.
) else (
  call "%~dp0\_mod_install.cmd" ad_v1_50final
  if exist ad_v1_50final (
    call "%~dp0\_mod_patch_install.cmd" http://www.simonoc.com/files/ad/ad_v1_50patch1.zip ad_v1_50final
  )
)
if "%ad_v1_50patch1_success%"=="false" (
  rd /q /s ad_v1_50final
  echo Failed to apply patch; rolled back the mod install. Maybe try again?
  echo If you really want to install just the unpatched mod, you can enter
  echo "install ad_v1_50final" in the Mark V console.
)
goto :menu

:menu_exit
pause
popd
goto :eof


REM function used above
:installed_check
if exist "%1" (
  set %1_installed= - already installed
) else (
  set %1_installed=
)
