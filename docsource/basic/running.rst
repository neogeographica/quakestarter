Running
=======

Launching with Quakestarter
---------------------------

Quakestarter is meant to help you get your Quake installation set up and then to manage and play various addons.

Other than the "Basic setup" section of the main menu (whose options were already described in :doc:`Installation<installation>` and :doc:`Configuration<configuration>`), the rest of the choices in the main Quakestarter menu will take you to pages where you can choose to install and play these addons. There are three other main sections:

  * In "The Latest Greatest" list, you'll see a subjective selection of the buzz-iest releases of the past six months. (Depending on the rating that a release has accumulated so far, it may also appear in one of the other sections below.)

|br|

  * Each choice in "Additional episodes/hubs" leads to a list of good-sized map collections that include a starting map, which either leads you into a linear sequence of other maps or else acts as a hub from which you can explore the other maps of the addon in any order.

|br|

  * Each choice in "Other highly-rated releases" leads to a list of single map releases or map collections that don't qualify as an episode or hub.

(If you want to learn more about how these list items were selected, see the :doc:`Selection Criteria<../other_stuff/selection_criteria>` chapter.)

Once you get to a page that shows a list of addons, each item in the list will have an asterisk in front of it if it is already installed. If you select an item that is not currently installed, Quakestarter will: install any missing dependencies, install the addon itself, add any necessary patches/fixes that have been released for the addon, and perhaps apply an initial recommended configuration for it.

After that sequence has finished (or if you select an already-installed addon from the menu), Quakestarter will give you options that allow you to launch or uninstall the addon, or return to the previous menu. These options should be pretty self-explanatory, but they're covered in more detail in the :doc:`Running With Quakestarter<../maps_and_mods/running_with_quakestarter>` chapter.

**Note:** If you use Shift+Enter to submit your choice, rather than just Enter, then Quakestarter will open the Quaddicted review page for that choice rather than going into the usual install/manage/launch process -- or in the Latest Greatest menu, it may show some other webpage if the release is not on Quaddicted yet. If you do this, keep Shift pressed down until the web page opens. (This will happen quickly, so don't sit around forever jamming on that Shift key if something goes wrong.) The web page will be opened with whatever web browser is registered with Windows as the default.

Using Quakestarter is the easiest way to correctly launch these addons, but it can only run the same addons that it knows how to install. Once you branch out into playing other stuff, you'll need to use Simple Quake Launcher 2 or other methods.


Launching with SQL2
-------------------

Simple Quake Launcher 2 is another great way to start up Quake. It's not as easy as Quakestarter for some things, but it's more flexible.

When you run "SQLauncher2.exe", you'll get a dialog window with a few settings to choose.

The first thing to choose is the "Engine", i.e. your Quake-playing program. You can pick "vkQuake.exe" or "ironwail.exe" to use one of the bundled engines, or select some other Quake engine that you have installed yourself.

Don't worry about the "Resolution" setting; you can pick your video settings in the in-game menus.

The "Game" setting lets you choose the basic set of game content, and the "Mod" setting optionally chooses a folder of additional content to add to it.

The launcher has other options that allow you to jump directly into individual maps using a specified skill (difficulty) setting. You don't need to worry about that if you're starting the Quake campaign from the beginning, since that campaign allows skill selection inside the startmap. The official missionpacks and some custom episodes also have startmaps with in-game skill selection.

When you've picked what you want to play, click the big "Launch" button at the bottom, and away you go!

Running the original campaign or missionpacks with this launcher is easy; running a mod can be easy as well but there are a few other things to consider. These considerations are described in more detail in the :doc:`Running With SQL2<../maps_and_mods/running_with_sql2>` chapter. If you don't have previous experience with running Quake mods, it might be good to use Quakestarter for a bit first.
