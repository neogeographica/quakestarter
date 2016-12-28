REM save working dir and change to dir that holds this script
pushd "%~dp0"

REM capture commandline arg
if "%1"=="" (
  echo Missing the command-line arg for mod gamedir or URL to install.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :exit
)
set install_arg=%1
set gamedir=%~n1
set %gamedir%_success=false

echo Installing mod "%gamedir%"...

REM CD up to Mark V dir if necessary
if "%markv_exe%"=="" (
  set markv_exe=mark_v.exe
)
if not exist "%markv_exe%" (
  cd ..
  if not exist "%markv_exe%" (
    echo Couldn't find "%markv_exe%" in this folder or parent folder.
    goto :exit
  )
)
if not exist "id1\pak0.pak" (
  echo Couldn't find "id1\pak0.pak".
  goto :exit
)
if not exist "id1\pak1.pak" (
  echo Couldn't find "id1\pak1.pak".
  goto :exit
)

REM download and install the mod
start "" /b /wait ".\%markv_exe%" +install "%install_arg%" +quit

REM verify that download worked
if not exist "id1\_library\%gamedir%.zip" (
  echo Attempting download again...
  REM short retry delay (don't use "timeout" since not available on XP)
  ping 127.0.0.1 -n 4 >nul 2>&1 || ping ::1 -n 4 >nul 2>&1
  start "" /b /wait ".\%markv_exe%" +install "%install_arg%" +quit
  if not exist "id1\_library\%gamedir%.zip" (
    echo Download failed. This might be a temporary issue with the server;
    echo if you try again the download may succeed.
    goto :exit
  )
)

REM nuke the mod's autoexec.cfg if necessary
if exist "%gamedir%\autoexec.cfg" (
  echo Archiving mod's "autoexec.cfg" as "autoexec.cfg.orig".
  move "%gamedir%\autoexec.cfg" "%gamedir%\autoexec.cfg.orig" > nul
)

REM add custom files if any
REM (this only handles single files, not nested folders)
set basedir=%cd%
cd "%~p0"
if exist "mod_extras\%gamedir%" (
  if not exist "%basedir%\%gamedir%" (
    md "%basedir%\%gamedir%"
  )
  echo Adding some files to the mod folder:
  for %%f in ("mod_extras\%gamedir%\*") do (
    echo   %%~nxf
    copy /y "%%f" "%basedir%\%gamedir%" > nul
  )
)

echo Installed.

set %gamedir%_success=true

REM finally restore original working dir to be nice
:exit
popd
