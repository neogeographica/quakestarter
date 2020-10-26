REM These are the default settings used by the installer scripts. If you want
REM to change any of these values, create another file called _install_cfg.cmd
REM and put your custom settings in there.

REM Changing this file here is not recommended, since changes to this file
REM might get lost when unzipping a later release of the package.

REM The name of the Quake engine executable that will be used to play when
REM launching stuff through the installer scripts.
set quake_exe=quakespasm-spiked-win64.exe

REM This is the subdirectory (within your Quake folder) where the primary
REM mod/map zipfiles will be downloaded and cached. If you already have a
REM bunch of zips downloaded somewhere by Mark V or Quake Injector, you might
REM want to set this path to that location. Otherwise this is a nice place for
REM the zips to live:
set download_subdir=installers\downloads_cache

REM This is the subdirectory (within your Quake folder) where patch zipfiles
REM will be downloaded and cached. If your download_subdir is being shared
REM with Mark V or Quake Injector then you probably want to point this to a
REM different directory. Otherwise it can be the same as download_subdir.
set patch_download_subdir=installers\downloads_cache

REM Whether your Quake engine of choice supports multiple "-game" arguments
REM on the command line. This is required for the way the install script
REM handles some Arcane Dimensions and Copper releases. See the
REM basic/3_configuration.txt readme file for more details.
set multigame_support=true

REM How to handle the situation where a mod installs correctly but then an
REM optional (in some sense) patch for that mod fails. If rollback is true
REM then the whole mod will be uninstalled in that case.
set rollback_on_failed_patch=true
