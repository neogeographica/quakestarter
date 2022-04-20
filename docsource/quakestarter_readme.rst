=======================
Quakestarter Quickstart
=======================

.. toctree::
   :hidden:
   :maxdepth: 2
   :caption: Basic Topics

   basic/installation
   basic/configuration
   basic/running

.. toctree::
   :hidden:
   :maxdepth: 2
   :caption: Maps and Mods

   maps_and_mods/mod_folders
   maps_and_mods/running_with_quakestarter
   maps_and_mods/running_with_sql2
   maps_and_mods/explore_more

.. toctree::
   :hidden:
   :maxdepth: 2

   other_stuff/index


**If you're new here, please ignore that Navigation sidebar for now! This first page here covers most or all of what you will need to know to get started.**

What's this then?
=================

This package is one way to get going with the "state of the art" in Quake singleplayer. It's meant to be a convenient bundle of useful tools and explanations.

To be clear, you must own Quake already to take advantage of this package. In fact the easiest way to use this is if you already have the *original* Quake installed somewhere on your computer. Once you have Quake and are wondering "how do I play singleplayer Quake stuff in the 21st century?", you can answer that question here.

The tools included in this package are:

* The "quakestarter.cmd" script. (If you don't show file extensions then it will just look like "quakestarter".) This provides a menu-driven experience to help set up the Quake game data files and soundtrack, and to help install/play/manage some of the many custom singleplayer addons for Quake. We'll refer to this script as Quakestarter throughout these docs.

|br|

* `Simple Quake Launcher 2`_ by "MaxEd". This is a front-end for running Quake which can be helpful when you explore beyond the set of addons that Quakestarter supports.

|br|

* If you got the normal Quakestarter bundle (not the "noengine" bundle), then it also includes the `Quakespasm-Spiked`_ "Quake engine". Quakespasm-Spiked or "QSS" is an elaboration by "Spike" and other contributors on the original Quakespasm_. Note that there are several other Quake engines out there; see the :doc:`Quake Engines<other_stuff/quake_engines>` chapter (under Other Topics) if you're curious.

You might want to keep an eye out in the future for newer releases of Simple Quake Launcher 2 or Quakespasm-Spiked. Unless something changes drastically, you can just drop their new files in here and replace the older versions.

Note that the programs in this package are meant to be used on Windows 7, 8, 10, or 11. If you are using a different OS then the programs here won't be as useful, but these docs might be. See the :doc:`Beyond Windows<other_stuff/not_windows>` chapter (under Other Topics) for some specific pointers.


Version info
============

The included version of Quakespasm-Spiked is ###QSS_VERSION###, 64-bit executable, from ###QSS_TIMESTAMP###. Note that this may be the "dev build" rather than the "Release", if that's actually considered to be more stable.

The included version of Simple Quake Launcher 2 is ###SQL_VERSION### from ###SQL_TIMESTAMP###.

As for this whole package of stuff, it's version |version| from ###TIMESTAMP###. If you want to see what has changed since the previous releases, see the :doc:`Changelog<other_stuff/changelog>` (under Other Topics).

If you've been using a previous version of this package, see the :doc:`Upgrading Quakestarter<other_stuff/upgrading_quakestarter>` chapter (under Other Topics).


How to use this
===============

You can use this package as a new Quake installation starting from scratch.

Or if you already have a installation of the original Quake (not the "enhanced" rerelease), you can drop these files and folders into that existing Quake folder if you like. The :doc:`Installation<basic/installation>` chapter goes into a bit more detail about that approach.

The following sequence will get you off and running:

* You're going to need Microsoft .Net Framework version 4.5 or later. If you are on a normal Windows 8 or Windows 10 system (or later), you're fine. For more details, especially if you are on Windows 7, see the :doc:`.Net Dependency<other_stuff/dot_net_version_dependency>` chapter (under Other Topics).

|br|

* If you're starting a new Quake installation from scratch, you need to move or copy your "pak0.pak" and "pak1.pak" files (Quake game data) into the "id1" folder. If you already have an installation of the original Quake on your computer somewhere, you can run Quakestarter and choose the first menu option; this can usually automatically find and copy those pak files for you. Quakestarter will look for installations from stores that provide the original Quake game data (Steam and GOG) as well as checking other places where Quake may be installed.

|br|


* You can also use the second option in the main Quakestarter menu to automatically get the Quake soundtrack files. The Quake soundtrack adds a lot -- it's more like "ambient sounds" most of the time, rather than a song. It's good to have! Quakestarter will look for installations from stores that provide the soundtrack as part of the "enhanced" Quake rerelease (Steam, Xbox Game Pass, and Bethesda) as well as checking other places where Quake may be installed.

|br|


* In the "id1" folder, there's a file named "autoexec.cfg.example". This contains some settings that are not always accessible through the in-game menu options of some Quake engines. You can rename this file to "autoexec.cfg" to enable those settings. You can of course change the settings and values in your "autoexec.cfg" to match your personal preferences -- you don't need to stick with the given example values.

|br|


* Now use the third option in the main Quakestarter menu to launch Quake. Hopefully it works! This would be a good time to get the remainder of your desired Quake configuration set up through the in-game menus.

|br|


* The :doc:`Configuration<basic/configuration>` chapter goes into a bit more detail about the previous two steps. You don't need to go down the rabbit hole but you do want your basic setup to be comfortable, because that setup will be copied to each new release that you install and play.

|br|


* At this point you should be able to freely explore the remaining Quakestarter menu options and try any addon that looks interesting. (If you want more info about an addon, you can look up its page on Quaddicted_.)

|br|


* Alternately you can use "SQLauncher2.exe", the Simple Quake Launcher 2, as another great way to manage launching Quake to play custom addons or official missionpacks or the original campaign.


If you're a Quake veteran that's probably all you need to know.

If those steps aren't clear, or something goes wrong, or if you just want more details... have a look at the Basic Topics chapters for explanations, beginning with :doc:`Installation<basic/installation>`.

When you want even more things to play, and in general more details about how to launch maps/mods outside of Quakestarter, check out the chapters under Maps and Mods, beginning with :doc:`Mod Folders<maps_and_mods/mod_folders>`.

The Other Topics chapters are a little more specialized and you might not need to bother with them. You'll see that they're referenced from other chapters in a few spots, or you can just have a look at them if you're curious.

Have fun!


.. _Simple Quake Launcher 2: https://github.com/m-x-d/Simple-Quake-Launcher-2/releases/latest
.. _Quakespasm-Spiked: https://fte.triptohell.info/moodles/qss/
.. _Quakespasm: http://quakespasm.sourceforge.net/
.. _Quaddicted: https://www.quaddicted.com/reviews/
