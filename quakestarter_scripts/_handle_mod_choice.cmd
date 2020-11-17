REM Helper "subroutine" script to process a mod-installer menu choice.

REM On the commandline, the url arg is required.

REM The caller is also required to set the basedir variable.

REM Optional args will be specified through these variables:
REM   renamed_gamedir
REM   base_game
REM   patch_url
REM   patch_required
REM   patch_skipfiles
REM   patch2_url
REM   patch2_required
REM   patch2_skipfiles
REM   start_map
REM   extra_launch_args
REM   prelaunch_msg (array of msg lines, must end with blank line)
REM   postlaunch_msg (array of msg lines, must end with blank line)
REM   skip_quakerc_gen
REM   modsettings (array of cfg lines, must end with blank line)
REM   startdemos

setlocal

REM remember dir where this script lives
set scriptspath=%~dp0

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
set archive=%~nx1
if "%renamed_gamedir%"=="" (
  set gamedir=%~n1
) else (
  set gamedir=%renamed_gamedir%
)

cls

REM base game check and (in some cases) install
set saved_skip_quakerc_gen=%skip_quakerc_gen%
if not "%base_game%"=="" (
  if "%base_game%"=="quoth" (
    if not exist "%basedir%\quoth" (
      set skip_quakerc_gen=true
      call "%scriptspath%_install_mod.cmd" http://www.quaketastic.com/files/single_player/mods/quoth2pt2full.zip quoth
      if not exist "%basedir%\quoth" (
        echo Failed to install "quoth" which is required by "%gamedir%".
        echo.
        goto :eof
      )
    )
  )
  if "%base_game%"=="ad_v1_80p1final" (
    if not "%multigame_support%"=="true" (
      echo Managing"%gamedir%" ^(which depends on "ad_v1_80p1final"^) is not
      echo possible through Quakestarter since multigame_support is false in
      echo your config.
      echo.
      goto :eof
    )
    if not exist "%basedir%\ad_v1_80p1final" (
      set skip_quakerc_gen=true
      call "%scriptspath%_install_mod.cmd" https://www.quaddicted.com/filebase/ad_v1_80p1final.zip ad_v1_80p1final
      if not exist "%basedir%\ad_v1_80p1final" (
        echo Failed to install "ad_v1_80p1final" which is required by "%gamedir%".
        echo.
        goto :eof
      )
    )
  )
  if "%base_game%"=="copper_v1_11" (
    if not "%multigame_support%"=="true" (
      echo Managing "%gamedir%" ^(which depends on "copper_v1_11"^) is not
      echo possible through Quakestarter since multigame_support is false in
      echo your config.
      echo.
      goto :eof
    )
    if not exist "%basedir%\copper_v1_11" (
      set skip_quakerc_gen=true
      call "%scriptspath%_install_mod.cmd" https://www.quaddicted.com/filebase/copper_v1_11.zip copper_v1_11
      if not exist "%basedir%\copper_v1_11" (
        echo Failed to install "copper_v1_11" which is required by "%gamedir%".
        echo.
        goto :eof
      )
    )
  )
  if "%base_game%"=="hipnotic" (
    if not exist "%basedir%\hipnotic\pak0.pak" (
      echo "%gamedir%" requires missionpack 1 to currently be installed.
      echo.
      goto :eof
    )
  )
  if "%base_game%"=="rogue" (
    if not exist "%basedir%\rogue\pak0.pak" (
      echo "%gamedir%" requires missionpack 2 to currently be installed.
      echo.
      goto :eof
    )
  )
)
set skip_quakerc_gen=%saved_skip_quakerc_gen%

REM mod install and possibly patch(es)
if not exist "%basedir%\%gamedir%" (
  call "%scriptspath%_install_mod.cmd" "%url%" "%gamedir%"
  if exist "%basedir%\%gamedir%" (
    if not "%patch_url%"=="" (
      set required=%patch_required%
      set skipfiles=%patch_skipfiles%
      call "%scriptspath%_install_patch.cmd" "%patch_url%" "%gamedir%"
    )
    if not "%patch2_url%"=="" (
      if exist "%basedir%\%gamedir%" (
        set required=%patch2_required%
        set skipfiles=%patch2_skipfiles%
        call "%scriptspath%_install_patch.cmd" "%patch2_url%" "%gamedir%"
      )
    )
  )
)

REM launch and other options

if not exist "%basedir%\%gamedir%" goto :eof

if "%prelaunch_msg[0]%"=="" goto :launch

setlocal enabledelayedexpansion
set idx=0
:premsgloop
set loop=false
if not "!prelaunch_msg[%idx%]!"=="" (
  echo !prelaunch_msg[%idx%]!
  set /a idx+=1
  set loop=true
)
if "%loop%"=="true" goto :premsgloop
endlocal
echo.

:launch
call "%scriptspath%_manage_mod.cmd" "%archive%" "%gamedir%"
if not "%base_game%"=="" (
  if exist "%basedir%\%gamedir%" (
    echo If you launch "%gamedir%" outside of this installer,
    if "%base_game%"=="quoth" (
      echo make sure to specify Quoth as the base game. On the command line that means
      echo using the -quoth argument.
      echo.
    )
    if "%base_game%"=="ad_v1_80p1final" (
      echo make sure to specify ad_v1_80p1final as a base mod. On the command line
      echo that means putting -game "ad_v1_80p1final" BEFORE -game "%gamedir%".
      echo.
    )
    if "%base_game%"=="copper_v1_11" (
      echo make sure to specify copper_v1_11 as a base mod. On the command line
      echo that means putting -game "copper_v1_11" BEFORE -game "%gamedir%".
      echo.
    )
    if "%base_game%"=="hipnotic" (
      echo make sure to specify missionpack 1 as the base game. On the command line
      echo that means using the -hipnotic argument.
      echo.
    )
    if "%base_game%"=="rogue" (
      echo make sure to specify missionpack 2 as the base game. On the command line
      echo that means using the -rogue argument.
      echo.
    )
  )
)

if not exist "%basedir%\%gamedir%" goto :eof

if "%postlaunch_msg[0]%"=="" goto :eof

setlocal enabledelayedexpansion
set idx=0
:postmsgloop
set loop=false
if not "!postlaunch_msg[%idx%]!"=="" (
  echo !postlaunch_msg[%idx%]!
  set /a idx+=1
  set loop=true
)
if "%loop%"=="true" goto :postmsgloop
endlocal
echo.
