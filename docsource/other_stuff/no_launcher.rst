Launcherless Launch
===================

If you don't have or want to use a launcher, the main things you'll need to know are the name of the game (mod) folder that you want to activate (if any), the name of the map you want to play, and whether the map/mod requires Quoth or a missionpack. The :doc:`Running with SQL2<../maps_and_mods/running_with_sql2>` chapter (under Maps and Mods) goes into more detail about how to interpret what a readme says about such dependencies.

When you know those things, you can handle all launcher-type activities yourself.

One approach is to use command-line options when launching Quake, but this chapter won't cover that. You can get some info about command-line options from the section "The Command Line" in `the Quake Owner's Manual guide on Steam`_ and also some of `the Custom Singleplayer Levels guide`_. If you do want to go that route, note that when using Quakestarter or Simple Quake Launcher 2 you'll see helpful examples of Quake command lines.

Here, we'll focus on using the Quake console (which is often easier than using the command line) and the Quake in-game menu (which is super easy but has some caveats).


Using the console to activate a mod
-----------------------------------

Once Quake has launched, if you are at the main menu with no game or demo running, then you can open the console with the ESC key. When a game or demo is running you can get to the console with the "~" key, or on international keyboards typically whatever key is under ESC. You can close the Quake console by hitting that key again or by hitting ESC. While the console is open you can type commands to cause stuff to happen, or type in new values for various settings.

(This chapter will just mention a few console commands. If you're curious to learn more, much of `the Quake Owner's Manual guide on Steam`_ is relevant.)

If the map you want to run is just a .bsp file in the "id1\\maps" folder, :ref:`skip this section<other_stuff/no_launcher:setting difficulty>`. That's the normal/default map location and doesn't involve any mod code.

Otherwise though, you'll need to specify the mod folder(s) to activate. The map/mod may also have a dependency on Quoth or an official missionpack, or even on some other mod.

You specify these things using the "game" command in the Quake console.

If the folder containing the addon content is named "foo" and doesn't depend on any other special game content, then you would just activate it with this command::

    game foo

If the folder is named "foo" and requires Quoth, then you would activate it with this command::

    game foo -quoth

If the folder is named "foo" and requires missionpack 1, then you would activate it with this command::

    game foo -hipnotic

If the folder is named "foo" and requires missionpack 2, then you would activate it with this command::

    game foo -rogue

If the folder depends on another non-Quoth non-missionpack mod folder (as described in the :doc:`Mod Requirements<mod_requirements>` chapter) you can add that dependency as the first argument. For example to run "udob_v1_1" that depends on "copper_v1_17", you would use the command::

    game copper_v1_17 udob_v1_1

If trying any of these commands results in an error message, then your Quake engine does not support doing a "game" command from the console. You'll have to use command-line options as described in the :doc:`Mod Requirements<mod_requirements>` chapter.

If you get an error *only* from that last form of the command, then your Quake engine does not support activating multiple mod folders.

Once you've executed the "game" command, if you see the message "execing quake.rc" appear in the console, you're ready to play. (This should be the case with any recent Quakespasm-variant engine.) Otherwise see the :doc:`quake.rc<quake_rc>` chapter for some more necessary details.


Using the in-game menu to activate a mod
----------------------------------------

Some Quake engines provide an in-game menu that you can use to activate a mod. Both vkQuake and Ironwail do, as it happens; they each have a "Mods" menu that you can use for this purpose.

If your Quake engine doesn't have a menu like that, then you'll have to use the console as described above. But if it *does* have such a menu then that can often be very handy.

The only downside to a menu like this is that they all (as far as I know) only allow you to activate a single mod folder. If the mod folder depends on another folder (like Quoth, Copper, etc.) then you can't use the menu to properly activate both of the required folders.


Setting difficulty
------------------

If you know that you almost always want to play at the same difficulty, you should add a line with a "skill" setting to your "id1\\autoexec.cfg" file. The legal values for skill are from 0 to 3, which corresponds to difficulty levels Easy to Nightmare. For example if you pretty much always want to play Hard difficulty you could add a line to your autoexec.cfg that says::

    skill 2

(Note that if you do use a launcher, the skill setting from the launcher will override this.)

If you don't have this setting in your autoexec.cfg, or if you do but you want to make an exception this time and play at a different difficulty level, then you can use the Quake console to choose the difficulty. Just enter a skill setting in the console *after* switching the game setting as above (if necessary) and *before* starting a map.


Launching a map
---------------

Some Quake engines provide an in-game menu that you can use to choose the map. However any Quake engine will also let you select a map using the console. You'll need to know the map filename. If for example the filename of the map you want to play is "whatsit.bsp", you would use the console command::

    map whatsit

In most Quake engines you can use autocomplete to see what maps are available. Just type "map" followed by a space and then press the Tab key. You can also use the autocomplete feature to avoid having to type the entire name of the map.


.. _the Quake Owner's Manual guide on Steam: http://steamcommunity.com/sharedfiles/filedetails/?id=120426294
.. _the Custom Singleplayer Levels guide: http://steamcommunity.com/sharedfiles/filedetails/?id=166554615
