This page describes how to configure AML with all the features and options available. Depending on the features you need, you may choose which of the optional features you want although it is recommended that you setup everything.

#### Table of Contents ####

 * [Recommended directory layout](#recommended-directory-layout)
 * [Notes for Windows users](#notes-for-windows-users)
 * [Setting up MAME ROM ZIPs](#setting-up-mame-roms-optional)
 * [Setting up MAME Samples (Optional)](#setting-up-mame-samples-optional)
 * [Setting up MAME CHDs (Optional)](#setting-up-mame-chds-optional)
 * [Setting up MAME INI files (Optional)](#setting-up-mame-ini-files-optional)
 * [Setting up MAME DAT files (Optional)](#setting-up-mame-dat-files-optional)
 * [Setting up MAME Assets (Optional)](#setting-up-mame-assets-optional)
 * [Setting up Software Lists ROMs (Optional)](#setting-up-software-lists-roms-optional)
 * [Setting up Software Lists CHDs (Optional)](#setting-up-software-lists-chds-optional)
 * [Setting up Software Lists Assets (Optional)](#setting-up-software-lists-assets-optional)
 * [Configuring AML](#configuring-AML)
 * [Setting up AML (Easy mode)](#setting-up-aml-easy-mode)
 * [Setting up AML](#setting-up-aml)
 * [Setting up AML (Advanced mode)](#setting-up-aml-advanced-mode)

### Recommended directory layout ###

This is the recommended MAME directory layout. You have to create all the directories yourself, AML does not create any directory automatically.

| Name       |  Directory |  Notes     |
| :--------- | :--------- | :--------- |
| **ROM path**     | `/home/kodi/MAME-ROMs/`    | <sub>Place MAME arcade ROM, BIOS and device ZIP files here.</sub> |
| **Asset path**   | `/home/kodi/MAME-assets/`  | <sub>(Optional) Place MAME and Software Lists assets here.</sub> |
| **DAT/INI path** | `/home/kodi/MAME-DATs/`    | <sub>(Optional) Place DAT/INI files here.</sub> |
| **CHD path**     | `/home/kodi/MAME-CHDs/`    | <sub>(Optional) Place the CHDs here</sub> |
| **Samples path** | `/home/kodi/MAME-samples/` | <sub>(Optional) MAME sample ZIP files.</sub> |
| **SL hash path** |                            | <sub>(Optional) Software Lists XML files.</sub> |
| **SL ROM path**  | `/home/kodi/AML-SL-ROMs/`  | <sub>(Optional) Place the Software Lists ROMs here</sub> |
| **SL CHD path**  | `/home/kodi/AML-SL-CHDs/`  | <sub>(Optional) Place the Software Lists CHDs here</sub> |

Remember to update your `mame.ini` configuration file to point to the correct directories where you have placed your ROM ZIP and CHD files. Otherwise MAME won't work at all.

If MAME the MAME runtime files are installed in `/home/kodi/bin-mame/` then you will need to modify your `mame.ini` like in this example:
```
#
# CORE SEARCH PATH OPTIONS
#
homepath        $HOME/.mame
rompath         /home/kodi/MAME-ROMs;/home/kodi/MAME-CHDs;/home/kodi/MAME-SL-ROMs;/home/kodi/MAME-SL-CHDs
hashpath        /home/kodi/bin-mame/hash
samplepath      /home/kodi/bin-mame/samples;/home/kodi/MAME-samples
artpath         /home/kodi/bin-mame/artwork;/home/kodi/MAME-assets/artwork
ctrlrpath       /home/kodi/bin-mame/ctrlr
inipath         $HOME/.mame
fontpath        /home/kodi/bin-mame/fonts
cheatpath       /home/kodi/bin-mame/cheats
crosshairpath   /home/kodi/bin-mame/crosshairs
pluginspath     /home/kodi/bin-mame/plugins
languagepath    /home/kodi/bin-mame/language
swpath          software
```

Note that the `rompath` includes all directories that contain game files.

### Notes for Windows users ###

The instructions in this guide focus on Linux because it is the operating system used for development and testing of AML. Windows users just need to adapt the Linux paths and filenames to a Windows format configure their setup. For example, let's assume that you install MAME version 0.207 on `E:\MAME 0.207\` and you want to place all MAME files on unit `E:`. Then:

| Linux path             | Windows path    |
|------------------------|-----------------|
| `/home/kodi/MAME-ROMs` | `E:\MAME-ROMs\` |

### Setting up MAME ROM ZIPs ###

Place your compressed ROMs ZIP files in the `/home/kodi/MAME-ROMs/` directory.

### Setting up MAME Samples (Optional) ###

Place the compressed MAME Samples into the `/home/kodi/MAME-samples/` directory.

You can download a complete set of MAME Samples from [Progretto SNAPS](http://www.progettosnaps.net/samples/).

### Setting up MAME CHDs (Optional) ###

Place you CHD files in the `/home/kodi/MAME-CHDs/` directory.

The CHDs of a machine must be in a subdirectory with the same name as the machine. For example, the machine `sfiii` **Street Fighter III: New Generation (Euro 970204)** has a CHD named `cap-sf3-3`. You must place this CHD in the path `/home/kodi/AML-CHDs/sfiii/cap-sf3-3.chd`.

Note that many CHD collections already follow this convention so you only have to copy all the files to `/home/kodi/MAME-CHDs/`.

### Setting up MAME INI files (Optional) ###

All INI files are optional and enable additional MAME filters.

 * If you configure `bestgames.ini` then the filter **Machines by Score** becomes available.

   You can download this file from [progretto-SNAPS](http://www.progettosnaps.net/bestgames/).

 * If you configure `catlist.ini` then the filter **Machines by Category (Catlist)*** becomes available.

   You can download this file from [progretto-SNAPS](http://www.progettosnaps.net/catver/).

 * If you configure `catver.ini` then the filter **Machines by Category (Catver)** becomes available.

   You can download this file from [progretto-SNAPS](http://www.progettosnaps.net/catver/).

 * If you configure `genre.ini` then the filter **Machines by Category (Genre)** becomes available.

   You can download this file from [progretto-SNAPS](http://www.progettosnaps.net/catver/).

 * If you configure `mature.ini` then the Mature flag becomes available. This flag can be used to filter out mature games.

   You can download this file from [progretto-SNAPS](http://www.progettosnaps.net/catver/).

 * If you configure `nplayers.ini` then the filter **Machines by Number of players** becomes available.

   You can download this file from [Arcade Belgium](http://nplayers.arcadebelgium.be/).

 * If you configure `series.ini` then the filter **Machines by Series** becomes available.

   You can download this file from [progretto-SNAPS](http://www.progettosnaps.net/series/).

After downloading and decompressing the INI files you want, place all of them in the `/home/kodi/MAME-DATs/` directory. Note that Linux filenames are case sensitive.

|  Directory  |  Notes     |
| :---------  | :--------- |
| `/home/kodi/MAME-DATs/bestgames.ini` | <sub>(Optional) Best games catalog.</sub> |
| `/home/kodi/MAME-DATs/catlist.ini`   | <sub>(Optional) Catlist.</sub> |
| `/home/kodi/MAME-DATs/catver.ini`    | <sub>(Optional) Catver.</sub> |
| `/home/kodi/MAME-DATs/genre.ini`     | <sub>(Optional) Genre.</sub> |
| `/home/kodi/MAME-DATs/mature.ini`    | <sub>(Optional) Mature flag.</sub> |
| `/home/kodi/MAME-DATs/nplayers.ini`  | <sub>(Optional) Number of players.</sub> |
| `/home/kodi/MAME-DATs/series.ini`    | <sub>(Optional) Series catalog.</sub> |

### Setting up MAME DAT files (Optional) ###

AML supports `History.dat`, `MAMEInfo.dat`, `Gameinit.dat` and `Command.dat`. All these files are optional. The information in the DAT files can be accessed in the context menu.

 * `History.dat` gives all trivia, facts, tips and others information for your favorite games.

   You can download History.dat from [Arcade History](https://www.arcade-history.com/?page=download).

 * `MAMEInfo.dat` contains technical information about MAME machines and development history.

   You can download MAMEInfo.dat from [MASH's MAMEINFO](http://mameinfo.mameworld.info/).

 * `Gameinit.dat` contains information to properly initialize some MAME machines.

   You can download Gameinit.dat from [progretto-SNAPS](http://www.progettosnaps.net/gameinit/).

 * `Command.dat` conatins information about the button names and special movements in some games. This is particularly important in fighting games like **Street Fighter II**.

   You can download Command.dat from [progretto-SNAPS](http://www.progettosnaps.net/command/).

After downloading and decompressing the DAT files you want, place all of them in the `/home/kodi/MAME-DATs/` directory. Note that Linux filenames are case sensitive.

|  Directory  |  Notes     |
| :---------  | :--------- |
| `/home/kodi/MAME-DATs/command.dat`   | <sub>(Optional) Command DAT</sub> |
| `/home/kodi/MAME-DATs/gameinit.dat`  | <sub>(Optional) Gameinit DAT</sub> |
| `/home/kodi/MAME-DATs/history.dat`   | <sub>(Optional) History DAT</sub> |
| `/home/kodi/MAME-DATs/mameinfo.dat`  | <sub>(Optional) MAME Info DAT</sub> |

### Setting up MAME Assets (Optional) ###

Place the MAME assets/artwork, in PNG format, in the following directories. Video previews should be in MP4 format. Manuals must be in PDF format (CBZ and CBR format support is under development). Note that AML does not create any directory automatically, you have to create all these directories yourself.

|  Directory  |  Notes     |
| :---------  | :--------- |
| `/home/kodi/MAME-assets/artpreviews/`   | <sub>MAME artpreview PNG files.</sub> |
| `/home/kodi/MAME-assets/artwork/`       | <sub>MAME artwork ZIP files.</sub> |
| `/home/kodi/MAME-assets/cabinets/`      | <sub>MAME cabinets.</sub> |
| `/home/kodi/MAME-assets/clearlogos/`    | <sub>MAME clearlogos/wheels.</sub> |
| `/home/kodi/MAME-assets/cpanels/`       | <sub>MAME control panels.</sub> |
| `/home/kodi/MAME-assets/fanarts/`       | <sub>AML will create MAME Fanarts here.</sub> |
| `/home/kodi/MAME-assets/flyers/`        | <sub>MAME flyers.</sub> |
| `/home/kodi/MAME-assets/manuals/`       | <sub>MAME machine PDF/CBZ/CBR manuals.</sub> |
| `/home/kodi/MAME-assets/marquees/`      | <sub>MAME marquees.</sub> |
| `/home/kodi/MAME-assets/PCBs/`          | <sub>MAME PCBs.</sub> |
| `/home/kodi/MAME-assets/snaps/`         | <sub>MAME in-game screenshots.</sub> |
| `/home/kodi/MAME-assets/titles/`        | <sub>MAME title screenshots.</sub> |
| `/home/kodi/MAME-assets/videosnaps/`    | <sub>MAME trailers (MP4 format)</sub> |

AML doesn't have (and never will have) asset/artwork scrapers. You can however download full MAME artwork collections from here:

 * [Progretto SNAPs MAME Artwork](http://www.progettosnaps.net/) The definitive place in the universe for MAME (and Software Lists) assets.

 * [Internet Archive](https://archive.org/details/MameArtwork) The Internet Archive is full of treasures! Make sure you do a comprehensive search!

 * [Pleasuredome](http://www.pleasuredome.org.uk/) Look for the MAME EXTRAs torrent. It includes a complete and up-to-date MAME artwork collection based on the contents of Progretto SNAPs (*).

 * [EmuMovies](http://emumovies.com/) Has some good artwork collections for MAME (*).

 * [HyperSpin Media](http://www.hyperspin-fe.com/files/category/2-hyperspin-media/) Forum for HyperSpin users containing artpacks. Clearlogos are called 'Wheels' in HyperSpin parlance (*).

(*) Registration Required

**Explain MAME artwork**

**Explain MAME Fanarts**

### Setting up Software Lists ROMs (Optional) ###

The Software Lists ROM ZIP files must be in a subdirectory whose name must match each Software List name, like in the following example:

```
# ROMs for 32x Software List
/home/kodi/MAME-SL-ROMs/32x/game_1.zip
/home/kodi/MAME-SL-ROMs/32x/game_2.zip
...
# ROMs for megadriv Software List
/home/kodi/MAME-SL-ROMs/megadriv/game_1.zip
/home/kodi/MAME-SL-ROMs/megadriv/game_2.zip
...
```

### Setting up Software Lists CHDs (Optional) ###

**Write me**.

### Setting up Software Lists Assets (Optional) ###

MAME machines have a broad range of assets, including Cabinets, Clearlogos, Control Panels, Flyers, PCBs, in-game snaps and title screenshots. On the other hand, Software Lists only have Covers/Boxfronts, in-game snaps and title screenshots.

|  Directory  |  Notes     |
| :---------  | :--------- |
| `/home/kodi/AML-assets/covers_SL/`     | <sub>Software Lists covers/boxfronts.</sub> |
| `/home/kodi/AML-assets/fanarts_SL/`    | <sub>AML will create SL Fanarts here.</sub> |
| `/home/kodi/AML-assets/manuals_SL/`    | <sub>SL items PDF/CBZ/CBR manuals.</sub> |
| `/home/kodi/AML-assets/snaps_SL/`      | <sub>Software Lists in-game screenshots.</sub> |
| `/home/kodi/AML-assets/titles_SL/`     | <sub>Software Lists title screenshots.</sub> |
| `/home/kodi/AML-assets/videosnaps_SL/` | <sub>Software Lists trailers (MP4 format).</sub> |

The Covers, Snaps and Titles of each software list must be in their own subdirectory like in this example:

|  Directory  |  Notes     |
| :---------  | :--------- |
| `/home/kodi/AML-assets/covers_SL/32x/`      | <sub>Covers for 32x Software List</sub> |
| `/home/kodi/AML-assets/covers_SL/megadriv/` | <sub>Covers for megadriv Software List</sub> |
| `/home/kodi/AML-assets/snaps_SL/32x/`       | <sub>Snaps for 32x Software List</sub> |
| `/home/kodi/AML-assets/snaps_SL/megadriv/`  | <sub>Snaps for megadriv Software List</sub> |

Note that the Software List artwork collections ZIP or Torrent files follow this naming scheme so you only have to decompress or copy the ZIP file/torrent in the appropiate directory.

### Configuring AML ###

Once you have placed your ROMs, CHDs, DAT/INI files and artwork in the appropiate directories it is time to configure AML.

In Kodi, open the AML root window. Select any row on the root window and open the context menu. If you are using a keyboard to control Kodi, the default key to open the context menu is <kbd>C</kbd>. Browse and select the menu "AML addon settings". Note that you also can the AML addon settings window from the Kodi addon browser.

In the AML addon settings window, go to the Paths tab and configure the following stuff:

 1) **MAME executable** Click to open a file selection dialog and browse to the location of the MAME executable.

 2) **MAME ROM path** Write me.

 3) **MAME Assets path** Write me.

 4) **MAME INI/DAT path** Write me.

 3) **MAME CHDs path** Write me.

 3) **MAME Samples path** Write me.

 4) **Software Lists hash path** is a subdirectory inside the MAME installation directory which contains the Software Lists XML databases.

    Linux users: in Debian/Ubuntu it is typically located in `/usr/share/games/mame/hash/`.

    Windows users: if you installed MAME in `E:\MAME\` then the Software Lists hash path would be located in `E:\MAME\hash\`.

 3) **Software Lists ROMs path** Write me.

 3) **Software LIsts CHD path** Write me.

After you have finished with the configuration, select the OK button to close the settings window and commit the changes.

### Setting up AML (Easy mode) ###

After configuring AML, go to the AML root window. Bring the context menu and select **Setup plugin**. Then click on **All in one step (Extract, Build and Scan)**. Now wait until AML builds the MAME databases and scans you ROMs. This process should take about 10/15 minutes.

If everything goes well you are now able to navigate all MAME arcade/computer machines and Software Lists items, and also launch them. Now, in the section [Browsing MAME machines](Browsing-MAME-machines) you have more details about how to use AML for MAME and in the section [Browsing Software Lists](Browsing-Software-Lists) you have more details about the Software Lists.

### Setting up AML ###

After configuring AML, go to the AML root window. Bring the context menu and select **Setup plugin**. Then, execute in consecutive order:

  1. **Extract MAME.xml ...** extracts the MAME.xml database from MAME.

  2. **Build all databases** converts the MAME XML database into JSON format, strips out unneeded information to boost performance, generates the filter parent/clone lists and processes the Software List XML databases.

  3. **Scan everyting** scans your MAME machine ROMs, CHDs and Samples, Software Lists ROMs and CHDs, and MAME machines and Software Lists assets/artwork. Sets all tags having a `?` character to the appropriate value.

If everything goes well you are now able to navigate all MAME arcade/computer machines and Software Lists items, and also launch them. Now, in the section [Browsing MAME machines](Browsing-MAME-machines) you have more details about how to use AML for MAME and in the section [Browsing Software Lists](Browsing-Software-Lists) you have more details about the Software Lists.

### Setting up AML (Advanced mode) ###

The `Setup plugin`, `Step by step ...` menu allows you to execute the AML database setup process step by step, as opposed to automatically. For example, if you install/copy new MAME assets you can execute `Scan MAME assets/artwork ...` to bring the MAME machine artwork database up-to-date. Alternatively, you can run **Scan everyting** to bring all ROMs/assets databases up-to-date but it will take much longer.
