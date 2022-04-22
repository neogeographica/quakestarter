@echo off

REM Top-level installer-picker.

setlocal

REM remember dir where this script lives
set mainpath=%~dp0
set scriptspath=%mainpath%quakestarter_scripts\

REM see if .Net/PowerShell are ok, and check for curl
powershell.exe -nologo -noprofile -command "&{trap{exit 1;} Add-Type -A 'System.IO.Compression.FileSystem';}" >nul 2>&1
if not %errorlevel% equ 0 (
  echo.
  echo The installed version of the .Net Framework ^(and/or of PowerShell^) must
  echo be updated. See the .Net Dependency chapter in the Other Topics part of the
  echo docs for more details.
  echo.
  pause
  goto :eof
)
curl -V >nul 2>&1
if %errorlevel% equ 0 (
  set hascurl=true
) else (
  set hascurl=false
)

REM check for legacy docs
set legacy_docs=false
if exist "%mainpath%quakestarter_readme.txt" (
  set legacy_docs=true
)
if exist "%mainpath%quakestarter_docs" (
  set legacy_docs=true
)
if "%legacy_docs%"=="true" (
  echo.
  echo Old documentation ^(quakestarter_readme.txt and/or the quakestarter_docs
  echo folder^) from a previous Quakestarter release still exists in this folder.
  echo Once you press a key to continue, that old documentation will be deleted.
  echo From now on, you can access the Quakestarter documentation by opening
  echo quakestarter_readme.html in a web browser.
  echo.
  pause
  del /q "%mainpath%quakestarter_readme.txt" >nul
  rd /s /q "%mainpath%quakestarter_docs" >nul
)

:menu

REM re-read config each time we come back to menu in case it was edited
call "%scriptspath%_quakestarter_cfg_defaults.cmd"
if exist "%scriptspath%_quakestarter_cfg.cmd" (
  echo.
  echo A _quakestarter_cfg.cmd file was found in the quakestarter_scripts folder.
  echo That's not the right place for it! The _quakestarter_cfg_defaults.cmd file
  echo does live in the quakestarter_scripts folder, but if you want to define
  echo custom settings then your own personalized _quakestarter_cfg.cmd file must
  echo be in the same folder as quakestarter.cmd. I.e. you should put it at:
  echo   %mainpath%_quakestarter_cfg.cmd
  echo.
  pause
  goto :eof
)
if exist "%mainpath%_quakestarter_cfg.cmd" (
  call "%mainpath%_quakestarter_cfg.cmd"
)

REM see if we want to show the "legacies" menu
call "%scriptspath%legacies.cmd" check

cls
echo.
echo Basic setup:
echo  1: Find ^& copy pak files ^(game data^) on this computer
echo  2: Find soundtrack music files on this computer or download
echo  3: Test-launch unmodified Quake
echo.
echo Additional episodes/hubs:
echo  4: The New Hotness ^(2020-2022; ratings in flux^)
echo  5: Post-AD ^(after the first Arcane Dimensions release; 2016-2019^)
echo  6: Modern ^(after Nehahra; 2000-2015^)
echo  7: Classic
echo.
echo Other highly-rated releases:
echo  8: The New Hotness ^(2020-2022; ratings in flux^)
echo  9: The Age of Jams ^(2014-2019^)
echo 10: Post-Quoth ^(after the first Quoth release; 2006-2013^)
echo 11: Classic
echo.
if "%show_legacies_menu%"=="true" (
  echo Select 99 to manage "legacy" releases that were in the installer menus of
  echo previous versions of Quakestarter but are no longer in this release.
  echo.
)
echo Select q to open the Quakestarter documentation.
echo.
set menu_choice=:eof
set /p menu_choice=enter your choice or just press Enter to exit:
echo.
goto %menu_choice%

:1
call "%scriptspath%pakfiles.cmd"
goto :menu

:2
call "%scriptspath%soundtrack.cmd"
goto :menu

:3
call "%scriptspath%testlaunch.cmd"
goto :menu

:4
call "%scriptspath%episodes_latest.cmd"
goto :menu

:5
call "%scriptspath%episodes_post_ad.cmd"
goto :menu

:6
call "%scriptspath%episodes_modern.cmd"
goto :menu

:7
call "%scriptspath%episodes_classic.cmd"
goto :menu

:8
call "%scriptspath%other_latest.cmd"
goto :menu

:9
call "%scriptspath%other_aoj.cmd"
goto :menu

:10
call "%scriptspath%other_post_quoth.cmd"
goto :menu

:11
call "%scriptspath%other_classic.cmd"
goto :menu

:99
if not "%show_legacies_menu%"=="true" (
  goto :eof
)
call "%scriptspath%legacies.cmd"
goto :menu

:q
:Q
pushd "%mainpath%"
start /b quakestarter_readme.html
popd
goto :menu
