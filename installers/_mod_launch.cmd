REM save working dir and change to dir that holds this script
pushd "%~dp0"

REM capture map and other commandline args
if "%1"=="" (
  echo Missing the command-line args for base game, gamedir, and startmap.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :N
)
set game_arg= -game "%~1"
set start_map=%~2
set base_game=%~3

REM CD up to Quake engine dir if necessary
if "%quake_exe%"=="" (
  set quake_exe=mark_v.exe
)
if not exist "%quake_exe%" (
  cd ..
  if not exist "%quake_exe%" (
    echo Couldn't find "%quake_exe%" in this folder or parent folder.
    goto :N
  )
)

echo Do you want to launch Quake now with "%~1" loaded?

if "%start_map%"=="" (
  set start_map_arg=
  echo Since there is no specific "start map" for this mod, you will have to
  echo handle map selection on your own ^(through the console, or through the
  echo Single Player Levels menu of Mark V^).
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

echo(
echo Launch options:
echo y: launch without explicitly setting a skill
echo n: do not launch
echo 0-3: launch and set a default initial skill
echo(
set skill_arg=
set launch_choice=y
set /p launch_choice=choose an option, or just press Enter to launch:
goto %launch_choice%

:0
:1
:2
:3
set skill_arg= +skill %launch_choice%

:y
:Y
set quake_command=".\%quake_exe%"%base_game_arg%%game_arg%%skill_arg%%start_map_arg%
echo(
echo running: %quake_command%
start "" /b /wait %quake_command%

:n
:N
REM finally restore original working dir to be nice
echo(
popd
