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

cls
echo.
echo Current setting for Quake engine to launch: %quake_exe%
echo.
set new_quake_exe=%quake_exe%
set /p new_quake_exe=enter a new exe or just press Enter to leave unchanged:
echo.

REM XXX Various fancy things I can do here such as:
REM  * shorcuts for picking vkQuake.exe or ironwail.exe
REM  * checking that the specified exe actually exists
REM  * if an unknown exe is entered, warn multigame_support may need change
REM
REM Also need documentation changes of course, both for this stuff and for
REM the changes to the main menu options.
REM
REM For now let's just make sure the basic functionality of changing the
REM setting works.

if "%new_quake_exe%"=="%quake_exe%" (
  goto :eof
)

REM _quakestarter_cfg.cmd really should exist already, but let's handle if
REM it does not.
if not exist "%cfgpath%_quakestarter_cfg.cmd" (
  echo set quake_exe=%new_quake_exe%> "%cfgpath%_quakestarter_cfg.cmd"
  goto :eof
)

REM Let's see if _quakestarter_cfg.cmd currently has a setting for quake_exe.
pushd "%cfgpath%"
set foundline=
for /f "delims=" %%a in ('powershell.exe -nologo -noprofile -command "&{trap{exit 1;} Select-String -path _quakestarter_cfg.cmd '^\s*set\s+quake_exe=';}"') do (
  set foundline=%%a
)
REM If not, just add it to the end.
if "%foundline%"=="" (
  echo.>> "_quakestarter_cfg.cmd"
  echo set quake_exe=%new_quake_exe%>> "_quakestarter_cfg.cmd"
  popd
  goto :eof
)
REM If so, we need to replace it.
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} (Get-Content _quakestarter_cfg.cmd) -replace '^\s*set\s+quake_exe=.*', 'set quake_exe=%new_quake_exe%' | Out-File -encoding ASCII _quakestarter_cfg.cmd;}"
popd
