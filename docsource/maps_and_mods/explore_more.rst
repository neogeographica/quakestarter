Explore More
============

Quake Injector
--------------

`Quake Injector`_ is worth a look when you're ready to really dig into Quake addons. It runs on any OS and it understands how to install and launch almost every bit of content from Quaddicted.

Quake Injector will *not* automatically apply the patches/fixes that Quakestarter does. The best way to find out what patches might be available for a release is to check out its individual page linked from `the Quaddicted reviews`_... see if the description in the upper right has an "additional files" section, and also maybe check the user comments as well. If there are available patches that you need (usually there won't be any), then you will have to manually download/extract/install those files into the mod folder.

Note that Quake Injector likes to keep around the zipfiles that it downloads, even if you uninstall a mod, until you explicitly delete the zipfile. If you're going to be using both Quakestarter and Quake Injector then you may want to configure them to share the same downloads folder.

The downloads location for Quake Injector is configured in the "Engine Configuration" dialog. The downloads location for Quakestarter is described in the :doc:`Advanced Configuration<../other_stuff/advanced_quakestarter_cfg>` chapter (under Other Topics). You can change one or the other of these locations so that they both point to the same folder. If you do this, you'll probably also want to configure Quakestarter to leave zipfiles in that folder and *not* delete them after they are installed, to match the behavior of Quake Injector.

One thing to look out for though is that Quakestarter doesn't work exactly the same as Quake Injector when it comes to choosing the name for a mod folder. Quakestarter will always use the name of the zipfile to determine the name of the folder, while Quake Injector may have other ideas. So to avoid confusion and wasted disk space on duplicate stuff, it's best to eventually settle on using only one of these install methods.


DIY
---

Once you're familiar with how Quake maps and mods work, it's not rocket science to install them yourself. The main three things to be aware of are 1) historically the best place to find singleplayer Quake content is at Quaddicted_, 2) `Slipgate Sightseer`_ is a new community site with a lot of initial buzz, and 3) you can also watch for new releases at `the func_msgboard forum`_.

When you download an addon, it sometimes consists of a bunch of files that are meant to be placed inside a new mod folder in your Quake installation. If this is the case then there should be a readme file included that tells you this. (Usually it's obvious anyway.)

If it is just a map that doesn't change anything else about Quake gameplay, it can instead be placed into your "id1\\maps" folder (which you can create if necessary). This is the case if the addon just consists of a .bsp file and maybe an associated .lit file. A .txt file or other docs can be put into any folder; those are just for your reference and the Quake engine won't look at them.

Similarly for a pure map release that is meant to be used with Arcane Dimensions or Copper, the file(s) can be placed into the "maps" folder of the relevant mod. Be careful though that it really is just a map release, and doesn't include a copy of the whole AD or Copper mod.

As discussed in the :doc:`Mod Folders<mod_folders>` chapter, you may want to go ahead and put a pure map release into its own mod folder anyway, the way that Quakestarter does. In that case you would need to explicitly create any necessary subfolders like "maps".

If you want more discussion about running Quake addons, see this relevant `Steam guide`_.


.. _Quake Injector: https://www.quaddicted.com/tools/quake_injector
.. _the Quaddicted reviews: https://www.quaddicted.com/reviews/
.. _Quaddicted: https://www.quaddicted.com/reviews/
.. _Slipgate Sightseer: https://www.slipseer.com/
.. _the func_msgboard forum: http://www.celephais.net/board/forum.php
.. _Steam guide: http://steamcommunity.com/sharedfiles/filedetails/?id=166554615
