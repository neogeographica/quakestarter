**** What's this then?

This package is one way to get going with the "state of the art" in Quake singleplayer. It's meant to be a convenient bundle of useful tools and explanations.

To be clear, you MUST own Quake already to take advantage of this package. In fact the easiest way to use this is if you already have the original Quake installed somewhere on your computer. Once you have Quake and are wondering "how do I play singleplayer Quake stuff in the 21st century?", you can answer that question here.

The tools included in this package are:

- The "quakestarter.cmd" script. (If you don't show file extensions then it will just look like "quakestarter".) This provides a menu-driven experience to help set up the Quake game data files and soundtrack, and to help install/play/manage some of the many custom singleplayer addons for Quake. We'll refer to this script as Quakestarter throughout these docs.

- Simple Quake Launcher 2 by "MaxEd", from https://github.com/m-x-d/Simple-Quake-Launcher-2/releases/latest . This is a front-end for running Quake which can be helpful when you explore beyond the set of addons that Quakestarter supports.

- If you got the normal Quakestarter bundle (not the "noengine" bundle), then it also includes the Quakespasm-Spiked "Quake engine" (Quake-playing program) from https://fte.triptohell.info/moodles/qss/ . Quakespasm-Spiked or "QSS" is an elaboration by "Spike" and other contributors on the original Quakespasm from http://quakespasm.sourceforge.net/ . Note that there are several other Quake engines out there; see the "quake_engines.txt" doc in the "quakestarter_docs\other_stuff" folder if you're curious.

You might want to keep an eye out in the future for newer releases of Simple Quake Launcher 2 or Quakespasm-Spiked. Unless something changes drastically, you can just drop their new files in here and replace the older versions.

Note that the programs in this package are meant to be used on Windows 7, 8, or 10. If you are using a different OS then the programs here won't be as useful, but the docs might be. See the "not_windows.txt" doc in the "quakestarter_docs\other_stuff" folder for some specific pointers.


**** Version info

The included version of Quakespasm-Spiked is ###QSS_VERSION###, 64-bit executable, from ###QSS_TIMESTAMP###. Note that this may be the "dev build" rather than the "Release", if that's actually considered to be more stable.

The included version of Simple Quake Launcher 2 is ###SQL_VERSION### from ###SQL_TIMESTAMP###.

As for this whole package of stuff, it's version ###VERSION### from ###TIMESTAMP###. If you want to see what has changed since the previous releases, see "changelog.txt" in the "quakestarter_docs\other_stuff" folder.

If you've been using a previous version of this package, see the "upgrading_quakestarter.txt" doc in the "quakestarter_docs\other_stuff" folder.


*** How to use this

You can use this package as a new Quake installation starting from scratch.

Or if you already have a Quake installation, you can drop these files and folders into that existing Quake folder if you like. The "1_installation.txt" doc in the "quakestarter_docs\basic" folder goes into a bit more detail about that approach.

The following sequence will get you off and running:

- You're going to need Microsoft .Net Framework version 4.5 or later. If you are on a normal Windows 8 or Windows 10 system, you're fine. For more details, especially if you are on Windows 7, see the "dot_net_version_dependency.txt" doc in the "quakestarter_docs\other_stuff" folder.

- If you're starting a new Quake installation from scratch, you need to move or copy your "pak0.pak" and "pak1.pak" files (Quake game data) into the "id1" folder. If you already have another Quake installation on your computer somewhere, you can run Quakestarter and choose the first menu option; this can usually automatically find and copy those pak files for you.

- You can also use the second option in the main Quakestarter menu to get the Quake soundtrack files set up. The Quake soundtrack adds a lot -- it's more like "ambient sounds" most of the time, rather than a song. It's good to have!

- In the "id1" folder, there's a file named "autoexec.cfg.example". This contains some settings that are not always accessible through the in-game menu options of some Quake engines. You can rename this file to "autoexec.cfg" to enable those settings. You can of course change the settings and values in your "autoexec.cfg" to match your personal preferences -- you don't need to stick with the given example values.

- Now use the third option in the main Quakestarter menu to launch Quake. Hopefully it works! This would be a good time to get the remainder of your desired Quake configuration set up through the in-game menus.

- The "2_configuration.txt" doc in the "quakestarter_docs\basics" folder goes into a bit more detail about the previous two steps. You don't need to go down the rabbit hole but you do want your basic setup to be comfortable, because that setup will be copied to each new release that you install and play.

- At this point you should be able to freely explore the remaining Quakestarter menu options and try any addon that looks interesting. (If you want more info about an addon, you can look up its page on https://www.quaddicted.com/reviews/ )

- Alternately you can use "SQLauncher2.exe", the Simple Quake Launcher 2, as another great way to manage launching Quake to play custom addons or official missionpacks or the original campaign.


If you're a Quake veteran that's probably all you need to know.

If those steps aren't clear, or something goes wrong, or if you just want more details... have a look at the docs in the "quakestarter_docs\basic" folder for explanations.

When you want even more things to play, and in general more details about how to launch maps/mods outside of Quakestarter, check out the docs in the "quakestarter_docs\maps_and_mods" folder.

The docs in the "quakestarter_docs\other_stuff" folder are a little more specialized and you might not need to bother with them. You'll see that they're referenced from other docs in a few spots, or you can just have a look at them if you're curious.

Have fun!
