@echo off

REM Let's just try launching Quake, using the same sort of approach that
REM the other scripts would.

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
if "%quake_exe%"=="" (
  echo The required variable quake_exe is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files. quake_exe is set in your installer config.
  pause
  goto :eof
) else (
  if not exist "%basedir%\%quake_exe%" (
    echo The configured Quake engine: %quake_exe%
    echo does not exist in the Quake folder: %basedir%
    echo.
    echo If you need to configure a different executable to use for Quake, see the
    echo "advanced_quakestarter_cfg.txt" doc in the "quakestarter_docs\other_stuff"
    echo folder.
    echo.
    pause
    goto :eof
  )
)

REM OK do the thing
start "" /b /wait "%basedir%\%quake_exe%"

pause
