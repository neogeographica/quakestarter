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
cls
call :installed_check dopa
call :installed_check ad_v1_70final
echo(
echo Custom episodes released in 2016:
echo 1: dopa - Dimension of the Past%dopa_installed%
echo 2: ad_v1_70final - Arcane Dimensions 1.7%ad_v1_70final_installed%
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
pause
goto :menu

:2
REM for Arcane Dimensions 1.7 also install the patch
set ad_v1_70patch1_success=
if exist ad_v1_70final (
  echo The "ad_v1_70final" gamedir already exists.
) else (
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
)
echo Note that the included map ad_sepulcher is not playable with the Mark V engine, at the time of writing this.
echo The latest version of the Quakespasm engine is recommended for that particular map.
pause
goto :menu

:menu_exit
popd
goto :eof


REM function used above
:installed_check
if exist "%1" (
  set %1_installed= - already installed
) else (
  set %1_installed=
)
