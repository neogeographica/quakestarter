Changelog
=========

.. rubric:: v3.1.0 (Jun 2022)

This release is purely about updating the lists of installables. A couple of recent releases have popped up just over the ratings threshold, but interestingly so have several older releases all the way back to 1997. Here's a rundown of the changes:

blah blah lorem ipsum fill this in once the list is finalized


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


.. _The Castle of Koohoo: https://www.quaddicted.com/reviews/koohoo.html
.. _Koohoo-themed retrojam: https://www.quaddicted.com/reviews/retrojam7.html
.. _sm198: https://www.quaddicted.com/reviews/sm198.html
.. _a GitHub issue: https://github.com/neogeographica/quakestarter/issues/58
.. _qbism Super8 engine: https://super8.qbism.com/
.. _Quakespasm-Spiked: https://fte.triptohell.info/moodles/qss/
.. _1.x changelog: https://raw.githubusercontent.com/neogeographica/quakestarter/v1.10/CHANGELOG.txt
