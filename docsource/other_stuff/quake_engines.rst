Quake Engines
=============

What is a "Quake engine"?
-------------------------

A program that plays Quake is often called a "Quake engine" or a "source port". Community members have been working on such things since soon after the original Quake source code was released back in the 90s.

Quite a while back I created a `Steam guide`_ with an overview of several Quake engines. Although I've let it become outdated, it still gives you an idea of the available variety. Different Quake engines have different goals. Some are focused on singleplayer, some on multiplayer; some are mostly about fixing bugs or adding "quality of life" features, while others are about supporting new visual effects; etc.

Currently Quakespasm_ is a sort of "reference standard" for playing new singleplayer map releases. Variants like `Quakespasm-Spiked`_, vkQuake_, or Ironwail_ (or "cousins" like `Mark V`_) add features on top of the Quakespasm baseline without drastically changing its play experience or its compatibility/stability. Other engines like FTE_ or DarkPlaces_ go farther in adding new stuff.


Which one to use for singleplayer
---------------------------------

By default Quakestarter uses the `Quakespasm-Spiked`_ engine, a.k.a. QSS.

Quakespasm-Spiked essentially matches Quakespasm for compatibility, and it adds important usability improvements that can smooth out the experience of playing or managing many existing addons... like supporting higher framerates and the ability to load multiple mod folders. It also implements features like advanced particle systems and customizable HUD/menus that newer addons can take advantage of. Arcane Dimensions is one example of a recent mod that can make use of these QSS features.

Performance-hungry users with not-too-ancient graphics cards may be interested in trying out vkQuake_. This is a version of Quakespasm with a Vulkan renderer, so you do need to have a video card that is modern enough to support Vulkan in its drivers. Along with support for important stuff like high framerates and multi-mod-folders, vkQuake also can handle the new particle and HUD systems from QSS.

Another Quakespasm variant, Ironwail_, is even more focused on high performance. While it is still pretty "young" and may have some kinks to work out, it seems stable and has attracted a following. Ironwail supports high framerates and multi-mod-folders, but not the particle/HUD innovations. It adds support for some interesting optional emulations of software rendering, for players who want to re-experience the original Quake look.

Previous versions of Quakestarter bundled `Mark V`_ instead, and Mark V does still have several advantages especially in its in-game menus. But while Quakespasm-Spiked has increased its compatibility/stability and its adoption among singleplayer users, Mark V has stagnated and now cannot play (or at least play well) some recent releases.


Why not the "enhanced" Quake rerelease?
---------------------------------------

The recent rerelease/remaster of Quake is a cool project, and it's a great way to (re)play the original campaign and official missionpacks. It's compatible with some custom map releases as well... but not all. So for the foreseeable future, the best way to play custom singleplayer maps will still be by using a community-developed Quake engine like Quakespasm and the other engines mentioned here.

You can have both the Quake rerelease and also a community-developed Quake engine installed on your computer without any issues, although you should keep them in separate folders.


.. _Steam guide: http://steamcommunity.com/sharedfiles/filedetails/?id=118401000
.. _Quakespasm: http://quakespasm.sourceforge.net/
.. _Quakespasm-Spiked: https://fte.triptohell.info/moodles/qss/
.. _vkQuake: https://github.com/Novum/vkQuake
.. _Ironwail: https://github.com/andrei-drexler/ironwail
.. _Mark V: http://quakeone.com/markv/
.. _FTE: https://fte.triptohell.info/
.. _DarkPlaces: https://icculus.org/twilight/darkplaces/
