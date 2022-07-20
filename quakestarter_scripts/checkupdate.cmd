@echo off

REM Check for Quakestarter updates.

REM On the commandline, the rootpath arg is required.

setlocal

set rootpath=%~1
if "%rootpath%"=="" (
  echo Missing arguments.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files.
  goto :eof
)

REM remember dir where this script lives
set scriptspath=%~dp0

set version_current=
set version_current_download=

pushd "%rootpath%"

set destdir=quakestarter_upgrade
set extractdir=%destdir%\unpacked
set backupdir=%destdir%\backup

REM if the quakestarter_upgrade directory exists, a previous upgrade failed
if exist "%destdir%" (
  echo.
  echo It looks like a previous upgrade failed to complete.
  goto :failedupgrade
)

REM get the URL for the current (i.e. most recent) version's downloads page
REM if we haven't yet done that today
forfiles /p "%scriptspath:~0,-1%" /m _version_current.cmd /d 0 >nul 2>&1
if %errorlevel% equ 0 (
  goto :skipgetcurrent
)
echo|set /p="set version_current="> "%scriptspath%_version_current.cmd"
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} $progressPreference='silentlyContinue';(Invoke-WebRequest -MaximumRedirection 0 -Uri \"%update_location%\").Headers.Location;}" 2>nul >> "%scriptspath%_version_current.cmd"
if not %errorlevel% equ 0 (
  goto :checkerr
)

:skipgetcurrent

REM load the current-version URL and (if present yet) its download URL
call "%scriptspath%_version_current.cmd"
if "%version_current%"=="" (
  goto :checkerr
)

REM get the URL for the installed version
call "%scriptspath%_version_installed.cmd"

REM bail out if installed version is same as current
if "%version_current%"=="%version_installed%" (
  goto :bailout
)

REM get the current version's download URL if we don't have it yet
if not "%version_current_download%"=="" (
  goto :skipgetdl
)
echo|set /p="set version_current_download=">> "%scriptspath%_version_current.cmd"
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} $progressPreference='silentlyContinue';(Invoke-WebRequest -Uri \"%version_current%\").Links|foreach{[Uri]::new([Uri]\"%version_current%\",$_.href).AbsoluteUri}|Select-String -Pattern \"/quakestarter-[0-9][^^/]*zip$\"|foreach{$_.Line};}" 2>nul >> "%scriptspath%_version_current.cmd"
if not %errorlevel% equ 0 (
  goto :checkerr
)
call "%scriptspath%_version_current.cmd"
if "%version_current_download%"=="" (
  goto :checkerr
)

:skipgetdl

REM OK let's rock and roll...

echo.
echo A newer version of Quakestarter is available!
echo.
set /p cl_choice=Read the update notes? ([y]/n):
if "%cl_choice%"=="n" goto :nextchoice
if "%cl_choice%"=="N" goto :nextchoice
start /b %changelog_location%
echo Sent update notes to web browser...
:nextchoice
set /p dl_choice=Download and install? ([y]/n):
if "%dl_choice%"=="n" goto :bailout
if "%dl_choice%"=="N" goto :bailout
set /p e_choice=Include Quake engines? ([y]/n):
if "%e_choice%"=="n" goto :noengine
if "%e_choice%"=="N" goto :noengine
set manifest=quakestarter_scripts\manifest.txt
set url=%version_current_download%
goto :download
:noengine
set manifest=quakestarter_scripts\noengine-manifest.txt
set url=%version_current_download:/quakestarter-=/quakestarter-noengine-%
:download
for %%a in (%url%) do (
  set zipname=%%~nxa
)
set destfile=%destdir%\%zipname%
md "%destdir%"
echo ... downloading ...
set good_download=true
if "%hascurl%"=="true" (
  curl -L -f -# -o "%destfile%" "%url%"
) else (
  powershell.exe -nologo -noprofile -command "&{trap{exit 1;} [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls -bor [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12;(new-object System.Net.WebClient).DownloadFile(\"%url%\",\"%destfile%\");}"
)
if not %errorlevel% equ 0 (
  set good_download=false
)
if not exist "%destfile%" (
  set good_download=false
)
if "%good_download%"=="false" (
  echo.
  echo Download failed. Perhaps try a manual download from quakestarter.com?
  echo.
  pause
  cls
  goto :err
)
echo ... extracting ...
set good_extraction=true
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} Add-Type -A 'System.IO.Compression.FileSystem';[IO.Compression.ZipFile]::ExtractToDirectory(\"%destfile%\",\"%extractdir%\");}"
if not %errorlevel% equ 0 (
  set good_extraction=false
)
if not exist "%extractdir%" (
  set good_extraction=false
)
if "%good_extraction%"=="false" (
  echo.
  echo Extraction of the downloaded archive failed. Perhaps try a manual
  echo download from quakestarter.com?
  echo.
  pause
  cls
  goto :err
)
echo ... making a backup ...
if not exist "%manifest%" (
  echo.
  echo Failed to make a backup; this manifest file is missing:
  echo   %rootpath%%manifest%
  echo.
  echo Without a backup, auto-update will not proceed. Perhaps try a manual
  echo download from quakestarter.com?
  echo.
  pause
  cls
  goto :err
)
md "%backupdir%"
md "%backupdir%\id1"
setlocal enabledelayedexpansion
set good_backup=true
for /f "tokens=*" %%f in (%manifest%) do (
  if exist "%%f\" (
    xcopy "%%f" "%backupdir%\%%f" /s /e /c /i /r /k /q > nul
  ) else (
    set filename=%%f
    if "!filename!"=="!filename:id1\=!" (
      xcopy "%%f" "%backupdir%\" /c /i /r /k /q > nul
    ) else (
      xcopy "%%f" "%backupdir%\id1\" /c /i /r /k /q > nul
    )
  )
  if not !errorlevel! equ 0 (
    set good_backup=false
  )
)
if "%good_backup%"=="false" (
  echo.
  echo Failed to make a complete backup; without a backup, auto-update will
  echo not proceed. Perhaps try a manual download from quakestarter.com?
  echo.
  pause
  cls
  goto :err
)
endlocal
echo ... applying upgrade ...
REM create the upgrade script and hand off to it
echo @echo off>quakestarter_update.cmd
echo set rootpath=%rootpath%>>quakestarter_update.cmd
echo set destdir=%destdir%>>quakestarter_update.cmd
echo set extractdir=%extractdir%>>quakestarter_update.cmd
echo set backupdir=%backupdir%>>quakestarter_update.cmd
echo set manifest=%manifest%>>quakestarter_update.cmd
type "%scriptspath%update_kernel.txt">>quakestarter_update.cmd
start /b /i cmd /c quakestarter_update.cmd & exit


:bailout
popd
goto :eof


:checkerr
echo Unable to check for newer version of Quakestarter.
:err
rd /q /s "%destdir%" >nul 2>&1
del /q "%scriptspath%_version_current.cmd" >nul
echo.
popd
goto :eof


:failedupgrade
echo Some or all of the files in this folder (and its quakestarter subfolders)
echo may be missing:
echo   %rootpath%
echo You can find a backup of the original files in this folder:
echo   %backupdir%
echo And the intended new files are in this folder:
echo   %extractdir%\Quake
echo.
echo You can manually move the old files back into place or use the new
echo files instead. Once you've finished, delete the quakestarter_upgrade
echo folder.
echo.
pause
popd
exit /b 1
