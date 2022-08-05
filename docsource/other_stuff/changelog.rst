Changelog
=========

.. rubric:: v3.3.0 (Aug 2022)

This release introduces an autoupdate feature for Quakestarter, as well as the ability to trigger the update process using a manually downloaded zipfile if you'd rather do that. These features are discussed in detail in the :doc:`Updating Quakestarter<upgrading_quakestarter>` chapter (under Other Topics).

If you're updating *to* v3.3.0 from an earlier release, you don't have this feature yet! You'll still have to do the manual "overwrite your current files with the contents of the zip" kind of update process one last time. (And actually you can still continue to do Quakestarter updates that way in the future, if you want.)

Of course a feature like autoupdate could be affected by variations in people's hardware, OS, and Internet connection, and it's impossible for me to test all those combinations myself. If you do hit a situation where autoupdate doesn't work for you, please let me know the details of what happened. You can use the email address in the footer of `quakestarter.com`_, or file an issue as described in :doc:`Updating Quakestarter<upgrading_quakestarter>`.

Assuming the autoupdate feature is a keeper, it will be more reasonable to promptly push out new Quakestarter releases in the future. For example we can react quickly to any new version of vkQuake or Ironwail. Also see the note about the new "The Latest Greatest" category below.

Other stuff in this release:

* Update docs to reflect that the Windows version of Quake Injector no longer relies on a system Java installation.
* `Quake Sewer Jam`_ has had a bit of a ratings bump that brings it out of the "legacies" menu and back into the Post-AD episodes menu.
* Rename the "The Age of Jams" category to "The Coming of the Jams", since obviously we still have a lot of jams going on! Also rename "The New Hotness" to "The Next Generation" since it's become more of a standard "era" category now rather than just sort-of-recent-stuff.
* Speaking of which: add a new "The Latest Greatest" category which is specifically for recent high-profile releases (as determined by me, I guess). Check out that menu page for more explanation on how it works.


.. rubric:: v3.2.0 (Jul 2022)

The main point of this release is to change the bundled Quake engine(s). Instead of `Quakespasm-Spiked`_, Quakestarter will now bundle both vkQuake_ and Ironwail_. A new item has been added to the main Quakestarter menu to help you switch between any Quake engines that are present in the Quake folder, and the :doc:`Quake Engines<quake_engines>` chapter of the docs has a more extended description of these two engines.

This change is motivated by occasional reported compatibility issues in recent Quakespasm-Spiked releases, an active and transparent development process for vkQuake and Ironwail, and just a general sense of where the conventional wisdom currently rests about the best general-purpose singleplayer engine. Quakespasm-Spiked is still a great program and still has several features not found in vkQuake or Ironwail, but for now vkQuake and Ironwail will be the bundled engines here.

If you have an existing older Quakestarter installation that bundled Quakespasm-Spiked, you have a few choices when upgrading to a newer Quakestarter version that bundles vkQuake/Ironwail:

* **If you want to continue using Quakespasm-Spiked and you don't care about having vkQuake/Ironwail**, use the "noengine" version of the new Quakestarter release and overwrite your existing files. Then use the engine-choice menu item to choose your Quakespasm-Spiked executable.

|br|

* **If you want to have the ability to switch between all three Quake engines**, use the normal version of the new Quakestarter release and overwrite your existing files.

|br|

* **If you want to get rid of the Quakespasm-Spiked files (and only use vkQuake/Ironwail going forward)**, then you could do so before the upgrade by deleting qss_manifest.txt and all the files it lists. If you've already done the upgrade and overwritten various files though, the only files you should delete are: qss_manifest.txt, libvorbisidec-1.dll, quakespasm.pak, Quakespasm-Spiked.txt, Quakespasm-Spiked-Revision.txt, and quakespasm-spiked-win64.exe.

This release also has a few doc updates to take into account the opening of `Slipgate Sightseer`_, and it now handles Copper_ dependencies using the recent release of Copper version 1.19.


.. rubric:: v3.1.0 (Jun 2022)

This release is purely about updating the lists of installables. Four 2022 releases have popped up just over the ratings threshold, but interestingly so have several older releases all the way back to 1997. For this release I'm experimenting with doing a little blurb for each addition, so here's a rundown from newest to oldest.

In the Next Generation menus (Episodes and Other):

* Speedmap event #217 was themed on `Remaster Textures`_ (2022, in Episodes) from the Quake re-release; this new coat of paint got the creative juices flowing for some old hands and new blood.
* `Slip Tripping`_ (2022, in Other) is a polished bite-sized gem from Markie_, the multi-talented mapper behind the `Quake Builder`_ and `Markie Music`_ channels.
* Waldsterben_ (2022, in Other) from `Paul Lawitzki`_ is a unique Copper_-based offering that shows off one of the best "forest" environments you'll see in Quake.
* `January Jump Jam 2`_ (2022, in Episodes) takes the "jump boots" powerup out for a shakedown cruise, using the Alkaline_ mod.

And in the other menus:

* `The Elder Reality`_ (2016, in Other - The Coming of the Jams) is an artful tribute to the maps of Episode 4, from PuLSaR_ who is no stranger to these lists.
* `Deathmatch Classics Vol. 3`_ (2011, in Episodes - Modern) -- returning from its exile in the "legacies" menu -- brings together heavy hitters to spin SP interpretations of DM maps from id and the community.
* `A Roman Wilderness Of Pain`_ (2009, in Other - Post-Quoth), also returning from "legacies", delivers epic scale like only Tronyn_ can. Check out the `retrospective about this mapset`_ while you're here!
* `This Onion`_ (2007, in Other - Post-Quoth) from `Mike Woodham`_, a moody and quirky adventure, is the final entry here to escape from "legacies" with a ratings boost. (Curiously `its sequel/remake`_ is still a hair short of doing likewise.)
* Antediluvian_ (2005, in Other - Classic) is a classic wind-tunnels-inspired level from Rubicon_ mapper, `Quake engine`_ coder, and func_msgboard_ host (whew) John Fitzgibbons. 
* `Quake Condensed`_ (2004, in Episodes - Modern) by `R.P.G.`_ is a neat recapitulation of the original Quake campaign map themes in five small pieces.
* Biotoxin_ (2001, in Other - Classic) is yet another czg_ creation for our lists, notable for being constructed out of only 100 brushes.
* Arcane_ (1997, in Other - Classic) is our earliest entry. It's also the last and probably best release from `Matt Sefton`_, who was not only a standout 1996/97 mapper but was also among the first reputable Quake map reviewers.

Also of course a few bugfixes have snuck in. Deathmatch Classics Vol. 3 and Paradise Sickness (in "legacies") have added patches. Also I've eliminated a warning message that would show when Quakestarter looked for pakfiles/music on a system that didn't have Steam library folders configured.


.. rubric:: v3.0.0 (Apr 2022)

Some interesting high-visibility changes here, and some changes to the file structure, so let's do a major version bump. Welcome to Quakestarter 3.0.0!

The most obvious change is that the documentation is now in HTML. You can open "quakestarter_readme.html" in your web browser and poke around; there's also an option to open the docs from the main Quakestarter menu. Rather than the docs just mentioning each other, they now use proper hyperlinks... imagine that.

(If you're upgrading by overwriting a 2.x release of Quakestarter, the first time you run 3.x it will remove the old textfile documentation.)

Also new in this release: On the menus showing individual addons, you now have the option to open the Quaddicted review page for a particular addon. That page will open in your default web browser.

Speaking of addons, `The Castle of Koohoo`_ has made a triumphant return to the Classic (non-episodes) menu, on the back of a small recent ratings bump. (Maybe because of the `Koohoo-themed retrojam`_?) We've also added the sm198_ hub to the Post-AD episodes menu, a nicely weird experimental speedmap pack with a particularly small playable space per map.

Finally, as part of the process of finding Quake game data and soundtrack files, Quakestarter is now better at locating Quake installations that are in Steam library folders separate from the main Steam folder.


.. rubric:: v2.5.0 (Apr 2022)

You may have noticed that there was a new Quakespasm-Spiked release that I haven't yet picked up for use here with Quakestarter. There's a concern with using new QSS builds that I'm chewing on in `a GitHub issue`_.

Please feel free to add comments on that GitHub issue if you have opinions about the solution.

Another relevant release that has happened sort of recently is Windows 11. I haven't done extensive testing on Windows 11, but initial feedback looks good and I have no reason to believe that Quakestarter will have any issues there.

But anyway, this Quakestarter version is about dealing with yet another release: the "enhanced" Quake rerelease, a neat thing that has shown up on some storefronts. In some ways Quakestarter can benefit from the rerelease (because it provides music soundtrack files) and in other ways we need to be careful that the rerelease doesn't cause problems (because it provides pak files that are "wrong" in that they are different from the original pak files).

So this release of Quakestarter has the following features:

* Add support for finding/copying music tracks from the Quake rerelease.

|br|

* Add pak file checksumming, to avoid accidentally picking up the rerelease pak files or the old 1.01 pak0.pak.

|br|

* General doc updates to take into account some implications of the rerelease.


.. rubric:: v2.4.0 (Mar 2022)

It's been a while since I've checked over the whole Quaddicted database again for qualifying releases, as opposed to just looking at new stuff as it comes in. Of course it's quite possible for the ratings of old stuff to change... and when you're dealing in Bayesian averages, the score for release X can change even if X didn't get any new ratings but Y and Z did.

Anyway, the "whole database scan" showed quite a few changes, mostly of things that had dropped below the ratings threshold. I don't know if that's because of the normal workings of the ratings system or because of some other changes in the Quaddicted backend; in any case, it didn't feel right to continue to apply the current criteria.

So I've lowered the bar on the score needed to qualify... more so for older releases. A few more details are in the "quakestarter_docs\\other_stuff\\selection_criteria.txt" doc, and as usual each of the main section installer scripts in "quakestarter_scripts" has the criteria for that section in comments at the top of script.

The upshot of applying this new criteria to the whole Quaddicted database is as follows. Several installables are still going to get dropped to the "legacies" section, but overall things are pretty stable and we even pick up four new installables.

New items added: Dead Memories, Jumpmod 2 + Triune Discovery, Alkaline Jam, and In The Shadows [Demo v1.1]

Existing items removed, i.e. moved to "legacies": (The Final) Descent, The Castle of Koohoo, The Slipgate Duplex, Contract Revoked: The Lost Chapters, This Onion, A Roman Wilderness Of Pain, The Anomaly, Deathmatch Classics Vol. 3, For My Babies - Bin Dunne Gorne 2, Func Map Jam 5 - The Qonquer Map Jam, Paradise Sickness, and Quake Sewer Jam

To keep the legacies menu manageable (one-page), I've also aged-out and removed the four oldest entries there: Red Slammer, Gloomier Keep, Midnight Stalker, and Func Map Jam 1 - Honey Theme. If you still have any of those mods installed you'll need to manage them outside of the Quakestarter menus.


.. rubric:: v2.3.0 (Mar 2022)

* Include an updated Quakespasm-Spiked (2021-10-14).

|br|

* Include latest Simple Quake Launcher 2 (2.5).

|br|

* Move the Unused Jam and the Blue Monday Jam to legacies (rating drop).

|br|

* Add the Punishment Due episode, the Snack Pack 2 episode, the Xmas Jam 2021 hub, the Alkaline 1.1 hub, the sm215 hub, and The Purifier to the installables.

|br|

* Updates to the docs about vkQuake and transparent water.

|br|

* Add mention of the Ironwail engine into the docs where appropriate, and detection of ironwail.exe for multigame support.

|br|

* Add some brief discussion of the Quake rerelease.

|br|

* Add some brief discussion of alternate Quake Injector projects that don't require Java.

|br|

* Make the latest version (1.17) of Copper installable, and do a few things to more gracefully handle new releases and outdated versions of AD and Copper:

  - If a newer version of AD/Copper is released before the next Quakestarter update, you can set this in your _quakestarter_cfg.cmd in order to make that newer version be the one that Quakestarter uses by default for relevant mod dependencies. See the comments in _quakestarter_cfg_defaults.cmd for the latest_ad and latest_copper settings.
  - You can manage any older installed versions of AD/Copper through the legacies menu, IF these are old versions that existed at the time of the Quakestarter release that you're using. So e.g. with this release you can do legacy-mod-management for AD 1.7, Copper 1.15, and Copper 1.16.
  - If you have previously run an AD/Copper-dependent mod using an older version of AD/Copper, the mod launch will give you the option to continue using that older AD/Copper version in order to not break your savegames. You'll keep getting that option for each launch of that mod until you choose to switch to using the latest AD/Copper for that mod.


.. rubric:: v2.2.1 (Mar 2021)

Tiny update here. This just adds a very-most-top-level short readme file ("how_to_use_quakestarter.txt") into the zip archive for a release, to make sure users know where to go first. It's nice for the archive to be self-contained in this way and not require any external info to get started with it properly.


.. rubric:: v2.2.0 (Mar 2021)

* Include latest Quakespasm-Spiked (2021-03-06).

|br|

* Add the SMEJ2 episode, the Unused Jam, and Imhotep's Legacy to the installables.

|br|

* If you use _quakestarter_cfg.cmd to set your own quake_exe value, that value can now include any command-line arguments that should always be used.

|br|

* Default to skill 1 rather than skill 2 in autoexec.cfg.example.

|br|

* Set r_wateralpha to 0.65 for retrojam6; it's necessary for one of the maps (retrojam6_mjb) and doesn't hurt the others.

|br|

* Misc minor docs corrections and fixes.


.. rubric:: v2.1.0 (Jan 2021)

Most of the changes in this release are because of me revisiting the cool `qbism Super8 engine`_ and taking care of some quirks that prevented it from working well as an alternative Quake engine launched from Quakestarter. Note that there is absolutely no guarantee that Super8 will be able to play all of our installables... but it should be able to handle most of them.

* Various doc changes to accomodate Super8 differences.

|br|

* Implement an "auto" setting for multigame_support (and make it the default). This will look at the Quake engine program name to try to figure out whether and how it handles activating multiple mod folders. The old "true" and "false" settings still exist as well. There's also the ability to exactly specify the multigame support syntax that your Quake engine uses. See the "quakestarter_docs\\other_stuff\\mod_requirements.txt" and "quakestarter_docs\\other_stuff\\advanced_quakestarter_cfg.txt" docs for details.

|br|

* Don't put quote marks around any of the command-line arguments sent to the Quake engine. Engines that still use the original command-line parsing code (e.g. Super8) won't be able to handle that.

|br|

* Work around some Super8 bugs in how it handles startdemos.

|br|

* Put a couple of mod content patches (for "Epochs of Enmity" and "Warpspasm") into pak files, rather than leaving them as loose files. In these two cases the existing mod content is also in pak files, so if we want to modify/override that content we should pak up the new bits too. For Quakespasm-Spiked this actually is not necessary, as QSS will prioritize "loose files" over pak file contents, but for almost all other Quake engines it is necessary.

|br|

* Supply smaller quake.rc files for Arcane Dimensions and any releases based on AD, so that they can work in Super8 (and any other Quake engine that retains the original limits on the amount of config text that can be executed). These quake.rc files still function the same; they're just way less chatty. The originals are still available there for reference.

|br|

* Make autoexec.cfg.example a lot smaller and slightly more opinionated. This helps with engines like Super8 that have strict limits on the amount of initial config stuff that can be executed through quake.rc; it's now slightly nicer/easier to just instantly rename and start using this file; and I don't have to keep trying to maintain cut-down versions of the discussions in the annotated version.

|br|

* Add the Blue Monday Jam to the installables (episodes/hubs, new hotness menu).

|br|

* Always some doc improvements here and there!


.. rubric:: v2.0.2 (Dec 2020)

* Final pass through 2020 releases looking for installables. The only change is to add Xmas Jam 2020.

|br|

* Improve (again) the documentation of transparency-related settings in the example autoexec.cfg files.

|br|

* A little discussion about vkQuake not supporting the two described gl\_ console vars.

|br|

* Other minor docs/messages updates.


.. rubric:: v2.0.1 (Dec 2020)

* Improve the documentation of transparency-related settings in the example autoexec.cfg files.

|br|

* Provide a bundle WITHOUT Quakespasm-Spiked as an alternative download for power users.


.. rubric:: v2.0.0 (Nov 2020)

Before we get into the bullet-point changelist, a general note:

`Quakespasm-Spiked`_ is now the bundled Quake engine, rather than Mark V.

Mark V is no longer in development and has issues on some new maps with performance or even being able to run the map at all. QSS is better on those fronts, and has added bonuses like multi-gamedir support, unlocked-framerates support, and no dependence on an old DirectX runtime. Plus optional particle and HUD features for Arcane Dimensions.

One downside of QSS compared to Mark V is that its in-game menus are not as nice/useful. Another downside is that QSS is not compatible with some of the truly quirky older releases that Mark V supports; however the only one of those releases that had been included in the Quakestarter menus was Nehahra. Losing Nehahra support is unfortunate, but on balance QSS is still the right choice for bundling with Quakestarter now.

Of course even though QSS is now the bundled Quake engine, you will still be able to use Mark V or vkQuake or any other engine you prefer -- you'll just have to download and install that other Quake engine yourself, then configure Quakestarter to use it. More about that below and in the docs.

Because we can't depend on Mark V any longer, we can't use its features for downloading and installing mods. So that functionality has been moved into the installer scripts. One consequence of this: previously only the bundled Simple Quake Launcher 2 had a dependence on Microsoft .Net Framework version 4.5 or later, but now the installer scripts also have that dependence. So we have well and truly left behind any support for Windows XP. (Another consequence is that downloads are now faster!)

OK, let's get to the changelist.

* As mentioned above, QSS is now bundled instead of Mark V. QSS is made up of several files; see "qss_manifest.txt" for a list.

|br|

* The main script to run is now named "quakestarter.cmd" rather than "installer.bat".

|br|

* The "readmes" folder is now named "quakestarter_docs".

|br|

* Other files and folders have had name changes too, so if you are replacing an older version of Quakestarter you should generally just delete its files entirely (while leaving the rest of your Quake installation intact) and then put these new files in place. The doc about upgrading between Quakestarter versions ("quakestarter_docs\\other_stuff\\upgrading_quakestarter.txt") has more details.

|br|

* Option added in the main menu to just launch Quake. A nicety to set up initial config without having to go outside Quakestarter.

|br|

* The soundtrack installer can now find and copy existing files from other Quake installations on your computer, much like the pak installer does. It can still also download soundtrack files from the net, as before.

|br|

* Downloaded soundtrack files now include both ogg and mp3 versions.

|br|

* The number of installable mods has increased from 58 to 75. This comes from adding 23 new installables and dropping 6 that no longer qualify or have been superceded.

|br|

* Previously, recent releases had not been included in the installer menus because their ratings are still in flux. However that's now changed, with "The New Hotness" menus for recent highly-rated releases (with the understanding that they may later be dropped).

|br|

* Mods dropped from the main installer menus can now still be accessed/played/managed if you like. See the comments about "legacy" releases in "quakestarter_scripts\\_quakestarter_cfg_defaults.cmd". Behind the scenes I've also made several changes that will make it easier for me to put out updated versions of Quakestarter more quickly, and also make it easier for users to update from version to version. So it should be more acceptable to have more frequent changes to the set of installables.

|br|

* The default configurations for many mods have been improved slightly. If you have one of these mods already installed, you probably don't need to worry about this if it is working fine for you, but the doc about upgrading between Quakestarter versions ("quakestarter_docs\\other_stuff\\upgrading_quakestarter.txt") has more details.

|br|

* You can create a config file to customize a few behaviors of Quakestarter now, as described in the "quakestarter_docs\\other_stuff\\advanced_quakestarter_cfg.txt" doc. One such customization is the name of the Quake program to run, if you don't want to use the bundled Quakespasm-Spiked.

|br|

* You can also customize whether mods that include a unique "startdemos" loop will run that demo loop when the mod is launched. This will work regardless of whether your Quake engine typically plays a startdemos loop (as Quakespasm variants do not, by default).

|br|

* See "quakestarter_scripts\\_quakestarter_cfg_defaults.cmd" for other behaviors you can customize.

|br|

* When Quakestarter launches a mod, info about the Quake engine and launch args is now stored in "_last_launch.cmd" in the mod folder. Currently this is just informative, but it may be used by future Quakestarter versions.

|br|

* Support finding Bethesda.net installs of Quake (when looking for pakfiles).

|br|

* Slightly more robust search for GOG Galaxy installs of Quake (when looking for pakfiles).

|br|

* "autoexec.cfg.example" and the annotated version have been rewritten to be less Mark V - centric, and to include discussion of host_maxfps.

|br|

* In general the docs have been improved and corrected.

|br|

* Support for Windows Vista has been officially dropped. It probably still works though?


.. rubric:: v1.x

For older changelog entries, see the `1.x changelog`_ archived on GitHub.


.. _quakestarter.com: http://quakestarter.com
.. _Quake Sewer Jam: https://www.quaddicted.com/reviews/sewerjam.html
.. _vkQuake: https://github.com/Novum/vkQuake
.. _Ironwail: https://github.com/andrei-drexler/ironwail
.. _Slipgate Sightseer: https://www.slipseer.com/
.. _Remaster Textures: https://www.quaddicted.com/reviews/sm_217.html
.. _Slip Tripping: https://www.quaddicted.com/reviews/markiesm1v2.html
.. _Markie: https://www.quaddicted.com/reviews/?filtered=markie
.. _Quake Builder: https://www.youtube.com/user/mikedm92
.. _Markie Music: https://www.youtube.com/c/MarkieMusic
.. _Waldsterben: https://www.quaddicted.com/reviews/plaw02.html
.. _Paul Lawitzki: https://www.quaddicted.com/reviews/?filtered=paul+lawitzki
.. _Copper: http://lunaran.com/copper/
.. _January Jump Jam 2: https://www.quaddicted.com/reviews/jjj2.html
.. _Alkaline: https://alkalinequake.wordpress.com/
.. _The Elder Reality: https://www.quaddicted.com/reviews/retrojam4dlc_pulsar.html
.. _PuLSaR: https://www.quaddicted.com/reviews/?filtered=pulsar
.. _Deathmatch Classics Vol. 3: https://www.quaddicted.com/reviews/dmc3.html
.. _A Roman Wilderness Of Pain: https://www.quaddicted.com/reviews/arwop.html
.. _Tronyn: https://www.quaddicted.com/reviews/?filtered=tronyn
.. _retrospective about this mapset: https://www.quaddicted.com/articles/a_history_of_a_roman_wilderness_of_pain_1999-2009_by_tronyn_2009
.. _This Onion: https://www.quaddicted.com/reviews/fmb_bdg.html
.. _Mike Woodham: https://www.quaddicted.com/reviews/?filtered=mike+woodham
.. _its sequel/remake: https://www.quaddicted.com/reviews/fmb_bdg2.html
.. _Antediluvian: https://www.quaddicted.com/reviews/ant.html
.. _Rubicon: https://www.quaddicted.com/reviews/?filtered=metlslime+rubicon
.. _Quake engine: https://celephais.net/fitzquake/
.. _func_msgboard: https://www.celephais.net/board/forum.php
.. _Quake Condensed: https://www.quaddicted.com/reviews/rpgsmse.html
.. _R.P.G.: https://www.quaddicted.com/reviews/?filtered=R.P.G.
.. _Biotoxin: https://www.quaddicted.com/reviews/czgtoxic.html
.. _czg: https://www.quaddicted.com/reviews/?filtered=czg
.. _Arcane: https://www.quaddicted.com/reviews/arcane.html
.. _Matt Sefton: https://www.quaddicted.com/reviews/?filtered=matt+sefton
.. _The Castle of Koohoo: https://www.quaddicted.com/reviews/koohoo.html
.. _Koohoo-themed retrojam: https://www.quaddicted.com/reviews/retrojam7.html
.. _sm198: https://www.quaddicted.com/reviews/sm198.html
.. _a GitHub issue: https://github.com/neogeographica/quakestarter/issues/58
.. _qbism Super8 engine: https://super8.qbism.com/
.. _Quakespasm-Spiked: https://fte.triptohell.info/moodles/qss/
.. _1.x changelog: https://raw.githubusercontent.com/neogeographica/quakestarter/v1.10/CHANGELOG.txt
