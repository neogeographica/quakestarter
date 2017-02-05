@echo off

REM Top-level installer-picker.

:menu
cls
echo(
echo Basic setup:
echo 1: Find ^& copy pak files ^(game data^) on this computer
echo 2: Install soundtrack music files
echo(
echo Additional content:
echo 3: Episodes released in 2016
echo 4: "Modern" episodes from pre-2016
echo 5: Classic episodes
echo 6: Other highly-rated maps up thru 2016
echo(
set menu_choice=eof
set /p menu_choice=choose a number or just press Enter to exit:
echo(
goto %menu_choice%

:1
call "installers/install_pakfiles.bat"
goto :menu

:2
call "installers/install_music.bat"
goto :menu

:3
call "installers/install_2016_episodes.bat"
goto :menu

:4
call "installers/install_modern_episodes.bat"
goto :menu

:5
call "installers/install_classic_episodes.bat"
goto :menu

:6
call "installers/install_other_picks.bat"
goto :menu
