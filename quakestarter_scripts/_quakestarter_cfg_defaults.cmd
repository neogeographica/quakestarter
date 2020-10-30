REM These are the default settings used by the installer scripts. If you want
REM to change any of these values, create another file called
REM "_quakestarter_cfg.cmd" IN THE SAME FOLDER AS QUAKESTARTER.CMD and put your
REM custom settings in that file.

REM Changing this file here is not recommended, since changes to this file
REM might get lost when unzipping a later release of the package.

REM The name of the Quake engine executable that will be used to play when
REM launching stuff through the installer scripts.
set quake_exe=quakespasm-spiked-win64.exe

REM This is the subfolder path (within your Quake folder) where the primary
REM mod/map zipfiles will be downloaded and cached. If you already have a
REM bunch of zips downloaded somewhere by Mark V or Quake Injector, you might
REM want to set this path to that location. Otherwise this is a nice place for
REM the zips to live:
set download_subdir=quakestarter_downloads

REM This is the subfolder path (within your Quake folder) where patch zipfiles
REM will be downloaded and cached. If your download_subdir is being shared
REM with Mark V or Quake Injector then you probably want to point this to a
REM different subfolder. Otherwise it can be the same as for download_subdir.
set patch_download_subdir=quakestarter_downloads

REM Whether to delete zipfiles after downloading them. If you set this to
REM false, they will take up disk space, but then you can quickly reinstall
REM something without having to download it again. You may also want to set
REM this false if you're sharing the downloads cache with Mark V or Quake
REM Injector.
set cleanup_archive=true

REM Whether your Quake engine of choice supports multiple "-game" arguments
REM on the command line. This is required for the way the install script
REM handles some Arcane Dimensions and Copper releases. See the
REM basic/3_configuration.txt readme file for more details.
set multigame_support=true

REM How to handle the situation where a mod installs correctly but then an
REM optional (in some sense) patch for that mod fails. If rollback is true
REM then the whole mod will be uninstalled in that case.
set rollback_on_failed_patch=true
