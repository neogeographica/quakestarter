REM Helper "subroutine" script to install a patch for a mod.
REM Used by _handle_mod_choice.cmd and (special case) install_music.bat.

set patch_success=false

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
set url=%~1
set temp_gamedir=%~n1
set target_gamedir=%~2
set skipfiles=%~3
set patch_acquired=false
set success=false

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
if "%patch_is_required%"=="true" (
  echo Installing required component "%temp_gamedir%" for "%target_gamedir%"...
) else (
  echo Installing patch "%temp_gamedir%" for "%target_gamedir%"...
)
set less_chatty_install=true
call "%scriptsdir%\_mod_install.cmd" "%url%" "%temp_gamedir%"
set less_chatty_install=false
if not exist "%basedir%\%temp_gamedir%" goto :exit
set patch_acquired=true

REM if we might need to leave the gamedir pristine after a failed patch, make
REM a copy of it before we start patching
set bailout=false
if "%rollback_on_failed_patch%"=="false" (
  xcopy "%basedir%\%target_gamedir%" "%basedir%\%target_gamedir%.bak" /s /e /i /r /k /q
  if not %errorlevel% equ 0 (
    rd /q /s "%basedir%\%target_gamedir%.bak" >nul 2>&1
    set bailout=true
  )
)
if "%bailout%"=="true" goto :exit

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

REM delete the patch zip and temp dir since it shouldn't have its own gamedir
del /q "%basedir%\%download_subdir%\%temp_gamedir%.zip" >nul 2>&1
rd /q /s "%basedir%\%temp_gamedir%" >nul

if "%patch_is_required%"=="true" (
  echo Component installed.
) else (
  echo Patch installed.
)

set success=true

:exit
echo.
if "%success%"=="false" (
  if "%no_patch_cleanup%"=="true" (
    if "%patch_is_required%"=="true" (
      echo Failed to install required component.
    ) else (
      echo Failed to apply patch.
    )
  ) else (
    if "%patch_is_required%"=="true" (
      rd /q /s "%basedir%\%target_gamedir%" >nul
      echo Failed to install required component; rolled back the mod install.
    ) else (
      if "%rollback_on_failed_patch%"=="true" (
        rd /q /s "%basedir%\%target_gamedir%" >nul
        echo Failed to apply patch; rolled back the mod install.
        echo If you really want to install just the unpatched mod, you can set the
        echo rollback_on_failed_patch option to false in your installer config.
      ) else (
        if "%patch_acquired%"=="true" (
          if exist "%basedir%\%target_gamedir%.bak" (
            rd /q /s "%basedir%\%target_gamedir%" >nul
            move "%basedir%\%target_gamedir%.bak" "%basedir%\%target_gamedir%"
            echo Failed to apply patch. Since the rollback_on_failed_patch option is
            echo set to false in your installer config, the unpatched mod is still
            echo left installed.
          ) else (
            echo Failed to back up "%target_gamedir%" before patching, so didn't
            echo patch the mod. Since the rollback_on_failed_patch option is set to
            echo false in your installer config, the unpatched mod is still left
            echo installed.
          )
        ) else (
          echo Failed to get the patch. Since the rollback_on_failed_patch option
          echo is set to false in your installer config, the unpatched mod is still
          echo left installed.
        )
      )
    )
  )
  echo.
)
if exist "%basedir%\%target_gamedir%.bak" (
  rd /q /s "%basedir%\%target_gamedir%.bak" >nul
)

endlocal & set patch_success=%success%
