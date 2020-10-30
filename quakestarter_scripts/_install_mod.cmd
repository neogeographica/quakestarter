REM Helper "subroutine" script to install a mod.
REM Used by _handle_mod_choice.cmd and _install_patch.cmd.

REM On the commandline, the url and gamedir args are required.

REM The caller is also required to set the basedir and download_subdir
REM variables.

setlocal

REM remember dir where this script lives
set scriptsdir=%~dp0

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
if "%download_subdir%"=="" (
  echo The required variable download_subdir is unset.
  echo FYI:
  echo Usually you wouldn't run this file directly; it's used by other
  echo batch files. download_subdir is set in your installer config.
  goto :eof
)
set url=%~1
set destfile=%basedir%\%download_subdir%\%~nx1
set gamedir=%~2
if "%gamedir%"=="%~n1" (
  if not "%less_chatty_install%"=="true" (
    echo Installing mod "%gamedir%"...
  )
) else (
  if not "%less_chatty_install%"=="true" (
    echo Installing mod "%~n1" as "%gamedir%"...
  )
)

REM sanity checks
if not exist "%basedir%\id1\pak0.pak" (
  echo Couldn't find "id1\pak0.pak".
  echo You could use the first option of the main installer to look for pak
  echo files on this computer.
  echo.
  goto :eof
)
if not exist "%basedir%\id1\pak1.pak" (
  echo Couldn't find "id1\pak1.pak".
  echo You could use the first option of the main installer to look for pak
  echo files on this computer.
  echo.
  goto :eof
)
if exist "%basedir%\%gamedir%" (
  echo The "%gamedir%" folder already exists.
  echo.
  goto :eof
)

REM download the package
if not exist "%destfile%" (
  echo ... downloading ...
  set good_download=true
  if not exist "%basedir%\%download_subdir%" (
    md "%basedir%\%download_subdir%"
  )
  if "%hascurl%"=="true" (
    curl -f -# -o "%destfile%" "%url%"
  ) else (
    powershell.exe -nologo -noprofile -command "&{trap{exit 1;} (new-object System.Net.WebClient).DownloadFile(\"%url%\",\"%destfile%\");}"
  )
  if not %errorlevel% equ 0 (
    set good_download=false
  )
  if not exist "%destfile%" (
    set good_download=false
  )
  if "%good_download%"=="false" (
    del /q "%destfile%" >nul 2>&1
    echo Download failed. This might be a temporary issue with the server;
    echo if you try again the download may succeed.
    echo.
    goto :eof
  )
)

REM install the mod...

REM first, unzip to the gamedir
echo ... extracting ...
set good_extraction=true
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} Add-Type -A 'System.IO.Compression.FileSystem';[IO.Compression.ZipFile]::ExtractToDirectory(\"%destfile%\",\"%basedir%\%gamedir%\");}"
if not %errorlevel% equ 0 (
  set good_extraction=false
)
if not exist "%basedir%\%gamedir%" (
  set good_extraction=false
)
if "%good_extraction%"=="false" (
  rd /q /s "%basedir%\%gamedir%" >nul 2>&1
  echo Extraction of the downloaded archive failed. You can have a look at the
  echo archive file here if you want to investigate:
  echo   %destfile%
  echo.
  goto :eof
)

REM remove the zipfile now if config says to
if "%cleanup_archive%"=="true" (
  del /q "%destfile%" >nul 2>&1
)

REM now get in that dir and clean it up
echo ... organizing ...
pushd "%basedir%\%gamedir%"
:organizedirs
REM Delete any configs and old custom-engine stuff.
del /q *.bat *.cmd *.exe *.dll config.cfg >nul 2>&1
REM If pak or progs is here, assume everything is already organized and we're
REM done.
dir *.pak *progs.dat /a-d >nul 2>&1
if %errorlevel% equ 0 goto :dirsorganized
REM Similarly assume things are good if there's zero or more than one
REM subdirectories.
set dircount=0
for /d %%d in (*) do (
  set /a dircount+=1
)
if not %dircount%==1 goto :dirsorganized
REM OK we have one subdirectory... let's grab its name.
set dirname=
for /d %%d in (*) do (
  set dirname=%%d
)
REM Check to see if this is a "known by Quake" directory name.
set dirknown=false
for %%k in (gfx locs maps music particles progs skins sound textures) do (
  if /i "%dirname%"=="%%k" (
    set dirknown=true
  )
)
if "%dirknown%"=="true" goto :dirsorganized
REM If we reach this point the directory is probably packaging cruft. Move its
REM contents up and keep looping.
move "%dirname%\*" . >nul
for /d %%s in ("%dirname%\*") do (
  move "%%s" . >nul
)
if not %errorlevel% equ 0 (
  echo Failed in organizing the extracted archive contents.
  echo.
  popd
  rd /q /s "%basedir%\%gamedir%" >nul
  goto :eof
)
rd /q /s "%dirname%" >nul 2>&1
goto :organizedirs
:dirsorganized
REM If there are loose bsp/ent/lit/loc/map files in top level, put them in
REM their place. It is kind of weird for this to happen if there is a maps or
REM locs directory already, but if so I guess we'll just move them there.
dir *.bsp *.ent *.lit *.map *.rmf *.jmf *.vmf /a-d >nul 2>&1
if %errorlevel% equ 0 (
  if not exist maps (
    md maps
  )
  move *.bsp maps\ >nul 2>&1
  move *.ent maps\ >nul 2>&1
  move *.lit maps\ >nul 2>&1
  move *.map maps\ >nul 2>&1
  move *.rmf maps\ >nul 2>&1
  move *.jmf maps\ >nul 2>&1
  move *.vmf maps\ >nul 2>&1
)
dir *.loc /a-d >nul 2>&1
if %errorlevel% equ 0 (
  if not exist locs (
    md locs
  )
  move *.loc locs\ >nul 2>&1
)
popd

REM nuke the mod's autoexec.cfg if necessary
if exist "%basedir%\%gamedir%\autoexec.cfg" (
  echo Archiving mod's "autoexec.cfg" as "autoexec.cfg.orig".
  move "%basedir%\%gamedir%\autoexec.cfg" "%basedir%\%gamedir%\autoexec.cfg.orig" >nul
)

REM add custom files if any
REM (this only handles single files, not nested folders)
if exist "%scriptsdir%\mod_extras\%gamedir%" (
  if not exist "%basedir%\%gamedir%" (
    md "%basedir%\%gamedir%"
  )
  echo Adding some files to the mod folder:
  for %%f in ("%scriptsdir%\mod_extras\%gamedir%\*") do (
    echo   %%~nxf
    copy /y "%%f" "%basedir%\%gamedir%" > nul
  )
)

if not "%less_chatty_install%"=="true" (
  echo Installed.
)

echo.
