@echo off

REM Utility for changing quake_exe value in _quakestarter_cfg.cmd

REM On the commandline, the cfgpath arg is required.

REM The caller is also required to set the quake_exe variable.

setlocal

set cfgpath=%~1
if "%cfgpath%"=="" (
  echo Missing arguments.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :eof
)
if "%quake_exe%"=="" (
  echo The required variable quake_exe is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :eof
)

REM remember dir where this script lives
set scriptspath=%~dp0

REM find the basedir by looking for id1 folder here or above one level
set basedir=
pushd "%~dp0"
dir id1 /ad >nul 2>&1
if not %errorlevel% equ 0 (
  cd ..
  dir id1 /ad >nul 2>&1
)
if %errorlevel% equ 0 (
  set basedir=%cd%
)
popd
if "%basedir%"=="" (
  echo Couldn't find the id1 folder.
  pause
  goto :eof
)

:menu

cls
echo.
echo Current setting for Quake engine to launch: %quake_exe%
if not exist "%basedir%\%quake_exe%" (
  echo WARNING: This file does not exist in your Quake folder. You should probably
  echo choose something else!
)
echo.

REM Present a menu of executables.
REM XXX todo:
REM * by default only show known "supported" Quake engine exes
REM * allow switching to show all (non-filtered) exes
REM
REM Also need documentation changes of course, both for this stuff and for
REM the changes to the main menu options.

setlocal enabledelayedexpansion
set count=0
pushd "%basedir%"
for /f "delims=" %%a in ('dir /a:-d /b *.exe') do (
  if not "%%a" == "%quake_exe%" (
    if not "%%a" == "SQLauncher2.exe" (
      set /a count+=1
      set "executables[!count!]=%%a"
    )
  )
)
popd
if %count% == 0 (
  echo No other available programs in the Quake folder.
  echo.
  pause
  goto :eof
)
echo Other available programs in the Quake folder:
echo.
for /l %%a in (1,1,!count!) do (
  set padded=   %%a
  echo !padded:~-3!: !executables[%%a]!
)
echo.
set menu_choice=
set /p menu_choice=enter your choice or just press Enter to keep current engine: 
if "%menu_choice%" == "" (
  set new_quake_exe=%quake_exe%
  goto :onward
)
set new_quake_exe=
echo %menu_choice%| findstr /r "^[1-9][0-9]*$" > nul
if not %errorlevel% equ 0 (
  goto :onward
)
if %menu_choice% lss 1 (
  goto :onward
)
if %menu_choice% gtr %count% (
  goto :onward
)
set new_quake_exe=!executables[%menu_choice%]!
:onward
endlocal & set new_quake_exe=%new_quake_exe%

if "%new_quake_exe%" == "" (
  goto :menu
)

if "%new_quake_exe%"=="%quake_exe%" (
  goto :eof
)

REM _quakestarter_cfg.cmd really should exist already, but let's handle if
REM it does not.
if not exist "%cfgpath%_quakestarter_cfg.cmd" (
  echo set quake_exe=%new_quake_exe%> "%cfgpath%_quakestarter_cfg.cmd"
  goto :eof
)

REM Let's see if _quakestarter_cfg.cmd currently has a setting for quake_exe.
pushd "%cfgpath%"
set foundline=
for /f "delims=" %%a in ('powershell.exe -nologo -noprofile -command "&{trap{exit 1;} Select-String -path _quakestarter_cfg.cmd '^\s*set\s+quake_exe=';}"') do (
  set foundline=%%a
)
REM If not, just add it to the end.
if "%foundline%"=="" (
  echo.>> "_quakestarter_cfg.cmd"
  echo set quake_exe=%new_quake_exe%>> "_quakestarter_cfg.cmd"
  popd
  goto :eof
)
REM If so, we need to replace it.
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} (Get-Content _quakestarter_cfg.cmd) -replace '^\s*set\s+quake_exe=.*', 'set quake_exe=%new_quake_exe%' | Out-File -encoding ASCII _quakestarter_cfg.cmd;}"
popd
