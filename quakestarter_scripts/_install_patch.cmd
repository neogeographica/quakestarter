REM Helper "subroutine" script to install a patch for a mod.
REM Used by _handle_mod_choice.cmd and (special case) install_music.cmd.

set patch_success=false

REM On the commandline, the url and target_gamedir args are required.

REM The caller is also required to set the basedir and patch_download_subdir
REM variables.

REM Optional args will be specified through these variables:
REM   required
REM   skipfiles
REM   no_cleanup

setlocal

REM remember dir where this script lives
set scriptsdir=%~dp0

REM capture/calculate our parameters
if "%1"=="" (
  echo Missing arguments.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :eof
)
if "%basedir%"=="" (
  echo The required variable basedir is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :eof
)
if "%patch_download_subdir%"=="" (
  echo The required variable patch_download_subdir is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files. patch_download_subdir is set in your installer config.
  goto :eof
)
set url=%~1
set temp_gamedir=%~n1
set target_gamedir=%~2
set success=false

REM change some mod install vars for the scope of this setlocal
set less_chatty_install=true
set download_subdir=%patch_download_subdir%

REM sanity checks
if not exist "%basedir%\%target_gamedir%" (
  echo The "%target_gamedir%" folder does not exist.
  echo.
  goto :eof
)
if exist "%basedir%\%temp_gamedir%" (
  echo The temporary "%temp_gamedir%" folder already exists.
  echo Maybe it should be deleted?
  echo.
  goto :eof
)

REM first, install as if it were a standalone mod
if "%required%"=="true" (
  echo Installing required component "%temp_gamedir%" for "%target_gamedir%"...
) else (
  echo Installing patch "%temp_gamedir%" for "%target_gamedir%"...
)
call "%scriptsdir%\_install_mod.cmd" "%url%" "%temp_gamedir%"
if not exist "%basedir%\%temp_gamedir%" goto :exit

REM move the patch files to the desired gamedir
if not "%skipfiles%"=="" (
  pushd "%basedir%\%temp_gamedir%"
  del /q %skipfiles% >nul
  popd
)
for /r "%basedir%\%temp_gamedir%" %%d in (.) do (
  setlocal EnableDelayedExpansion
  set patch_subdir=%%d
  set patch_rel_subdir=!patch_subdir:%basedir%\%temp_gamedir%=!
  set target_subdir=%basedir%\%target_gamedir%!patch_rel_subdir:\.=!
  if not exist "!target_subdir!" (
    md "!target_subdir!"
  )
  for %%f in ("%%d\*") do (
    move /y "%%f" "!target_subdir!" >nul
  )
  endlocal
)

REM delete the patch's temp dir and roll on into cleanup/exit
rd /q /s "%basedir%\%temp_gamedir%" >nul
if "%required%"=="true" (
  echo Component installed.
) else (
  echo Patch installed.
)

set success=true

:exit

echo.

if "%success%"=="false" (
  if "%no_cleanup%"=="true" (
    if "%required%"=="true" (
      echo Failed to install required component.
    ) else (
      echo Failed to apply patch.
    )
  ) else (
    if "%required%"=="true" (
      rd /q /s "%basedir%\%target_gamedir%" >nul
      echo Failed to install required component; rolled back the mod install.
    ) else (
      if "%rollback_on_failed_patch%"=="true" (
        rd /q /s "%basedir%\%target_gamedir%" >nul
        echo Failed to apply patch; rolled back the mod install. If you really want to
        echo install just the unpatched mod, you can set the rollback_on_failed_patch
        echo option to false in your installer config.
      ) else (
        echo Failed to download/extract the patch. Since the rollback_on_failed_patch option
        echo is set to false in your installer config, the unpatched mod is still in place.
      )
    )
  )
  echo.
)

endlocal & set patch_success=%success%
