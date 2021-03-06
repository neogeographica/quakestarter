REM These are the default settings used by the Quakestarter scripts. If you
REM want to change any of these values, create another file called
REM "_quakestarter_cfg.cmd" IN THE SAME FOLDER AS QUAKESTARTER.CMD and put
REM your custom settings in that file.

REM Changing this file here is not recommended, since changes to this file
REM might get lost when upgrading to a later release of the package.


REM The name of the Quake engine executable that will be used to play when
REM launching stuff through the Quakestarter. Can be followed by any
REM arguments that should always be used. The quake_engines.txt doc in the
REM quakestarter_docs\other_stuff folder has some comments about this.
REM Note: If you change this, make sure that the value for multigame_support
REM below is also set correctly for the Quake engine of your choice!

set quake_exe=quakespasm-spiked-win64.exe


REM Whether your Quake engine of choice supports activating multiple mod
REM folders on the command line. This is required for the way the install
REM script handles some Arcane Dimensions and Copper releases. For details,
REM see the mod_requirements.txt and advanced_quakestarter_cfg.txt docs in the
REM quakestarter_docs\other_stuff folder.

set multigame_support=auto


REM This is the subfolder path (within your Quake folder) where the primary
REM mod/map zipfiles will be downloaded and cached. If you already have a
REM bunch of zips downloaded somewhere by Mark V or Quake Injector, you might
REM want to set this path to that location. Otherwise this is a nice place for
REM the zips to live:

set download_subdir=quakestarter_downloads


REM This is the subfolder path (within your Quake folder) where patch zipfiles
REM will be downloaded and cached. If your download_subdir is being shared
REM with Mark V or Quake Injector then you might want to point this to a
REM different subfolder. Otherwise it can be the same as for download_subdir.

set patch_download_subdir=quakestarter_downloads


REM Whether to delete zipfiles for mods and patches after downloading them.
REM (Does not apply to soundtrack zipfiles; see below.) If you set this to
REM false, they will take up disk space, but then you can quickly reinstall
REM something without having to download it again. You may also want to set
REM this false if you're sharing the downloads cache with Mark V or Quake
REM Injector.

set cleanup_archive=true


REM Whether to delete downloaded zipfiles for id1/hipnotic/rogue soundtracks.
REM Since the menus don't provide any option to "uninstall" (delete) the
REM id1/hipnotic/rogue gamedirs, the only way to get automated cleanup of
REM soundtrack zipfiles is to set this to true. If you set this to false then
REM these zipfiles will hang around in your patch_download_subdir folder until
REM manually deleted.

set cleanup_soundtrack_archive=true


REM How to handle the situation where a mod installs correctly but then an
REM optional (in some sense) patch for that mod fails. If rollback is true
REM then the whole mod will be uninstalled in that case.

set rollback_on_failed_patch=true


REM Sometimes releases can be removed from Quakestarter menus when a newer
REM Quakestarter release comes out -- because their rating has changed, or
REM the inclusion criteria has changed, or the release has been superceded by
REM a new version. Normally these "legacy" releases are hidden from the menus
REM if they are not currently installed, but setting force_show_legacies to
REM true will show them all.

set force_show_legacies=false


REM This last option is rarely used, but it takes a bit of explaining. Most
REM mods don't come with their own unique set of demo films for running an
REM attract-mode loop at start time. However, a few mods do. So when
REM Quakestarter installs a mod it follows these guidelines:
REM
REM  * If a mod doesn't come with its own unique demos, then don't configure a
REM    startdemos loop. We don't want to see the same initial Quake demos that
REM    we've seen a million times.
REM  * If a mod does come with its own demos, configure the startdemos loop
REM    with those unique demos.
REM 
REM If the mod begins with a map other than "start", this doesn't matter...
REM you will load directly into that map. However IF a mod has unique
REM startdemos and IF it begins with a map named "start", then this option
REM comes into play. You can set play_unique_startdemos true or false, with
REM the following results:
REM
REM   true  : Always run the startdemos loop when such a mod is launched. To
REM           start playing you will need to start a new singleplayer game
REM           from the menu (or load a savegame).
REM   false : Never run a startdemos loop; immediately load the start map
REM           and begin playing the mod.
REM
REM Note 1: The true setting will work even with Quakespasm-style engines
REM         that normally don't run the startdemos loop.
REM Note 2: The false setting may be ignored for a mod that was installed
REM         manually or using a pre-2.0 version of Quakestarter.

set play_unique_startdemos=true
