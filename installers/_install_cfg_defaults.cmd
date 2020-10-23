REM These are the default settings used by the installer scripts. If you want
REM to change any of these values, create another file called _install_cfg.cmd
REM and put your custom settings in there.

REM Changing this file here is not recommended, since changes to this file
REM might get lost when unzipping a later release of the package.

REM The name of the Quake engine executable that will be used to play when
REM launching stuff through the installer scripts.
set quake_exe=quakespasm-spiked-win64.exe

REM This is the subdirectory (within your Quake folder) where zipfiles will be
REM downloaded and cached. If you already have a bunch of zips downloaded
REM somewhere by Mark V or Quake Injector, you might want to set this path
REM to point there. Otherwise this is a nice place for them to live:
set download_subdir=installers\downloads_cache

REM Whether your Quake engine of choice supports multiple "-game" arguments
REM on the command line. This is required for the way the install script
REM handles some Arcane Dimensions and Copper releases. See the
REM basic/3_configuration.txt readme file for more details.
set multigame_support=true

REM How to handle the situation where a mod installs correctly but then an
REM optional (in some sense) patch for that mod fails. If rollback is true
REM then the whole mod will be uninstalled in that case.
set rollback_on_failed_patch=true
