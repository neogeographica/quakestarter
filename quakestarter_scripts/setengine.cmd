@echo off

REM Utility for changing quake_exe value in _quakestarter_cfg.cmd

REM On the commandline, the cfgpath arg is required.

REM The caller is also required to set the quake_exe variable.

setlocal

set cfgpath=%~1
if "%cfgpath%"=="" (
  echo Missing arguments.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :eof
)
if "%quake_exe%"=="" (
  echo The required variable quake_exe is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :eof
)

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

:menu

for /f %%a in ("%quake_exe%") do (
  set quake_exe_program=%%a
)

cls
echo.
echo Current setting for Quake engine: %quake_exe%
if not exist "%basedir%\%quake_exe_program%" (
  echo WARNING: This program does not exist in your Quake folder. You should probably
  echo choose something else!
)
echo.

REM Present a menu of executables.

setlocal enabledelayedexpansion
set count=0
pushd "%basedir%"
for /f "delims=" %%a in ('dir /a:-d /b *.exe') do (
  if not "%%a" == "%quake_exe_program%" (
    if not "%%a" == "SQLauncher2.exe" (
      set /a count+=1
      set "executables[!count!]=%%a"
    )
  )
)
popd
if %count% == 0 (
  echo No other available programs in the Quake folder.
  echo.
  pause
  goto :eof
)
echo Other available programs in the Quake folder:
echo.
for /l %%a in (1,1,!count!) do (
  set padded=   %%a
  echo !padded:~-3!: !executables[%%a]!
)
echo.
if not "%quake_exe%" == "%quake_exe_program%" (
  echo NOTE: Selecting a new Quake engine here will NOT preserve the current extra
  echo command-line arguments that you have configured. You will need to add any
  echo such arguments by editing _quakestarter_cfg.cmd after the engine change.
  echo.
)
set menu_choice=
set /p menu_choice=enter your choice or just press Enter to keep current engine:
if "%menu_choice%" == "" (
  set new_quake_exe=%quake_exe_program%
  goto :onward
)
set new_quake_exe=
echo %menu_choice%| findstr /r "^[1-9][0-9]*$" > nul
if not %errorlevel% equ 0 (
  goto :onward
)
if %menu_choice% lss 1 (
  goto :onward
)
if %menu_choice% gtr %count% (
  goto :onward
)
set new_quake_exe=!executables[%menu_choice%]!
:onward
endlocal & set new_quake_exe=%new_quake_exe%

REM Try again if bad choice.
if "%new_quake_exe%" == "" (
  goto :menu
)

pushd "%cfgpath%"

REM No config changes to do if choice hasn't changed.
if "%new_quake_exe%"=="%quake_exe_program%" (
  goto :check
)

REM _quakestarter_cfg.cmd really should exist already, but let's handle if
REM it does not.
if not exist "_quakestarter_cfg.cmd" (
  echo set quake_exe=%new_quake_exe%> "_quakestarter_cfg.cmd"
  goto :check
)

REM Let's see if _quakestarter_cfg.cmd currently has a setting for quake_exe.
set foundline=
for /f "delims=" %%a in ('powershell.exe -nologo -noprofile -command "&{trap{exit 1;} Select-String -path _quakestarter_cfg.cmd '^\s*set\s+quake_exe=';}"') do (
  set foundline=%%a
)
REM If not, just add it to the end.
if "%foundline%"=="" (
  echo.>> "_quakestarter_cfg.cmd"
  echo set quake_exe=%new_quake_exe%>> "_quakestarter_cfg.cmd"
  goto :check
)
REM But if so, we need to replace it.
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} (Get-Content _quakestarter_cfg.cmd) -replace '^\s*set\s+quake_exe=.*', 'set quake_exe=%new_quake_exe%' | Out-File -encoding ASCII _quakestarter_cfg.cmd;}"


:check

popd

set quake_exe=%new_quake_exe%

REM Warn if the selected Quake engine is unsupported and/or if
REM multigame_support might need to be changed.
REM NOTE: Much of this same logic is in setengine.cmd; eventually think about
REM factoring it out. Also the if-tree is getting kinda big!
set engine_class=unrecognized
if not "%quake_exe%"=="%quake_exe:quakespasm-spiked=%" (
  set engine_class=supported
) else (
  if not "%quake_exe%"=="%quake_exe:vkQuake=%" (
    set engine_class=supported
  ) else (
    if not "%quake_exe%"=="%quake_exe:ironwail=%" (
      set engine_class=supported
    ) else (
      if not "%quake_exe%"=="%quake_exe:fteqw=%" (
        set engine_class=supported
      ) else (
        if not "%quake_exe%"=="%quake_exe:darkplaces=%" (
          set engine_class=supported
        ) else (
          if not "%quake_exe%"=="%quake_exe:qbismS8=%" (
            set engine_class=supported
          ) else (
            if not "%quake_exe%"=="%quake_exe:quakespasm=%" (
              set engine_class=recognized
            ) else (
              if not "%quake_exe%"=="%quake_exe:mark_v=%" (
                set engine_class=recognized
              ) else (
                if not "%quake_exe%"=="%quake_exe:glQrack=%" (
                  set engine_class=recognized
                )
                if not "%quake_exe%"=="%quake_exe:fitzquake=%" (
                  set engine_class=recognized
                )
                if not "%quake_exe%"=="%quake_exe:DirectQ=%" (
                  set engine_class=recognized
                )
                if not "%quake_exe%"=="%quake_exe:dx8pro=%" (
                  set engine_class=recognized
                )
                if not "%quake_exe%"=="%quake_exe:glpro=%" (
                  set engine_class=recognized
                )
                if not "%quake_exe%"=="%quake_exe:engwin=%" (
                  set engine_class=recognized
                )
                if not "%quake_exe%"=="%quake_exe:engqsb=%" (
                  set engine_class=recognized
                )
                if not "%quake_exe%"=="%quake_exe:nq-sdl=%" (
                  set engine_class=recognized
                )
              )
            )
          )
        )
      )
    )
  )
)
REM If there's a potential issue with the chosen engine, let them know.
if not "%engine_class%"=="supported" (
  echo.
  if "%engine_class%"=="recognized" (
    echo WARNING: The Quake engine "%quake_exe%" cannot launch all Quakestarter items.
    echo See the Advanced Configuration chapter of the Quakestarter docs ^(under Other
    echo Topics^) for more details.
  ) else (
    echo WARNING: Program "%quake_exe%" is not recognized as a Quake engine that can
    echo launch all Quakestarter items. See the Advanced Configuration chapter of the
    echo Quakestarter docs ^(under Other Topics^) for more details.
  )
  echo.
  pause
  goto :eof
)
REM For most supported engines, multigame_support can be set to "auto" or
REM "true". For Super8 though it should be "auto".
set multigame_ok=false
if "%multigame_support%"=="auto" (
  set multigame_ok=true
)
if "%quake_exe%"=="%quake_exe:qbismS8=%" (
  if "%multigame_support%"=="true" (
    set multigame_ok=true
  )
)
if "%multigame_ok%"=="false" (
  echo.
  echo WARNING: You have set multigame_support to "%multigame_support%"" in your config;
  echo normally it should be left as the default value of "auto" for this engine.
  echo.
  pause
)
