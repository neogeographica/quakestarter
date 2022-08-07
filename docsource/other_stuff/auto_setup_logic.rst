Auto Setup Logic
================

The first and second options in the Quakestarter main menu help you get set up with the Quake game data (required) and soundtrack (optional).

If you already have an installation of the original Quake game somewhere on the same computer, Quakestarter can probably find it and use it to source the necessary files. Usually/hopefully this should be a pretty automatic process, and you shouldn't need to look under the hood! But just in case it's helpful, this chapter contains more details of how it works.


Stores cheat-sheet
------------------

If you just want to know how Quake installations from various stores can help the Quakestarter auto-setup, here's the bottom line about the files that those store installations provide (as of the last time this doc was updated, August 2022).

* The original Quake pak files (game data) are provided by Steam and GOG.

|br|

* Quake soundtrack files (from the Quake rerelease) are provided by Steam, Bethesda, and Xbox Game Pass.

So for example if you don't have any other Quake installations on your computer and don't have any Quake paks or soundtrack files on hand, doing an installation of Quake from Steam is the simplest one-shot way to fetch everything you need. After doing the Steam install you could then run Quakestarter and auto-setup the pak files and soundtrack into your new modern Quake singleplayer installation.


How Quakestarter knows where to look
------------------------------------

When Quakestarter wants to copy a file or directory from some existing Quake installation, it will run through a series of candidate locations. Each time it finds something that looks good, it asks you if you want to copy the necessary file/directory from that location. If you say no, it keeps looking.

The first steps in this process involve checking the Windows registry for installations from Steam, GOG, or Bethesda. (The info for Xbox Game Pass installations is not in the registry.)

If Quakestarter doesn't get the file from any of those places, it then checks 1) on every disk, 2) across a set of top-level folders, for each of 3) a list of likely paths under those top-level folders.

The top-level folders checked on each disk are:

* Program Files (x86)
* Program Files
* Games
* ...and just the top folder on the disk

The paths checked under each of those folders are:

* Quake
* Quake\\rerelease
* QUAKE\\Content
* Steam\\steamapps\\common\\Quake
* Steam\\steamapps\\common\\Quake\\rerelease
* GOG Games\\Quake
* GOG Galaxy\\Games\\Quake
* Bethesda.net Launcher\\games\\Quake
* XboxGames\\QUAKE\\Content

(Some of these locations are specifically for the Quake rerelease rather than the original game; those locations are helpful for locating soundtrack files but not for the original pak files.)

If you know of some other place that Quakestarter should reasonably be looking for Quake installations, let me know!


Pak files
---------

One kind of thing that Quakestarter can locate in Quake installations is the necessary game data (maps, models, sounds, etc.). This data is stored in files with the ".pak" extension.

The original Quake campaign requires "pak0.pak" and "pak1.pak" in the "id1" subfolder. Missionpack 1 requires a "pak0.pak" in the "hipnotic" subfolder. Missionpack 2 requires a "pak0.pak" in the "rogue" subfolder. So Quakestarter can be used to find and copy all of those, starting from option 1 on the main menu.

Note that when Quakestarter looks for pak files, it checks the files (using an MD5 checksum) to make sure they are the right files. This means for example that it will not grab pak files from the Quake rerelease, since those pak files are different from the originals. In the case of "id1\\pak0.pak" Quakestarter also specifically looks for the last version of "pak0.pak" (1.06) that was shipped for Quake, not any earlier version. If Quakestarter seems to be ignoring an available pak file it might be because that file doesn't have the right checksum.

Pak files are described in more detail in the :doc:`Pak Files<pak_files>` chapter, including methods of getting pak files if Quakestarter can't find them automatically.


Soundtrack files
----------------

The other setup files that Quakestarter can help you with are the soundtrack files for the original campaign and missionpack. These files are always stored in a "music" subfolder inside "id1", "hipnotic", and/or "rogue".

Valid soundtrack files can be of various types (e.g. MP3 or OGG) and can come from various sources. So it's not feasible or even desirable for Quakestarter to do a checksum of these files to validate them. Instead, if Quakestarter finds any "music" subfolder in the right place, it will always just ask you if that's the one you want to copy and use.

If Quakestarter get to the end of the file search process without successfully copying the "music" folder that it is looking for, it will give you the option to download those soundtrack files from Quaddicted.

**Note:** Now that official soundtrack files are available from the Quake rerelease, this download option may be removed from Quakestarter in the future.

Also keep in mind that if you still have your physical Quake CD, or a CD image (for example from GOG), you can rip the tracks yourself. This gives you ultimate control over the quality and settings for the rip. Soundtrack files start with track 2 of the CD and are named in the format "track02.ogg" or "track02.mp3".
