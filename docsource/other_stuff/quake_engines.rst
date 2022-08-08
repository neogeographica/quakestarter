Quake Engines
=============

What is a "Quake engine"?
-------------------------

A program that plays Quake is often called a "Quake engine" or a "source port". Community members have been working on such things since soon after the original Quake source code was released back in the 90s.

Quite a while back I created a `Steam guide`_ with an overview of several Quake engines. Although I've let it become outdated, it still gives you an idea of the available variety. Different Quake engines have different goals. Some are focused on singleplayer, some on multiplayer; some are mostly about fixing bugs or adding "quality of life" features, while others are about supporting new visual effects; etc.

Currently Quakespasm_ is a sort of "reference standard" for new singleplayer map releases. Unless a new map is doing something quite unusual, it should work correctly on Quakespasm. Variants like vkQuake_, Ironwail_, and `Quakespasm-Spiked`_ (or "cousins" like `Mark V`_) have added features on top of the Quakespasm baseline without drastically changing its play experience or its compatibility/stability. Other engines like FTE_ or DarkPlaces_ go farther in adding new stuff.


Which one to use for singleplayer
---------------------------------

Quakestarter is bundled with the vkQuake_ and Ironwail_ engines, with vkQuake set as the initial default.

vkQuake uses the Vulkan API for rendering, while Ironwail uses some advanced features of OpenGL. It's possible that one will perform better than the other on your system, depending on your graphics drivers and the relative beefiness of your CPU vs your GPU. In all likelihood though, on a modern system both of these engines will crank out more frames-per-second than you will ever need, so the choice might come down to some other features.

Here's a quick rundown of some of the most user-visible features that these engines have added on top of the Quakespasm baseline. 

=================== =======   ========
feature             vkQuake   Ironwail
=================== =======   ========
mod loading UI        yes        yes
weapon binding UI      no        yes
use mouse in UI        no        yes
unlocked fps          yes        yes
custom particles      yes         no
HUD variants           no        yes
custom HUDs           yes         no*
8-bit emulation       yes        yes
detect Steam paks      no        yes
lit water support     yes        yes
classic waterwarp     yes        yes
multi game dirs       yes        yes
drag-resize window    yes         no
protocol extensions   yes         no
=================== =======   ========

And a blurb about each of these features:

* mod loading UI: An in-game menu to activate a mod folder.
* weapon binding UI: Support in the in-game controls menu for binding individual weapons to keys. (Otherwise these binds can be done with config file edits.)
* use mouse in UI: Whether the mouse can be used to work the in-game menus.
* unlocked fps: The ability to use framerate caps higher than 72 FPS without causing issues with the game physics.
* custom particles: Support for mod-defined particle systems, such as found in Arcane Dimensions and Alkaline.
* HUD variants: Support for a predefined selection of HUD layouts.
* custom HUDs: Support for mod-defined HUD graphics, such as found in Arcane Dimensions and Alkaline. (Ironwail has this feature on its roadmap, but the version bundled with this release of Quakestarter does not yet support it.)
* 8-bit emulation: Optional setting to emulate the palettized rendering of original DOS/WinQuake.
* detect Steam paks: The ability to run using the gamedata from an existing Steam installation of Quake, without needing to find and copy the pak files. This doesn't matter when using Quakestarter, which does its own method of pak-finding, but can be handy otherwise.
* lit water support: Support for rendering shadows on the surfaces of liquids, for recent maps that have been compiled in a way that generates that shadow information.
* classic waterwarp: Emulation for the underwater warping effect of original DOS/WinQuake (as opposed to the different GLQuake effect).
* multi game dirs: The ability to activate more than one mod folder, beyond the hardcoded support for only Quoth and missionpacks found in some engines. Quakestarter depends on this feature for launching a few of the addons that depend on Copper or Arcane Dimensions.
* drag-resize window: When running in windowed mode, whether the game window can be resized just by using the moust to grab-and-drag the window's edge/corner.
* protocol extensions: This is a complicated topic, but one of the more obvious benefits to protocol extension support is the ability to play back a wider range of demo recordings (such as demos recorded with Quakespasm-Spiked).

If you want to use some engine other than vkQuake or Ironwail, the :doc:`Advanced Configuration<advanced_quakestarter_cfg>` chapter has details about how to set that up.

(And for a comparison of singleplayer engines, `Quake Engines & Source Ports`_ on Slipgate Sightseer is a good quick reference.)

Why not the "enhanced" Quake rerelease?
---------------------------------------

The recent rerelease/remaster of Quake is a cool project, and it's a great way to (re)play the original campaign and official missionpacks. It's compatible with some custom map releases as well... but not all. So for the foreseeable future, the best way to play custom singleplayer maps will still be by using a community-developed Quake engine like Quakespasm and the other engines mentioned here.

You can have both the Quake rerelease and also a community-developed Quake engine installed on your computer without any issues, although you should keep them in separate folders.


.. _Steam guide: http://steamcommunity.com/sharedfiles/filedetails/?id=118401000
.. _Quakespasm: http://quakespasm.sourceforge.net/
.. _vkQuake: https://github.com/Novum/vkQuake
.. _Ironwail: https://github.com/andrei-drexler/ironwail
.. _Quakespasm-Spiked: https://fte.triptohell.info/moodles/qss/
.. _Mark V: http://quakeone.com/markv/
.. _FTE: https://fte.triptohell.info/
.. _DarkPlaces: https://icculus.org/twilight/darkplaces/
.. _Quake Engines & Source Ports: https://www.slipseer.com/index.php?threads/quake-engines-source-ports-a-beginners-guide.11/
