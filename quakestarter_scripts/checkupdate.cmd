@echo off

REM Check for Quakestarter updates.

REM On the commandline, the rootpath arg is required.

REM An optional arg can be specified through this variables:
REM   zipfile

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

set destdir=quakestarter_update
set extractdir=%destdir%\unpacked
set backupdir=%destdir%\backup
set e_desc=quakestarter_scripts\engines_descriptor.txt
set e_manifest=quakestarter_scripts\internal_engines_manifest.txt
set q_manifest=quakestarter_scripts\internal_qs_manifest.txt

REM if the quakestarter_update directory exists, a previous upgrade failed
if exist "%destdir%" (
  goto :failedupgrade
)

REM if an already-downloaded file was provided, use that
if not "%zipfile%"=="" (
  goto :notify
)

REM get the URL for the current (i.e. most recent) version's downloads page
REM if we haven't yet done that today
forfiles /p "%scriptspath:~0,-1%" /m _version_current.cmd /d 0 >nul 2>&1
if %errorlevel% equ 0 (
  goto :skipgetcurrent
)
echo|set /p="set version_current="> "%scriptspath%_version_current.cmd"
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} $progressPreference='silentlyContinue';[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls -bor [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12;(Invoke-WebRequest -MaximumRedirection 0 -Uri \"%update_location%\").Headers.Location;}" 2>nul >> "%scriptspath%_version_current.cmd"
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
  goto :silentbailout
)

REM get the current version's download URL if we don't have it yet
if not "%version_current_download%"=="" (
  goto :notify
)
echo|set /p="set version_current_download=">> "%scriptspath%_version_current.cmd"
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} $progressPreference='silentlyContinue';[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls -bor [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12;(Invoke-WebRequest -Uri \"%version_current%\").Links|foreach{[Uri]::new([Uri]\"%version_current%\",$_.href).AbsoluteUri}|Select-String -Pattern \"/quakestarter-[0-9][^^/]*zip$\"|foreach{$_.Line};}" 2>nul >> "%scriptspath%_version_current.cmd"
if not %errorlevel% equ 0 (
  goto :checkerr
)
call "%scriptspath%_version_current.cmd"
if "%version_current_download%"=="" (
  goto :checkerr
)

REM OK let's rock and roll...

:notify
echo.
if "%zipfile%"=="" (
  echo A newer version of Quakestarter is available!
) else (
  echo Will apply Quakestarter update from:
  echo   %zipfile%
)
if not exist "%e_manifest%" (
  set bad_manifest=%e_manifest%
  goto :nomanifest
)
if not exist "%q_manifest%" (
  set bad_manifest=%q_manifest%
  goto :nomanifest
)
if not "%zipfile%"=="" (
  set destfile=%zipfile%
  goto :extract
)

:readmechoice
echo.
set /p cl_choice=Read the update notes? ([y]/n):
if "%cl_choice%"=="n" goto :dlchoice
if "%cl_choice%"=="N" goto :dlchoice
start /b %changelog_location%
echo Sent update notes to web browser...

:dlchoice
echo.
set /p dl_choice=Download and install this update now? ([y]/n):
if "%dl_choice%"=="n" goto :bailout
if "%dl_choice%"=="N" goto :bailout

:enginechoice
echo.
call :set_fileisempty "%e_desc%"
if "%fileisempty%"=="false" (
  echo Quakestarter is currently managing some Quake engine files in this folder:
  type "%e_desc%"
  echo.
  echo.
  echo If you download the Quake engines included in this update, those current
  echo engine files will be replaced with the new downloaded ones.
) else (
  echo Quakestarter is NOT currently managing any Quake engine files in this folder.
  echo If you download the Quake engines included in this update, the downloaded
  echo engine files will be placed in this folder and Quakestarter will manage them
  echo in future updates.
)
echo.
set /p e_choice=So... download the Quake engines in this update? ([y]/n):
if "%e_choice%"=="n" goto :noengine
if "%e_choice%"=="N" goto :noengine
set url=%version_current_download%
goto :download
:noengine
set url=%version_current_download:/quakestarter-=/quakestarter-noengine-%

:download
echo.
echo ... downloading ...
for %%a in (%url%) do (
  set zipname=%%~nxa
)
set destfile=%destdir%\%zipname%
md "%destdir%"
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
  echo Download failed. Perhaps try a manual download of the latest version
  echo from quakestarter.com?
  echo.
  pause
  cls
  goto :err
)

:extract
echo.
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
  echo Failed to unpack the update archive. Perhaps try again with a manual download
  echo of the latest version from quakestarter.com?
  echo.
  pause
  cls
  goto :err
)
set update_versionfile=%extractdir%\Quake\quakestarter_scripts\_version_installed_number.cmd
if not exist "%update_versionfile%" (
  echo.
  echo The unpacked archive files don't include a Quakestarter version marker.
  echo Weird! Perhaps try again with a manual download of the latest version from
  echo quakestarter.com?
  echo.
  pause
  cls
  goto :err
)
call "%scriptspath%_version_installed_number.cmd"
set installed_version=%version_installed_number%
call "%update_versionfile%"
set current_version=%version_installed_number%
set version_installed_number=%installed_version%
echo|set /p="set version_check_ok="> "%destdir%\_version_check_ok.cmd"
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} [System.Version]\"%current_version%\" -gt [System.Version]\"%installed_version%\";}" 2>nul >> "%destdir%\_version_check_ok.cmd"
if not %errorlevel% equ 0 (
  goto :versioncheckerr
)
if not exist "%destdir%\_version_check_ok.cmd" (
  goto :versioncheckerr
)
call "%destdir%\_version_check_ok.cmd"
if not "%version_check_ok%"=="True" (
  echo.
  echo The update version %current_version% doesn't seem to be greater than the installed
  echo version %installed_version%. We don't want to do something unfortunate here, so the
  echo autoupdate will not proceed. Perhaps try again with a manual download of the
  echo latest version from quakestarter.com?
  echo.
  pause
  cls
  goto :err
)

:enginehandling
set engine_handling=ERASE
set update_e_desc=%extractdir%\Quake\quakestarter_scripts\engines_descriptor.txt
call :set_fileisempty "%update_e_desc%"
if "%fileisempty%"=="false" (
  goto :backup
)
call :set_fileisempty "%e_desc%"
if "%fileisempty%"=="true" (
  goto :backup
)
set bad_choice=false
:choiceloop
cls
echo.
echo Since your chosen update doesn't include the engine files, you have a few
echo options about how to treat the existing files for these currently managed
echo Quake engines:
type "%e_desc%"
echo.
echo.
echo KEEP those engines and Quakestarter will still manage them in future updates
echo DETACH those engine's files from Quakestarter management
echo ERASE those engine's files
echo.
if "%bad_choice%"=="true" (
  echo oops! "%engine_handling%" isn't a valid choice...
  echo.
)
set bad_choice=false
set engine_handling=?
set /p engine_handling=Enter KEEP, DETACH, ERASE, or ? to see docs about updating:
if "%engine_handling%"=="?" (
  start /b quakestarter_html/other_stuff/upgrading_quakestarter.html
  goto :choiceloop
)
if "%engine_handling%"=="KEEP" (
  goto :backup
)
if "%engine_handling%"=="DETACH" (
  goto :backup
)
if "%engine_handling%"=="ERASE" (
  goto :backup
)
set bad_choice=true
goto :choiceloop

:backup
echo.
echo ... making a backup ...
md "%backupdir%"
md "%backupdir%\id1"
setlocal enabledelayedexpansion
set good_backup=true
for /f "tokens=*" %%f in (%q_manifest% %e_manifest%) do (
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
  echo Failed to make a complete backup; without a backup, autoupdate will not
  echo proceed. Perhaps try again?
  echo.
  pause
  cls
  goto :err
)
endlocal

:update
echo.
echo ... applying update ...
REM create the update script and hand off to it
set updater=%LocalAppData%\Temp\quakestarter_update.cmd
echo @echo off>"%updater%"
echo set rootpath=%rootpath%>>"%updater%"
echo set destdir=%destdir%>>"%updater%"
echo set extractdir=%extractdir%>>"%updater%"
echo set backupdir=%backupdir%>>"%updater%"
echo set engine_handling=%engine_handling%>>"%updater%"
type "%scriptspath%update_kernel.txt">>"%updater%"
start /b /i cmd /c "%updater%" & exit

:set_fileisempty
if "%~z1"=="0" (
  set fileisempty=true
) else (
  set fileisempty=false
)
goto :eof

:failedupgrade
echo.
echo It looks like a previous update failed to complete. Some or all of the files
echo in this folder ^(and its quakestarter subfolders^) may be missing or wrong:
echo   %rootpath%
echo You can find a backup of the original files in this folder:
echo   %backupdir%
echo And the intended new files are in this folder:
echo   %extractdir%\Quake
echo.
echo You can manually move the old files back into place or use the new files
echo instead ^(see the Quakestarter docs about manual update^). Once you've
echo finished, delete the quakestarter_update folder.
echo.
pause
popd
exit /b 1

:bailout
echo.
echo Checking for updates will be disabled until tomorrow. If you want to
echo permanently disable autoupdate, see the Updating Quakestarter chapter ^(under
echo Other Topics^) in the Quakestarter docs.
echo.
echo set version_current=%version_installed%> "%scriptspath%_version_current.cmd"
pause
cls
:silentbailout
popd
goto :eof

:nomanifest
echo.
echo This manifest file is missing from the current Quakestarter files:
echo   %rootpath%%bad_manifest%
echo.
echo Without the manifests, we can't make a backup of current files, and
echo autoupdate will not proceed. Perhaps try a manual update ^(see the
echo Quakestarter docs for that^) using the latest version from quakestarter.com?
echo.
pause
cls
popd
goto :eof

:err
rd /q /s "%destdir%" >nul 2>&1
del /q "%scriptspath%_version_current.cmd" >nul
popd
goto :eof

:checkerr
echo.
echo Unable to check for newer version of Quakestarter.
echo.
goto :err

:versioncheckerr
echo.
echo Something went wrong when trying to compare the version of the Quakestarter
echo update archive to the currently installed version. Weird! Perhaps try again
echo with a manual download of the latest version from quakestarter.com?
echo.
pause
cls
goto :err
