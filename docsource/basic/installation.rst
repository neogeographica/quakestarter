Installation
============

Quakestarter installation
-------------------------

The top-level "Quake" folder for this package is meant to be usable as the basis for a new, fresh Quake installation. Once the "Game data" section below has been taken care of, it will be completely playable. If you're going with this approach, you can :ref:`skip the remainder of this section<basic/installation:quake engine>`.

Another option however is to take the folders and files from inside this "Quake" folder and move them into some existing Quake installation that you have. If that's an installation of original Quake files such as you would get from Steam or GOG, this will work fine. (Note that this should be an installation of the original Quake, not the "enhanced" Quake rerelease.)

If the existing Quake installation already contains an older version of Quakestarter, please see the the :doc:`Updating Quakestarter<../other_stuff/upgrading_quakestarter>` chapter (under Other Topics).

If you are moving these items into some other already-customized Quake installation that contains a modern Quake engine, then you might want to consider using the "noengine" version of this bundle if you aren't already doing that. Otherwise the engine files bundled in this package can overwrite and perhaps conflict with existing files in your Quake directory. One thing to note is that the "engines_manifest.txt" file lists all of the vkQuake and Ironwail files in this package, which is helpful if you need to discard them. (If you don't have "engines_manifest.txt", then you are using the "noengine" bundle already.)


Quake engine
------------

A "Quake engine" is a program for playing Quake, replacing the original programs like WinQuake and GLQuake. The :doc:`Quake Engines<../other_stuff/quake_engines>` chapter (under Other Topics) digs into this idea a bit more if you're curious.

If you're using the normal Quakestarter bundle, it already includes vkQuake and Ironwail as engine options, which you can switch between by using the third menu item of the main Quakestarter menu. So you don't have anything else to do here & can :ref:`skip to the next section<basic/installation:.net framework>`!

However if you decided to use the "noengine" bundle, you need to provide the Quake engine that Quakestarter will launch.

By default Quakestarter is configured to use vkQuake, specifically "vkQuake.exe". So if that's what you have or plan to install, you're good to go.

If you instead want Quakestarter to launch some *other* program for playing Quake, you'll need to configure it to do so. You can use that third Quakestarter menu item to choose your preferred engine executable. If you intend to use something other than vkQuake or Ironwail there may be some other considerations/configurations you need to be aware of; the :doc:`Advanced Configuration<../other_stuff/advanced_quakestarter_cfg>` chapter (under Other Topics) goes into more detail about that.


.Net Framework
--------------

The Quakestarter script and the Simple Quake Launcher 2 program ("SQLauncher2.exe") bundled in this package have a requirement for Microsoft .Net Framework 4.5 or later. When you launch Quakestarter it will explicitly check for this dependency and show you an error message if there is a problem.

If you are on Windows 8 or Windows 10 or later, this shouldn't be a problem for you, especially if your OS is up-to-date. If you are on Windows 7 though, you'll probably get the error message from Quakestarter. The :doc:`.Net Dependency<../other_stuff/dot_net_version_dependency>` chapter (under Other Topics) describes how to get the necessary Windows components updated in that case.

If you're on Windows Vista (???) then likely you're in the same boat as Windows 7 users. However, I no longer test on Vista.

If you're on Windows XP you're out of luck. In that case you might want to look into trying out the `last 1.x release of Quakestarter`_.


Launching Quakestarter
----------------------

Quakestarter is a script named "quakestarter.cmd"; if you don't show file extensions then it will just look like "quakestarter". Normally you should just be able to double-click on this file to run it. Depending on your Windows security settings you may need to reassure Windows that it is indeed safe to run; it should only be necessary to do this the first time you run Quakestarter.


Game data
---------

You need two game data files from Quake: "pak0.pak" and "pak1.pak". Put these files inside the "id1" folder, and you're ready to play Quake.

Similarly, if you own and want to play the official Quake missionpacks, each of those also has its own "pak0.pak" file that goes into its own unique game folder (next to the "id1" folder): the "hipnotic" folder for missionpack 1, or "rogue" for missionpack 2.

The first option in the main Quakestarter menu can usually locate and copy the necessary pak files if you already have Quake installed somewhere else on this same computer. This search logic is described in more detail in the :doc:`Auto Setup Logic<../other_stuff/auto_setup_logic>` chapter (under Other Topics). And if you're having difficulties finding your pak files, see the :doc:`Pak Files<../other_stuff/pak_files>` chapter there.

(The Ironwail engine actually includes its own logic for finding pak files in a Steam installation, but for simplicity Quakestarter doesn't depend on that and will treat Ironwail just like any other Quake engine. I.e. Quakestarter will still assume the pak files need to be found and placed into the "id1" folder.)

NOTE: The pak files in the "enhanced" Quake rerelease are different from the original pak files! Quakestarter will only look for and help install the pak files from the original game. Currently Quakestarter also assumes that both "pak0.pak" and "pak1.pak" are required to play, in contrast with the rerelease that only has "pak0.pak". Only the original game's pak files should be used in a Quakestarter-managed installation of Quake.


Soundtrack
----------

vkQuake and Ironwail (and several other Quake engines) can play the soundtrack from mp3 or ogg files if the physical Quake CD is not in your CD drive. To get soundtrack files installed for the original Quake campaign -- and also for the official missionpacks if you have those -- run Quakestarter and choose the second menu option. Quakestarter will attempt to find soundtrack files in existing Quake installations (original or rerelease) elsewhere on this computer; if that fails you will be given the option to download the files. The :doc:`Auto Setup Logic<../other_stuff/auto_setup_logic>` chapter has more details if you like.


Additional content
------------------

The remaining choices in the Quakestarter menus can be used to download and play some of the many community-created singleplayer adventures. These choices, and ways to find all the rest of the available Quake singleplayer content, are discussed in the following chapters.

If you're seeking something that was recently released, it might be under "The New Hotness" menu selections. On the other hand if you want to start with the classics then (unsurprisingly) the "Classic" selections would be the place to look. And there's a lot of stuff in between!


.. _last 1.x release of Quakestarter: https://github.com/neogeographica/quakestarter/releases/tag/v1.10
