Mod Requirements
================

The readme that comes with an addon may describe some requirements for successfully playing its content. Note that if some addon was installed through Quakestarter and is being launched through Quakestarter then things should "just work", especially in the default Quakestarter configuration. This chapter is more useful if you are working outside of Quakestarter.


Engine requirements
-------------------

If the readme says that the addon requires Fitzquake, the content will also work with Quakespasm and Quakespasm-variant engines, as well as almost certainly working fine with Mark V and other engines. The capabilities of the old popular Fitzquake engine have been adopted by basically every mainstream modern Quake engine that has a singleplayer focus.

If the readme says that it requires an engine that supports the "bsp2" map format, Quakespasm-ish engines are OK with that too, as are most currently-maintained Quake engines.

Generally it's unusual for a modern and maintained Quake engine to be unable to play a widely-known release, if the engine is meant for singleplayer use. The standout exception would probably be the Nehahra episode as discussed `on its Quaddicted page`_.

The section on customizing your choice of Quake engine in the :doc:`Advanced Configuration<advanced_quakestarter_cfg>` chapter has more discussion of appropriate Quake engines.


Mod dependencies
----------------

If the mod is in its own folder but it builds on another mod, for example a map release that depends on Arcane Dimensions (AD) or Copper, then you will need to account for that dependency when launching it.

This does *not* include maps/mods that depend on Quoth or an official missionpack. This also doesn't include mods that carry their own copy of the AD or Copper mod. This is about pure map releases that are meant to be played with AD or Copper, but which have been installed into their own separate mod folder (e.g. as Quakestarter will install things).

To launch a mod that has been installed this way, you will need to use a Quake engine that supports activating multiple mod folders. This includes vkQuake, Ironwail, Quakespasm-Spiked, FTE, DarkPlaces, and qbism Super8. This will *not* for example work with the original Quakespasm or with Mark V.

To activate multiple mod folders, on an engine that supports it, you just need to list them in order of increasing precedence. Let's look at an example using the "udob_v1_1" folder, which depends on the Copper mod in the "copper_v1_17" folder.

If you were composing a Quake command line to launch this, you would use these "-game" arguments (along with whatever other Quake arguments you need)::

    -game copper_v1_17 -game udob_v1_1

(And that's what you will see when Quakestarter shows you the command line it uses to launch "udob_v1_1".)

If you were using the "game" command in the Quake console, it would look like this::

    game copper_v1_17 udob_v1_1

If you're unsure about whether your Quake engine supports activating multiple mod folders, you can try a "game" console command in that format, and see if it works or if it gives you an error.

**Note:** The qbism Super8 engine uses a different syntax on the command line, where the first (base mod) switch is "-game2" rather than "-game". Super8 also does *not* have a corresponding console command.

If you are using an engine that doesn't support activating multiple mod folders, then you can't play things that have been installed in this way. In that case, to play such content you will need to just dump it into the Arcane Dimensions or Copper mod folder (as appropriate), so that you can then load that folder as the single mod.


Mod configurations
------------------

When using a modern and maintained Quake engine you can largely ignore recommendations in the readme for increasing "heapsize", "zone", "winmem", or "max_edicts". Your Quake engine will likely use sufficiently large values already for these (and many other) settings. This is especially true for older addons that were released before any of these modern engines.

If other settings are recommended, there are various ways to handle those. Note that if this mod was installed through Quakestarter, this has probably already been handled for you with "modsettings.cfg". Otherwise you may want to manually put such settings into the mod's "quake.rc". See the :doc:`quake.rc<quake_rc>` chapter for more details.


.. _on its Quaddicted page: https://www.quaddicted.com/reviews/nehahra.html
