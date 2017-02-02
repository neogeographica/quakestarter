REM save working dir and change to dir that holds this script
pushd "%~dp0"

REM capture commandline args
if "%1"=="" (
  echo Missing the command-line args for patch, gamedir, and skipfiles.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :exit
)
set install_arg=%~1
set temp_gamedir=%~n1
set %temp_gamedir%_success=false
set target_gamedir=%~2
set skipfiles=
set has_skipfiles=false
shift
shift
:skipfiles_loop
if "%1"=="" (
  goto skipfiles_loop_done
)
set skipfiles=%skipfiles% "%temp_gamedir%\%~1"
set has_skipfiles=true
shift
goto skipfiles_loop
:skipfiles_loop_done

echo Installing patch "%temp_gamedir%" for "%target_gamedir%"...

REM sanity checks, and CD up to Mark V dir if necessary
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
  echo You can run "install_pakfiles.bat" to look for pak0.pak on this computer.
  goto :exit
)
if not exist "id1\pak1.pak" (
  echo Couldn't find "id1\pak1.pak".
  echo You can run "install_pakfiles.bat" to look for pak1.pak on this computer.
  goto :exit
)
if not exist "%target_gamedir%" (
  echo The "%target_gamedir%" folder does not exist.
  goto :exit 
)
if exist "%temp_gamedir%" (
  echo The temporary "%temp_gamedir%" folder already exists.
  echo Maybe it should be deleted?
  goto :exit 
)

REM download the patch
start "" /b /wait ".\%markv_exe%" +install "%install_arg%" +quit

REM verify that download worked
if not exist "id1\_library\%temp_gamedir%.zip" (
  echo Attempting download again...
  REM short retry delay (don't use "timeout" since not available on XP)
  ping 127.0.0.1 -n 4 >nul 2>&1 || ping ::1 -n 4 >nul 2>&1
  start "" /b /wait ".\%markv_exe%" +install "%install_arg%" +quit
  if not exist "id1\_library\%temp_gamedir%.zip" (
    echo Download failed. This might be a temporary issue with the server;
    echo if you try again the download may succeed.
    goto :exit
  )
)

REM move the patch files to the desired gamedir
if exist "%temp_gamedir%" (
  if "%has_skipfiles%"=="true" (
    del /q%skipfiles% 2> nul
  )
  echo Adding/patching files:
  for /r "%cd%\%temp_gamedir%" %%d in (.) do (
    setlocal EnableDelayedExpansion
    set patch_subdir=%%d
    set patch_rel_subdir=!patch_subdir:%cd%\%temp_gamedir%=!
    set target_subdir=%target_gamedir%!patch_rel_subdir:\.=!
    echo !target_subdir!
    if not exist "!target_subdir!" (
      md "!target_subdir!"
    )
    for %%f in ("%%d\*") do (
      echo   %%~nxf
      move /y "%%f" "!target_subdir!" > nul
    )
    endlocal
  )
) else (
  echo Failed to extract patch files from: "id1\_library\%temp_gamedir%.zip"
  echo Leaving that zipfile in place for investigation.
  goto :exit
)

REM delete the patch zip and temp dir since it shouldn't have its own gamedir
del /q "id1\_library\%temp_gamedir%.zip"
rd /q /s "%temp_gamedir%"

echo Patched.

set %temp_gamedir%_success=true

REM finally restore original working dir to be nice
:exit
popd
