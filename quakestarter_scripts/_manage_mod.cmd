REM Helper "subroutine" script to work with an installed mod.
REM Used by _handle_mod_choice.cmd.

REM On the commandline, the archive and gamedir args are required.

REM The caller is also required to set the basedir, quake_exe,
REM download_subdir, and patch_download_subdir variables.

REM Optional args will be specified through these variables:
REM   base_game_arg
REM   patch_url
REM   patch2_url
REM   start_map
REM   extra_launch_args
REM   startdemos

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
set game_arg= -game %gamedir%
set run_startdemos=false
if "%start_map%"=="start" (
  if not "%startdemos%"=="" (
    if "%play_unique_startdemos%"=="true" (
      set run_startdemos=true
    )
  )
)

echo Do you want to launch Quake now with "%gamedir%" loaded?
echo.

REM The startdemos+demos trick to force Quakespasm to play the demos results
REM in the first demo in the loop being initially skipped. Reorder them to
REM get the expected order here. (In some cases, like Soul of Evil, the order
REM is important.)
setlocal enabledelayedexpansion
if "%run_startdemos%"=="true" (
  for %%s in (%startdemos%) do (
    if "!reversed!"=="" (
      set reversed=%%s
    ) else (
      set reversed=%%s !reversed!
    )
  )
  for %%r in (!reversed!) do (
    if "!newfirstdemo!"=="" (
      set newfirstdemo=%%r
    ) else (
      if "!newstartdemos!"=="" (
        set newstartdemos=%%r
      ) else (
        set newstartdemos=%%r !newstartdemos!
      )
    )
  )
  if not "!newfirstdemo!"=="" (
    if "!newstartdemos!"=="" (
      set newstartdemos=!newfirstdemo!
    ) else (
      set newstartdemos=!newfirstdemo! !newstartdemos!
    )
  )
)
endlocal & set startdemos=%newstartdemos%

set normal_start=true
if "%start_map%"=="" (
  set normal_start=false
  set start_map_arg=
  echo Since there is no specific "start map" for this mod, you will have to
  echo handle map selection on your own ^(with the console "map" command,
  echo unless your Quake engine provides a map selection menu^).
  echo Do NOT just start a New Game through the Single Player menu.
)
REM Trying to handle some quirks with startdemos here...
REM qbism Super8 has problems with specifying startdemos on the command line,
REM and also has problems with the "demos" command. On the other hand, unlike
REM Quakespasm it doesn't try to suppress startdemos by default. So let's
REM special-case the handling of Super8 just to leave the startdemos behavior
REM to whatever is in quake.rc.
REM Also, if quake_exe is NOT Quakespasm-Spiked, warn that some demos might
REM not play correctly.
if "%run_startdemos%"=="true" (
  set normal_start=false
  if "%quake_exe%"=="%quake_exe:qbismS8=%" (
    set start_map_arg= +startdemos %startdemos% +demos
  ) else (
    set start_map_arg=
  )
  echo This mod comes with a unique set of demo films that will initially play in
  echo an "attract mode" when the mod launches. You can press ESC to get to the
  echo main menu, then select Single Player. From there you can begin a new game
  echo in this mod, or load a savegame.
  if "%quake_exe%"=="%quake_exe:quakespasm-spiked=%" (
    echo If your Quake engine of choice is unable to play the demo^(s^) then you will be
    echo dropped into the console ... press ESC and proceed from there.
  )
)
if "%normal_start%"=="true" (
  set start_map_arg= +map %start_map%
  echo You will begin in its map "%start_map%" ^(which may or may not provide
  echo for in-map skill selection^).
)

if not "%base_game_arg%"=="" (
  set base_game_arg= %base_game_arg%
)

if not "%extra_launch_args%"=="" (
  set extra_launch_args= %extra_launch_args%
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
set basic_quake_args=%extra_launch_args%%base_game_arg%%game_arg%%skill_arg%
set quake_args=%basic_quake_args%%start_map_arg%
echo.
REM I guess let's not show the demos stuff if we're doing that. It's not really
REM related to what the basic args are for launching the mod. Otherwise though
REM go ahead and show the startmap arg we're using.
if "%run_startdemos%"=="true" (
  set display_quake_args=%basic_quake_args%
) else (
  set display_quake_args=%quake_args%
)
REM Record what we're doing.
echo REM Generated by Quakestarter. Captures info used in most recent launch. > "%basedir%\%gamedir%\_last_launch.cmd"
echo. >> "%basedir%\%gamedir%\_last_launch.cmd"
echo set last_quake_exe=%quake_exe% >> "%basedir%\%gamedir%\_last_launch.cmd"
echo set last_extra_launch_args=%extra_launch_args% >> "%basedir%\%gamedir%\_last_launch.cmd"
echo set last_base_game_arg=%base_game_arg% >> "%basedir%\%gamedir%\_last_launch.cmd"
REM And away we go!
echo running: %quake_exe%%display_quake_args%
start "" /b /wait "%basedir%\%quake_exe%"%quake_args%

:n
:N
echo.
