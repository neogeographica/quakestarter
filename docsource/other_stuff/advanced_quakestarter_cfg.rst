Advanced Configuration
======================

Quakestarter configuration files
--------------------------------

The file "_quakestarter_cfg_defaults.cmd" in the "quakestarter_scripts" folder describes some configurable behaviors for Quakestarter, and their default settings.

If you want to change any of these behaviors, you can make changes to the file "_quakestarter_cfg.cmd" that is in the same folder as the main Quakestarter script. (When you run Quakestarter, this file will be created if it does not yet exist.) In this file you can set any of the options that you wish to change.

For example, in "_quakestarter_cfg_defaults.cmd" the following line specifies that the downloaded zipfile for an addon will be auto-deleted after it is installed::

    set cleanup_archive=true

Let's say you would rather not do that, so that you can quickly re-install previously uninstalled addons without needing to download them again. To make Quakestarter keep those zipfiles around, you would put this line in your "_quakestarter_cfg.cmd" file::

    set cleanup_archive=false

You should always handle any preferences like this through your own "_quakestarter_cfg.cmd" file, *not* by modifying the "_quakestarter_cfg_defaults.cmd" file. That way, your preferences won't get overwritten when you take in the files for some future release of Quakestarter.

The "_quakestarter_cfg_defaults.cmd" file describes these settings in detail, so most of them don't need extra description here.


Download behavior
-----------------

Quakestarter will use "curl.exe" to download zipfiles, if that utility is in a directory included in your Windows PATH environment variable. This will be the case in current versions of Windows 10 (or later).

If Quakestarter can't find that curl utility, it will use a .Net assembly to do the download instead. This should work fine. One downside though is that this approach will not show a progress bar during the download.

If you don't have "curl.exe" in one of your PATH directories and you really do want that progress bar -- or if for some reason the .Net assembly isn't working and you want to try using curl instead -- then you could install curl yourself. You can get a perfectly good "curl.exe" from `its website`_. Then you can either place that utility into some directory that is already in your PATH, or edit your PATH value to include the directory where you put curl.

(How to edit system environment variables like PATH is outside the scope of this chapter, but is well-covered in Google results.)


.. _its website: https://curl.se/windows/


Engine choice
-------------

If you want Quakestarter to launch a particular Quake engine of your choice -- other than the options of vkQuake and Ironwail which are usually bundled with Quakestarter -- you can certainly do that! Let's talk about what other Quake engines you might use, describe the easy/common way to install them, and then finally cover a few power-user things.

Which engine
~~~~~~~~~~~~

The :doc:`Quake Engines<quake_engines>` chapter talks a bit about the variety of Quake-playing programs out there. vkQuake and Ironwail are great general-purpose singleplayer Quake engines, but they might not work on your computer for some reason. Or some other engine may have that one special feature that makes it a must-have for you.

You can use other Quake engines through Quakestarter, but keep in mind that for other Quake engines the following things are *not* always guaranteed:

* that your choice of Quake engine will be able to properly run every selection from the Quakestarter menus
* that your choice of Quake engine will be able to play soundtrack files
* that all the settings in the example autoexec.cfg will work for your choice of Quake engine, or have the indicated defaults
* that existing savegames will work for your choice of Quake engine

vkQuake and Ironwail are safe engine choices, and Quakespasm-Spiked usually is too. The original Quakespasm engine is also widely compatible, although since the original Quakespasm lacks multigame support (:ref:`see below<other_stuff/advanced_quakestarter_cfg:multigame support>`) there will be a small number of Quakestarter items that Quakespasm cannot launch.

Beyond those choices, it's more on your shoulders to look into compatibility issues and be aware that something might go wrong. Even some Quake engine that is a perfectly fine piece of software engineering may have troubles running a particular map release if the map was never tested against that engine, and FWIW most releases are tested against a Quakespasm-family engine. A map may even malfunction in ways that are not immediately apparent if you haven't played it before (e.g. missing monsters, lighting errors).

That said, there are many players who are perfectly happy with their preference for a specialty engine like FTE or DarkPlaces, willing to do a bit of troubleshooting if necessary in order to benefit from unique features that those engines provide. The only inarguable "bad choice" for a Quake engine, when it comes to the purpose of playing custom addons, would be a multiplayer-focused engine like ezQuake.

Installing an engine - easy mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to use some other Quake engine, then the files that make up that engine need to be placed in the Quake folder along with Quakestarter.

If you're interested in doing this, it's highly recommended to start with a "noengine" installation of Quakestarter. That way you won't have to worry about dealing with the vkQuake/Ironwail files from the normal Quakestarter bundle, and you also won't be in danger of a Quakestarter update doing anything unexpected to the files of your own Quake engine of choice.

This "easy mode" section will assume that you are working with a "noengine" Quakestarter installation.

If you're intending to manually place multiple Quake engine choices into this Quake folder, be careful about the files from one engine overwriting the files from another. For Quakespasm-family engines, they use the same library files which are often either identical among the various engine releases or differing only by minor version. In that case you can often get away with just keeping the latest version of each such library file in the Quake folder, along with the various engine executables. But this is definitely a situation where you need to be careful about what you are doing. Engines that use notably different versions of the same library file cannot be kept in the same folder together.

Once you have your desired Quake engine(s) installed into this Quake folder, you can set a new quake_exe value in your "_quakestarter_cfg.cmd" file to indicate the Quake program that should be launched by Quakestarter.

The easiest way to do this is by using the third item in the main Quakestarter menu. That will give you a selection of executables to choose from, and then Quakestarter will handle making the necessary changes to "_quakestarter_cfg.cmd" to honor your choice.

However you can also just manually edit "_quakestarter_cfg.cmd" to make the change yourself, if you want to. One reason you might want to do this is if you need to add some command-line arguments that should always be used whenever launching your Quake program. For example, if you are launching qbism Super8, its default "heapsize" value is quite low and on modern systems there's no downside to always cranking it up, so that more maps will work correctly. So you could choose to specify this in your "_quakestarter_cfg.cmd"::

    set quake_exe=qbismS8.exe -heapsize 256000

**Note:** If you use the Quakestarter menu item to change your Quake engine executable, then any extra arguments like those will be discarded.

Installing an engine - hard mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Let's say you *don't* have a "noengine" installation, but you still want to install some other Quake engines.

If you are OK with transforming your current Quakestarter installation into a "noengine" form, there's a couple of ways to do that. One way to do this is to get the "noengine" bundle for the same version of Quakestarter and unzip it over top of your current Quakestarter files. Another way is to use Quakestarter's update process to install a "noengine" variant of a newer version of Quakestarter, choosing to "detach" or "erase" your current engine files as part of that process. These things are described in the chapter :doc:`Updating Quakestarter<upgrading_quakestarter>`. Once you've achieved a "noengine" setup, you can go back to the "easy mode" process described above.

But OK, maybe you want to keep the vkQuake/Ironwail files and keep them "managed" by Quakestarter, but you also want to add some new engine...

If this new engine is a single executable, that is still pretty easy. You can just drop its exe into the Quake folder and it will now be available as a Quakestarter engine choice.

If this new engine is made up of multiple files, that is trickier. If those files overlap with any of the vkQuake/Ironwail files, they can be affected when Quakestarter updates. And even if they don't currently overlap, conceivably they still might be affected by some future Quakestarter update in which vkQuake/Ironwail use different library files. This is less of a "power user" situation and more of a "don't do this" situation, generally speaking. But... do what you like! Just be aware of what happens to the managed vkQuake/Ironwail files :doc:`when Quakestarter is updated<upgrading_quakestarter>`.

FYI if you have vkQuake/Ironwail files that were installed by Quakestarter, those files will be listed in "engines_manifest.txt".


Multigame support
-----------------

As mentioned in the :doc:`Mod Folders<../maps_and_mods/mod_folders>` chapter (under Maps and Mods), Quakestarter has reasons for installing each addon into its own folder.

For addons that only build on the original Quake campaign content, that's simple enough to deal with. For addons that depend on the official missionpacks, Quake has always supported command-line options for expressing those dependencies (i.e. "-hipnotic" or "-rogue" for missionpack 1 or 2 respectively). And for addons that build on the Quoth mod, modern Quake engines have long supported the "-quoth" argument to express that dependency.

For addons that build on mods other than Quoth... it's not always been quite as easy to represent that situation. Fortunately, modern Quake engines like vkQuake, Ironwail, Quakespasm-Spiked, FTE, DarkPlaces, and qbism Super8 support activating a list of mod folders rather than just one, with each folder in the list building on the previous. The :ref:`"Mod dependencies"<other_stuff/mod_requirements:mod dependencies>` section of the Mod Requirements chapter goes into more detail about how this feature is used.

Quakestarter relies on this feature to support installing and launching addons that depend on the Arcane Dimensions or Copper mods. (This doesn't include mods that carry their own copy of the AD or Copper mod; it means simple map releases that are meant to be played with AD or Copper.)

By default Quakestarter will try to automatically figure out whether your Quake engine supports this feature (by looking at the value of quake_exe), and determine what the correct commandline syntax is for invoking it. Hopefully this will work for you! It should work for all of the Quake engines mentioned above or elsewhere in these docs.

But if for some reason this auto-detection is making the wrong choice, you can force the behavior by setting a value for multigame_support in your "_quakestarter_cfg.cmd" file. Possible values are described below.

The default auto-detect behavior (in "_quakestarter_cfg_defaults.cmd") is set like so::

    set multigame_support=auto

To forcibly declare that your Quake engine does *not* support multiple mod folders, regardless of what its program name looks like, you can set this value instead, in your in your "_quakestarter_cfg.cmd" file::

    set multigame_support=false

Or to declare that your Quake engine *does* support multiple mod folders, and that it uses the same syntax as Quakespasm-Spiked/vkQuake/Ironwail/FTE/DarkPlaces, you can set this value::

    set multigame_support=true

Finally, you can choose to use the multigame_support value to explicitly define the command-line switches that your Quake engine uses for this feature (omitting the leading dashes). The value should be composed of the switch for the base mod and the switch for the build-on mod, separated by a semicolon. For example if you needed to force the syntax that qbism Super8 uses, you could declare this::

    set multigame_support=game2;game

That last example would result in the following command line for running the "udob_v1_1" release based on Copper::

    my_quake_program.exe -game2 copper_v1_17 -game udob_v1_1 +map start
