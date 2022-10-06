Pak Files
=========

What are pak files?
-------------------

A "pak" file is a collection of Quake game data. To play the original Quake campaign using a modern Quake program, all you need are two files from the original Quake game content: "pak0.pak" and "pak1.pak". They're sometimes also named "PAK0.PAK" and "PAK1.PAK".

Inside the folder that holds your Quake program, you will need a folder named "id1". Create that folder if necessary. Then put the two pak files inside of "id1". You're ready to play!

Similarly each of the official missionpacks has a "pak0.pak" file that you need in order to play that expansion:

* To play missionpack 1, Scourge of Armagon, you need a folder named "hipnotic" inside your Quake folder. Inside the "hipnotic" folder you need the "pak0.pak" file from missionpack 1.

|br|

* To play missionpack 2, Dissolution of Eternity, you need a folder named "rogue" inside your Quake folder. Inside the "rogue" folder you need the "pak0.pak" file from missionpack 2.

If you already have your pak files and are ready to go, you don't need to read the rest of this. Otherwise:


Getting the pak files from a Quake installation
-----------------------------------------------

If you already have Quake installed somewhere on this computer, or if you are able to install Quake now (e.g. from Steam or GOG), then that will be the easiest way to get these files. The first menu option in Quakestarter will find that Quake installation and copy the necessary files from it. If you're curious about how Quakestarter looks for those files, check out the :doc:`Auto Setup Logic<auto_setup_logic>` chapter.

If that process can't find your Quake pak files, you can go look for them yourself. They will be inside a folder named "id1", which itself is inside your Quake install directory. So find and open up the "id1" folder, then make the copies you need of "pak0.pak" and "pak1.pak". Similarly if you have one or both of the missionpacks installed, you can get the "pak0.pak" file out of the "hipnotic" and/or "rogue" folder inside an existing Quake installation.

If you're manually copying pak files into a Quakestarter-managed Quake installation, you should also be careful to get the pak files from the original Quake and not the rerelease. You can easily tell the difference since the "id1" folder in the rerelease only contains "pak0.pak" and does not have a "pak1.pak". As of the last update to this part of the docs (April 2022), various stores provide original and/or rereleased Quake as follows:

* Steam provides the original Quake and also the rerelease (in a "rerelease" subfolder)
* GOG provides only the original
* Xbox Game Pass provides only the rerelease
* Epic Games Store provides only the rerelease
* Bethesda (store now shut down) provided only the rerelease


Getting the pak files from a Quake CD
-------------------------------------

If all you have is a Quake CD, and the CD's installer no longer works on your version of Windows, then you can try to get the pak files directly from the CD.

There were several different kinds of Quake CDs produced. In some cases you may be able to search through the CD's files and find the necessary pak files ready for you to copy.

If you don't see the pak files on the CD, I'd recommend getting in touch with a Quake-owning friend and asking for copies of the pak files from them. You're a legit Quake owner so there's nothing wrong with that.

If *that* doesn't work out for some reason, then:

If you see a file named "RESOURCE.1" on your CD, you can extract the pak files from inside that archive, as described `on the Steam forums`_.

If you see a couple of files named "QUAKE101.1" and "QUAKE101.2", I'd guess it would be possible to concatenate those files together (e.g. "type QUAKE101.1 QUAKE101.2 > RESOURCE.x") and use lha or 7-Zip on that resulting file, similar to the process described in the link above. I haven't tried that myself though, and I'm not sure if the concatenated file name matters and if so whether it should be named RESOURCE.x, RESOURCE.1, or something else.


.. _on the Steam forums: http://steamcommunity.com/app/2310/discussions/0/558750717183948274/
