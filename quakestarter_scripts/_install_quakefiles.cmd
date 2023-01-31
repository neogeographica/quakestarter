REM Helper "subroutine" script to find and copy a Quake file or folder on this
REM computer to our own Quake installation here (only a file/folder immediately
REM under id1 or some other gamedir).

REM On the commandline, the gamedir and target args are required.

REM The caller is also required to set the basedir variable.

REM An optional arg can be specified through this variables:
REM   md5sum

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
set gamedir=%~1
set target=%~2
set dest_gamedir=%basedir%\%gamedir%
set dest=%dest_gamedir%\%target%

if exist "%dest%" (
  echo "%gamedir%\%target%" already exists.
  goto :eof
)

echo Looking for "%gamedir%\%target%" ...

set found_target=false
set dirs_checked=

REM first check registry for Steam, GOG, or Bethesda.net Quake installs
call :reg_query_and_copy "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2310" InstallLocation
if exist "%dest%" goto :eof
call :reg_query_path_root_and_copy "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 2310" InstallLocation "rerelease"
if exist "%dest%" goto :eof
call :reg_query_path_root_and_copy "HKCU\SOFTWARE\Valve\Steam" SteamPath "steamapps\common\Quake"
if exist "%dest%" goto :eof
call :reg_query_path_root_and_copy "HKCU\SOFTWARE\Valve\Steam" SteamPath "steamapps\common\Quake\rerelease"
if exist "%dest%" goto :eof
call :reg_query_and_copy "HKLM\SOFTWARE\WOW6432Node\GOG.com\Games\1435828198" PATH
if exist "%dest%" goto :eof
call :reg_query_and_copy "HKLM\SOFTWARE\WOW6432Node\GOG.com\Games\1739637082" PATH
if exist "%dest%" goto :eof
call :reg_query_and_copy "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\1435828198_is1" InstallLocation
if exist "%dest%" goto :eof
call :reg_query_and_copy "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\1739637082_is1" InstallLocation
if exist "%dest%" goto :eof
call :reg_query_path_root_and_copy "HKLM\SOFTWARE\WOW6432Node\Bethesda Softworks\Bethesda.net" installLocation "games\Quake"
if exist "%dest%" goto :eof

REM also check through any Steam library folders
reg query "HKCU\SOFTWARE\Valve\Steam" /v "SteamPath" > nul 2>&1
if %errorlevel% neq 0 (
  goto :search
)
for /f "tokens=2,* skip=2" %%a in ('reg query "HKCU\SOFTWARE\Valve\Steam" /v "SteamPath"') do (
  set steampath="%%b"
)
set vdfpath=%steampath%\config\libraryfolders.vdf
if not exist "%vdfpath%" (
  goto :search
)
setlocal EnableDelayedExpansion
for /f "tokens=*" %%l in ('findstr \"path\" %vdfpath%') do (
  for /f "tokens=* delims= " %%s in ("%%l") do (
    for /f tokens^=3^ delims^=^" %%v in ("%%s") do (
      set libpathvalue=%%v
      set libpath=!libpathvalue:\\=\!
      call :handle_reg_query_copy "!libpath!\steamapps\common\Quake"
      if exist "%dest%" goto :eof
      call :handle_reg_query_copy "!libpath!\steamapps\common\Quake\rerelease"
      if exist "%dest%" goto :eof
    )
  )
)
endlocal & set dirs_checked=%dirs_checked%& set found_target=%found_target%

:search
REM no luck there, so let's look in the usual locations
setlocal EnableDelayedExpansion
set drives=
for /f "delims=: tokens=1,*" %%a in ('fsutil fsinfo drives') do (
  for %%c in (%%b) do (
    set drive=%%c
    >nul 2>&1 vol !drive:\=! && set drives=!drives! %%c
  )
)
call :search_common_paths "Quake"
if exist "%dest%" goto :eof
call :search_common_paths "Quake\rerelease"
if exist "%dest%" goto :eof
call :search_common_paths "QUAKE\Content"
if exist "%dest%" goto :eof
call :search_common_paths "Steam\steamapps\common\Quake"
if exist "%dest%" goto :eof
call :search_common_paths "Steam\steamapps\common\Quake\rerelease"
if exist "%dest%" goto :eof
call :search_common_paths "GOG Games\Quake"
if exist "%dest%" goto :eof
call :search_common_paths "GOG Galaxy\Games\Quake"
if exist "%dest%" goto :eof
call :search_common_paths "GOG Games\Quake Enhanced"
if exist "%dest%" goto :eof
call :search_common_paths "GOG Galaxy\Games\Quake Enhanced"
if exist "%dest%" goto :eof
call :search_common_paths "XboxGames\QUAKE\Content"
if exist "%dest%" goto :eof
call :search_common_paths "Epic Games\Quake"
if exist "%dest%" goto :eof
call :search_common_paths "Bethesda.net Launcher\games\Quake"
if exist "%dest%" goto :eof
endlocal & set dirs_checked=%dirs_checked%& set found_target=%found_target%

if "%found_target%"=="false" (
  echo Couldn't find "%gamedir%\%target%" in the usual locations.
)

goto :eof


REM functions used above

:search_common_paths
set subpath=%~1
set temp=Program Files (x86)\%subpath%
call :find_and_copy_from "%temp%"
if exist "%dest%" goto :eof
call :find_and_copy_from "Program Files\%subpath%"
if exist "%dest%" goto :eof
call :find_and_copy_from "Games\%subpath%"
if exist "%dest%" goto :eof
call :find_and_copy_from "%subpath%"
goto :eof

:reg_query_and_copy
reg query "%~1" /v "%~2" > nul 2>&1
if %errorlevel% equ 0 (
  for /f "tokens=2,* skip=2" %%a in ('reg query "%~1" /v "%~2"') do (
    call :handle_reg_query_copy "%%b"
  )
)
goto :eof

:reg_query_path_root_and_copy
reg query "%~1" /v "%~2" > nul 2>&1
if %errorlevel% equ 0 (
  for /f "tokens=2,* skip=2" %%a in ('reg query "%~1" /v "%~2"') do (
    call :handle_reg_query_copy "%%b\%~3"
  )
)
goto :eof

:handle_reg_query_copy
set fullpath=%~1
set backslashed=%fullpath:/=\%
if "%backslashed:~-1%"=="\" (
    set backslashedquoted="%backslashed:~0,-1%"
) else (
    set backslashedquoted="%backslashed%"
)
call :conditional_copy %backslashedquoted%
set dirs_checked=%dirs_checked% %backslashedquoted%
goto :eof

:find_and_copy_from
for %%a in (%drives%) do (
  call :conditional_copy "%%a%~1"
  if exist "%dest%" goto :eof
)
goto :eof

:conditional_copy
for %%d in (%dirs_checked%) do (
  if /i %%d=="%~1" goto :eof
)
if exist "%~1\%gamedir%\%target%" (
  if not "%md5sum%"=="" (
    setlocal enabledelayedexpansion
    set /a count=1
    for /f "skip=1 delims=:" %%a in ('certutil -hashfile "%~1\%gamedir%\%target%" MD5') do (
      if !count! equ 1 set "md5check=%%a"
      set/a count+=1
    )
    set "md5check=!md5check: =!
    if not "%md5sum%"=="!md5check!" (
      goto :eof
    )
    endlocal
  )
  call :copy_to_dest "%~1\%gamedir%\%target%"
)
goto :eof

:copy_to_dest
set found_target=true
set menu_choice=y
set /p menu_choice=Found "%~1", ok to copy that for our use here? ([y]/n):
if /i "%menu_choice%"=="y" (
  echo Copying "%~1" into "%dest_gamedir%"...
  md "%dest_gamedir%" 2> nul
  if exist "%~1\" (
    xcopy "%~1" "%dest_gamedir%\%target%" /s /e /c /i /r /k /q > nul
  ) else (
    xcopy "%~1" "%dest_gamedir%\" /c /i /r /k /q > nul
  )
)
goto :eof
