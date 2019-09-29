### Things you need

 * A running [Kodi](https://kodi.tv/) installation. Currently AML works well on Linux and Windows.

 * A working MAME installation. This includes the MAME executable and associated files, the ROM ZIP files and the ROM artwork.

### Installing the stable version

Advanced MAME Launcher is now available in the
[Kodi Official Addon repository](https://kodi.tv/addon/plugins-program-add-ons/advanced-mame-launcher-0).
To install the latests release AML version follow the instructions in the
[Kodi wiki](https://kodi.wiki/view/Add-on_manager). Advanced MAME Launcher is inside the
category **Program add-ons**.

### Installing the development version from Github

The development version of AML is a separate addon from the stable version. Both can be
coinstalled on the same Kodi machine and won't interfere with each other. In other words,
changing settings in the development version will not affect your stable AML installation.

The name of the AML stable version is **Advanced MAME Launcher** and the name of the
development version is **Advanced MAME Launcher (dev version)**.

It is important that you follow this instructions or the Advanced MAME Launcher development
version won't work well.

  1) In this page click on the green button `Clone or Download` --> `Download ZIP`

  2) Uncompress this ZIP file. This will create a folder named `plugin.program.AML.dev-master`

  3) Rename that folder to `plugin.program.AML.dev`.

  4) Compress that folder again into a ZIP file named `plugin.program.AML.dev.zip`.

  5) In Kodi, use that ZIP file (and not the original one) to install the addon.

  6) If you get a warning message dialog `For security, installation of add-ons from
     unknown sources is disabled.` then click on `Settings` button and then activate
     the option `Unknown sources`.

### Updating AML

From time to time newer versions of AML will be released. If you are running the stable version of the addon from the Kodi Official Addon repository then AML will be updated automatically. After the AML upgrade, sometimes you will need to do something, for example rebuilding the databases, to complete the upgrade process. Have a look at the release notes in [Advanced MAME Launcher thread](https://forum.kodi.tv/showthread.php?tid=304186) in the Kodi forum for more information about upgrading specific AML versions. In general, after an upgrade it is always a good idea to rebuild all the databases and scan everything.

If you are running the development version you need to manually do the upgrade.

If you are upgrading MAME, your ROMs or the assets, then have a look to [Upgrading MAME, ROMs or Assets](Upgrading-MAME,-ROMs-or-Assets).
