REM Helper "subroutine" script to work with an installed mod.
REM Used by _handle_mod_choice.cmd.

REM On the commandline, the archive and gamedir args are required.

REM The caller is also required to set the bsaedir, quake_exe,
REM download_subdir, and patch_download_subdir variables.

REM Optional args will be specified through these variables:
REM   base_game
REM   patch_url
REM   patch2_url
REM   start_map
REM   extra_launch_args

setlocal

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
if "%quake_exe%"=="" (
  echo The required variable quake_exe is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files. quake_exe is set in your installer config.
  goto :eof
)
if "%download_subdir%"=="" (
  echo The required variable download_subdir is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files. download_subdir is set in your installer config.
  goto :eof
)
if "%patch_download_subdir%"=="" (
  echo The required variable patch_download_subdir is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files. patch_download_subdir is set in your installer config.
  goto :eof
)
set archive=%~1
set gamedir=%~2
set game_arg= -game "%gamedir%"

echo Do you want to launch Quake now with "%gamedir%" loaded?

if "%start_map%"=="" (
  set start_map_arg=
  echo Since there is no specific "start map" for this mod, you will have to
  echo handle map selection on your own ^(with the console "map" command,
  echo unless your Quake engine provides a map selection menu^).
  echo Do NOT just start a New Game through the Single Player menu.
) else (
  set start_map_arg= +map "%start_map%"
  echo You will begin in its map "%start_map%" ^(which may or may not provide
  echo for in-map skill selection^).
)

if "%base_game%"=="" (
  set base_game_arg=
) else (
  set base_game_arg= -%base_game%
)

set zips_exist=false
if exist "%basedir%\%download_subdir%\%archive%" (
  set zips_exist=true
)
if not "%patch_url%"=="" (
  for /f %%p in ("%patch_url%") do (
    if exist "%basedir%\%patch_download_subdir%\%%~nxp" (
      set zips_exist=true
    )
  )
)
if not "%patch2_url%"=="" (
  for /f %%p in ("%patch2_url%") do (
    if exist "%basedir%\%patch_download_subdir%\%%~nxp" (
      set zips_exist=true
    )
  )
)
echo.
echo Launch options:
echo y: launch without explicitly setting a skill
echo n: do not launch
echo 0-3: launch and set a default initial skill
echo.
if "%zips_exist%"=="true" (
  echo ^(x to uninstall, xx to also delete cached zipfile downloads^)
) else (
  echo ^(x to uninstall^)
)
echo.
set skill_arg=
set launch_choice=y
set /p launch_choice=choose an option, or just press Enter to launch:
goto %launch_choice%

:Xx
:xX
:xx
:XX
del /q "%basedir%\%download_subdir%\%archive%" >nul
if not "%patch_url%"=="" (
  for /f %%p in ("%patch_url%") do (
    del /q "%basedir%\%patch_download_subdir%\%%~nxp" >nul
  )
)
if not "%patch2_url%"=="" (
  for /f %%p in ("%patch2_url%") do (
    del /q "%basedir%\%patch_download_subdir%\%%~nxp" >nul
  )
)
:x
:X
rd /s /q "%basedir%\%gamedir%" >nul
goto :N

:0
:1
:2
:3
set skill_arg= +skill %launch_choice%

:y
:Y
set quake_args=%extra_launch_args%%base_game_arg%%game_arg%%skill_arg%%start_map_arg%
echo.
echo running: %quake_exe% %quake_args%
start "" /b /wait "%basedir%\%quake_exe%" %quake_args%

:n
:N
echo.
