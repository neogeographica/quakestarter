Updating Quakestarter
=====================

Read this part first!
---------------------

The update logic in Quakestarter was introduced in version 3.3.0. If you are updating from an earlier version of Quakestarter, skip to the :ref:`"Completely manual update"<other_stuff/upgrading_quakestarter:completely manual update>` section at the bottom of this page.

If you're updating from version 3.1.0 or earlier, where Quakespasm Spiked is the bundled Quake engine, you'll also want to read the notes for version 3.2.0 in the :doc:`Changelog<changelog>` so that you can decide how you want to handle the transition to vkQuake/Ironwail.

Autoupdate
----------

In its default configuration, Quakestarter will automatically check to see if there is a newer version available. This happens the first time you run Quakestarter on a given day.

If you would rather turn off autoupdates, you can put this line in your "_quakestarter_cfg.cmd" file::

    set check_for_updates=false

(See the :doc:`Advanced Configuration<advanced_quakestarter_cfg>` chapter for more about this config file.)

If you do turn off autoupdates, you should skip ahead to one of the sections below that talks about more hands-on ways of updating Quakestarter.

But if you leave autoupdates enabled, then sooner or later when you run Quakestarter you will see the message "A newer version of Quakestarter is available!" at the top of the window. Before proceeding to the normal Quakestarter menus, you'll be given the option to open the new changelog in your web browser to see info about the new release, and then you can choose whether or not to update to that new version of Quakestarter.

**Note:** If you say "no" to updating, Quakestarter will ask you again when you run it on a later day. There's currently no way to record a preference of "permanently skip that version and stop asking me". If you want Quakestarter to stop telling you that there is a new version available, you'll need to turn off autoupdates as described above.

Once you've decided to get the new version, Quakestarter will ask you if you want to include the Quake engine files (for vkQuake and Ironwail) in the downloaded update package. Normally you will want to enter **y** for "yes", especially if you are currently using the Quakestarter-installed vkQuake and Ironwail engines. Even if the engine versions haven't changed in this new update, they're small files and it's simplest just to get them again.

Once the update is done, Quakestarter will relaunch with the new version. That's pretty much all there is to it, in the usual case. Now though we'll cover a couple of less-common topics: Quakestarter "management" of the Quake engine files, and what to do if the update fails.

Quake engine management
~~~~~~~~~~~~~~~~~~~~~~~

Quakestarter keeps track of which Quake engine files it is responsible for dealing with when autoupdating. We'll call these the "Quakestarter-managed" Quake engines. A normal Quakestarter installation is managing the files for vkQuake and Ironwail; a "noengine" installation is not managing anything.

The autoupdater allows you to choose whether to download the engine files that are part of the incoming update. If you enter **y** for "yes", Quakestarter will first delete any engine files it is currently managing, then put the new engine files into place and start managing those. If you enter **n** for "no", things are still straightforward if Quakestarter is *not* currently managing any engine files (it just... continues to not manage anything).

But what if Quakestarter *is* currently managing some engine files and you say "no" you don't want to download the new ones? What does that mean for the currently managed files? In that case the autoupdater will give you three choices; the choices are summarized in the menu there, but here's more detail about them.

* KEEP: This choice means that you want to keep the files for the currently managed Quake engines, and keep Quakestarter managing them. Essentially you don't want to accept the version of vkQuake/Ironwail that's in the new Quakestarter update (for whatever reason) but you want to keep it easy to update those engines as part of some future Quakestarter update. The end result of this choice is really the same as if your current engine files were part of the Quakestarter update.

|br|

* DETACH: You don't want to erase your current engine files, but you also don't want Quakestarter to manage them anymore. The end result of this choice is the same as if you had done a "noengine" installation and then manually put your current versions of vkQuake and Ironwail into your Quake folder.

|br|

* ERASE: You want to get rid of your current engine files. Maybe you'd rather manually install something else, who knows? The end result of this choice is the same as if you had done a "noengine" installation.

If update fails
~~~~~~~~~~~~~~~

Hopefully you won't ever need to read this section, but realistically there are several points where things can go wrong.

If an error happens at some point in the process up through the download of the update package, and you can't figure out how to resolve the problem, then you can try the update process in the :ref:`"Update from downloaded archive"<other_stuff/upgrading_quakestarter:update from downloaded archive>` section below.

It's possible that an error happens after the download, but before the actual update process is attempted. E.g. perhaps the extraction of files from the downloaded zipfile failed for some reason. As long as Quakestarter is still able to launch and run normally, you could try the update process in the :ref:`"Completely manual update"<other_stuff/upgrading_quakestarter:completely manual update>` section below.

If an error happens partway through the update, Quakestarter will tell you about it and refuse to run. In this situation you will see a "quakestarter_update" folder in your Quake folder. Your original files will be in the "quakestarter_update\\backup" folder, and the intended new files are in the "quakestarter_update\\unpacked\\Quake" folder. At this point you can choose to either manually move your original files back into place, or try putting the new files into place with the "Completely manual update" process. In either case, once you're done you must delete the "quakestarter_update" folder so Quakestarter will know that it is good to go.

If you do encounter update problems, it would be appreciated if you report them `at the Quakestarter GitHub repo`_, with as much detail as possible about the error you experienced. If you're in a situation where the "quakestarter_update" folder exists, you can also provide the "update.log" file from that folder or even zip up that whole folder and provide it for examination.

Update from downloaded archive
------------------------------

Instead of using autoupdate, you may want or need to download the latest Quakestarter zipfile yourself from the `Quakestarter website`_. In that case, you can drag-and-drop that downloaded zipfile onto the "quakestarter.cmd" script of your current installation, and Quakestarter will execute the update process.

Most of the autoupdate description above will still apply to this method; you're just skipping the update detection and download. The rest of the process is the same.

**Note:** If you drop an *older* Quakestarter zipfile onto "quakestarter.cmd", it will refuse to do the update. The update process can only be used to go to a newer version. If you need to "downgrade" Quakestarter, you can likely do that successfully with the "Completely manual update" process described below.

Completely manual update
------------------------

Before Quakestarter got an update feature, the update process was just "download the new zipfile from the `Quakestarter website`_, then unzip the new files over top of the old files". That still works! So if you want to completely avoid the update logic in Quakestarter, you can do that.

A word of warning though. If Quakestarter is currently managing some engine files, and you overwrite it with the files from a "noengine" zipfile, you are implicitly making the DETACH choice described above (under "Quake engine management").


.. _at the Quakestarter GitHub repo: https://github.com/neogeographica/quakestarter/issues
.. _Quakestarter website: http://quakestarter.com
