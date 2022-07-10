Configuration
=============

Using the Quake menus
---------------------

It's good to run Quake at least once before playing any custom content, to set up your desired Quake configuration. You can do this from the fourth option of the main Quakestarter menu. Or you can just run your Quake executable (e.g. "vkQuake.exe" or "ironwail.exe") from Windows.

If this fails with an error dialog about "W_LoadWadFile: couldn't load gfx.wad" then your pak files (game data) are not present. You might need to go back to the :ref:`"Game data"<basic/installation:game data>` section of the Installation chapter.

(If Quake fails to start because you have a 32-bit OS, you're going to need to use a different, 32-bit Quake engine. Adding a new Quake engine is covered in the :doc:`Advanced Configuration<../other_stuff/advanced_quakestarter_cfg>` chapter. Both vkQuake_ and Ironwail_ do have 32-bit versions that you can download from their sites.)

Note that vkQuake and Ironwail store their menu-controlled settings in different files, so any changes you through the menus of one of these engines will *not* automatically apply if you switch to using the other one.

The most important point though is that any settings you configure for the original Quake campaign will be used as a starting point when you later launch custom content (with the same Quake engine). So now is the time to get your controls, graphics settings, volume, etc. set up the way you like it! 


Using autoexec.cfg
------------------

Quake engines support other configuration options that aren't often exposed in the in-game menus. It varies from engine to engine, but items omitted from the menus can include some pretty important things like autoaim, the framerate cap, and even whether you have a crosshair onscreen.

Use a text editor to open the "autoexec-cfg-example-annotated.txt" file inside the "id1" folder and have a look at some of the example settings described there. You can copy interesting settings into your own "autoexec.cfg" file in the "id1" folder, and modify their values there as you like.

If you don't already have your own "autoexec.cfg" file, you can rename the "autoexec.cfg.example" file to "autoexec.cfg" and use that as a starting point.

(Do *not* just rename the "autoexec-cfg-example-annotated.txt" file for this purpose, as the extra comments in that "annotated" file will cause problems with the config file size limits in some Quake engines.)

A summary of what you can do with the settings shown in those files: unlock a higher framerate, disable autoaim, get a crosshair, configure "pixely textures", adjust weapon position to be more "authentic", configure old-style square particles, change the amount of water transparency, and/or revert to old-style jerky animations.

Note that if you use the in-game menus to affect some setting that you also have in your "autoexec.cfg" file, the "autoexec.cfg" value is the one that will be restored next time Quake starts... the contents of "autoexec.cfg" always take priority over anything set through the menus. This is true regardless of which Quake engine you are using.


Using the Quake console and config files
----------------------------------------

Many other settings are available. You can also keybind other actions beyond what the menus allow. There's a few ways you can edit these other settings and keybindings, including changing them interactively using the Quake console or by editing config files.

The "about Quake config files" section of "autoexec-cfg-example-annotated.txt" discusses the config file situation a bit more. Beyond that, these docs won't get into a lot of detail about Quake configuration; if you're interested there are lots of Web resources such as:

* an old `keybinding guide`_
* `a complete list of settings/commands`_
* the introductory sections of `this Steam guide`_


Quakestarter configuration
--------------------------

Besides configuring Quake itself, you may also want to change the behavior of Quakestarter. This includes adding a new Quake engine to use (if you don't want to use vkQuake or Ironwail) and several other things about how addons are downloaded, installed, and launched.

Quakestarter should work fine out-of-the-box without changing any of that configuration, but if you want to dig in, see the :doc:`Advanced Configuration<../other_stuff/advanced_quakestarter_cfg>` chapter (under Other Topics).


.. _vkQuake: https://github.com/Novum/vkQuake
.. _Ironwail: https://github.com/andrei-drexler/ironwail
.. _keybinding guide: https://quake.fandom.com/wiki/Quick_Weapon_Selection
.. _a complete list of settings/commands: https://www.quakewiki.net/archives/console/commands/quake.html
.. _this Steam guide: https://steamcommunity.com/sharedfiles/filedetails/?id=120426294
