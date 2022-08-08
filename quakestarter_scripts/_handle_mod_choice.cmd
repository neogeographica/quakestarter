REM Helper "subroutine" script to process a mod-installer menu choice.

REM On the commandline, the addon_name arg is required. A second argument
REM specifying the download URL is optional; if omitted (as usual) then the
REM URL is implicitly for the named addon at Quaddicted.

REM The caller is also required to set the basedir and quake_exe variables.

REM Optional args will be specified through these variables:
REM   renamed_gamedir
REM   review_page
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
REM   junkdirs

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
      echo Advanced Configuration chapter in the Other Topics part of the docs.
      echo.
      goto :pauseexit
    )
  )
)
set addon_name=%~1

REM if holding down Shift, view the Quaddicted page instead
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} Add-Type -A PresentationCore;if ([System.Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::LeftShift)){exit 0;} if ([System.Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::RightShift)){exit 0;} exit 1;}"
if %errorlevel% equ 0 (
  if "%review_page%"=="" (
    start /b https://www.quaddicted.com/reviews/%addon_name%.html
  ) else (
    if not "%review_page%"=="%review_page:https://=%" (
      start /b %review_page%
    ) else (
      start /b https://www.quaddicted.com/reviews/%review_page%.html
    )
  )
  goto :eof
)

set archive=%addon_name%.zip
if "%2"=="" (
  set url=https://www.quaddicted.com/filebase/%archive%
) else (
  set url=%~2
)
if "%renamed_gamedir%"=="" (
  set gamedir=%1
) else (
  set gamedir=%renamed_gamedir%
)

cls

REM handle multigame_support, especially "auto" behavior
REM NOTE: Much of this same logic is in setengine.cmd; eventually think about
REM factoring it out. Also the if-tree is getting kinda big!
set game_switch=game
set base_game_switch=game
set multigame_game_switch=game
if "%multigame_support%"=="auto" (
  if not "%quake_exe%"=="%quake_exe:vkQuake=%" (
    set multigame_support=true
  ) else (
    if not "%quake_exe%"=="%quake_exe:ironwail=%" (
      set multigame_support=true
    ) else (
      if not "%quake_exe%"=="%quake_exe:quakespasm-spiked=%" (
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
set saved_junkdirs=%junkdirs%
set junkdirs=
set last_base_game=%base_game%
set check_basegame_changed=false
set basegame_changed=false
if "%base_game%"=="%latest_ad%" (
  set check_basegame_changed=true
)
if "%base_game%"=="%latest_copper%" (
  set check_basegame_changed=true
)
if "%check_basegame_changed%"=="true" (
  if exist "%basedir%\%gamedir%\_last_launch.cmd" (
    call "%basedir%\%gamedir%\_last_launch.cmd"
  )
)
if not "%last_base_game_arg%"=="" (
  for /f "tokens=2" %%l in ("%last_base_game_arg%") do (
    set last_base_game=%%l
  )
)
set base_game_to_use=%base_game%
set bg_choice=y
if not "%base_game%"=="%last_base_game%" (
  echo NOTE: A dependency of this mod has had an update.
  echo The previous run of this mod used: %last_base_game%
  echo But the current version of that dependency is now: %base_game%
  echo FYI if you launch using the current version, any existing savegames for this
  echo mod may not work.
  echo.
  echo Do you want to launch with the previously-used version of that dependency?
  echo y: yes, use %last_base_game% like last time
  echo n: no, use the current version %base_game%
  echo.
  set /p bg_choice=choose an option, or just press Enter to use the older version:
  echo.
)
goto use_last_bg_%bg_choice%
:use_last_bg_y
:use_last_bg_Y
set base_game_to_use=%last_base_game%
:use_last_bg_n
:use_last_bg_N
set handle_multigame=false
if not "%base_game%"=="" (
  if "%base_game%"=="quoth" (
    if not exist "%basedir%\quoth" (
      set skip_quakerc_gen=true
      call "%scriptspath%_install_mod.cmd" https://www.quaddicted.com/filebase/quoth2pt2full_2.zip quoth
      if not exist "%basedir%\quoth" (
        echo Failed to install "quoth" which is required by "%gamedir%".
        echo.
        goto :pauseexit
      )
    )
  )
  if "%base_game%"=="%latest_ad%" (
    set handle_multigame=true
  )
  if "%base_game%"=="%latest_copper%" (
    set handle_multigame=true
  )
)
if "%handle_multigame%"=="true" (
  if not "%multigame_support%"=="true" (
    echo Managing "%gamedir%" ^(which depends on "%base_game_to_use%"^) is not
    echo possible through Quakestarter since multigame_support is false in
    echo your config.
    echo.
    goto :pauseexit
  )
  if not exist "%basedir%\%base_game_to_use%" (
    set skip_quakerc_gen=true
    call "%scriptspath%_install_mod.cmd" https://www.quaddicted.com/filebase/%base_game_to_use%.zip %base_game_to_use%
    if not exist "%basedir%\%base_game_to_use%" (
      echo Failed to install "%base_game_to_use%" which is required by "%gamedir%".
      echo.
      goto :pauseexit
    )
  )
  set game_switch=%multigame_game_switch%
)

if "%base_game%"=="hipnotic" (
  if not exist "%basedir%\hipnotic\pak0.pak" (
    echo "%gamedir%" requires missionpack 1 to currently be installed.
    echo.
    goto :pauseexit
  )
)

if "%base_game%"=="rogue" (
  if not exist "%basedir%\rogue\pak0.pak" (
    echo "%gamedir%" requires missionpack 2 to currently be installed.
    echo.
    goto :pauseexit
  )
)

set skip_quakerc_gen=%saved_skip_quakerc_gen%
set junkdirs=%saved_junkdirs%

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

if not exist "%basedir%\%gamedir%" goto :pauseexit

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
  if "%base_game%"=="%latest_ad%" (
    set base_game_arg=-%base_game_switch% %base_game_to_use%
  ) else (
    if "%base_game%"=="%latest_copper%" (
      set base_game_arg=-%base_game_switch% %base_game_to_use%
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
    if "%base_game%"=="%latest_ad%" (
      echo make sure to specify %base_game_to_use% as a base mod. On the command line
      echo that means putting %base_game_arg% before -%game_switch% %gamedir%.
      echo.
    )
    if "%base_game%"=="%latest_copper%" (
      echo make sure to specify %base_game_to_use% as a base mod. On the command line
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

if not exist "%basedir%\%gamedir%" goto :pauseexit

if "%postlaunch_msg[0]%"=="" goto :pauseexit

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

:pauseexit
pause
