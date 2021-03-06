REM Helper "subroutine" script to process a mod-installer menu choice.

REM On the commandline, the url arg is required.

REM The caller is also required to set the basedir and quake_exe variables.

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
if "%quake_exe%"=="" (
  echo The required variable quake_exe is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files. quake_exe is set in your installer config.
  goto :eof
) else (
  for /f %%a in ("%quake_exe%") do (
    if not exist "%basedir%"\%%a (
      echo The configured Quake engine: %%a
      echo does not exist in the Quake folder: %basedir%
      echo.
      echo If you need to configure a different executable to use for Quake, see the
      echo "advanced_quakestarter_cfg.txt" doc in the "quakestarter_docs\other_stuff"
      echo folder.
      echo.
      goto :eof
    )
  )
)
set url=%~1
set archive=%~nx1
if "%renamed_gamedir%"=="" (
  set gamedir=%~n1
) else (
  set gamedir=%renamed_gamedir%
)

cls

REM handle multigame_support, especially "auto" behavior
set game_switch=game
set base_game_switch=game
set multigame_game_switch=game
if "%multigame_support%"=="auto" (
  if not "%quake_exe%"=="%quake_exe:quakespasm-spiked=%" (
    set multigame_support=true
  ) else (
    if not "%quake_exe%"=="%quake_exe:vkQuake=%" (
      set multigame_support=true
    ) else (
      if not "%quake_exe%"=="%quake_exe:fteqw=%" (
        set multigame_support=true
      ) else (
        if not "%quake_exe%"=="%quake_exe:darkplaces=%" (
          set multigame_support=true
        ) else (
          if not "%quake_exe%"=="%quake_exe:qbismS8=%" (
            set multigame_support=true
            set base_game_switch=game2
            set multigame_game_switch=game
          ) else (
            set multigame_support=false
          )
        )
      )
    )
  )
) else (
  if not "%multigame_support%"=="true" (
    if not "%multigame_support%"=="false" (
      set base_game_switch=%multigame_support%
      for /f "delims=; tokens=1,2" %%a in ("%multigame_support%") do (
        set base_game_switch=%%a
        set multigame_game_switch=%%b
      )
      set multigame_support=true
    )
  )
)

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
      echo Managing "%gamedir%" ^(which depends on "ad_v1_80p1final"^) is not
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
    set game_switch=%multigame_game_switch%
  )
  if "%base_game%"=="copper_v1_15" (
    if not "%multigame_support%"=="true" (
      echo Managing "%gamedir%" ^(which depends on "copper_v1_15"^) is not
      echo possible through Quakestarter since multigame_support is false in
      echo your config.
      echo.
      goto :eof
    )
    if not exist "%basedir%\copper_v1_15" (
      set skip_quakerc_gen=true
      call "%scriptspath%_install_mod.cmd" http://lunaran.com/files/copper_v1_15.zip copper_v1_15
      if not exist "%basedir%\copper_v1_15" (
        echo Failed to install "copper_v1_15" which is required by "%gamedir%".
        echo.
        goto :eof
      )
    )
    set game_switch=%multigame_game_switch%
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
if "%base_game%"=="" (
  set base_game_arg=
) else (
  if "%base_game%"=="ad_v1_80p1final" (
    set base_game_arg=-%base_game_switch% ad_v1_80p1final
  ) else (
    if "%base_game%"=="copper_v1_15" (
      set base_game_arg=-%base_game_switch% copper_v1_15
    ) else (
      set base_game_arg=-%base_game%
    )
  )
)
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
      echo that means putting %base_game_arg% before -%game_switch% %gamedir%.
      echo.
    )
    if "%base_game%"=="copper_v1_15" (
      echo make sure to specify copper_v1_15 as a base mod. On the command line
      echo that means putting %base_game_arg% before -%game_switch% %gamedir%.
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
