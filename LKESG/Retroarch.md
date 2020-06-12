---
layout: post
title: "Retroarch usage notes"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

RetroArch is a multi-system emulator that keeps separated the emulator graphical user interface from the emulation engine (referred as *cores* in RetroArch). This emulator is very friendly with HTPC setups because you can configure all the settings from your joystick, among other things. It takes a bit of effort to set it up, but once this is done you can emulate a vast number of systems easily. 

A full list of the supported cores is [here](http://www.libretro.com/index.php/ecosystem/"). This list is a bit outdated and a lot of work is currently going on. Have a look here for the [GitHub repository](https://github.com/libretro/RetroArch/) where you can always find the latest information. The best source of RetroArch documentation is the [GitHub Wiki](https://github.com/libretro/RetroArch/wiki").

There is a PPA offering Retroarch packages. However, it is not very difficult to build it from source. Also, be aware that the configuration depends on the installation path of the executables.

## Compiling RetroArch (Manual method)

This is a step by step guide similar to the one found [here](https://github.com/libretro/RetroArch/wiki/Compilation-guide-%28Linux%29).

Create the folder `~/bin/emu-libretro-super`
```
$ mkdir ~/bin
$ mkdir ~/bin/emu-libretro-super
$ cd ~/bin/emu-libretro-super
```

Fetch `libretro-super` from GitHub
```
$ git clone git://github.com/libretro/libretro-super.git
```

Edit `./libretro-super/libretro-fetch.sh` to install only the wanted emulation cores. At the end of the file you will see
```
...
fetch_project "$REPO_BASE/libretro/RetroArch.git" "retroarch" "libretro/RetroArch"

fetch_project_bsnes "git://gitorious.org/bsnes/bsnes.git --branch libretro" "libretro-bsnes" "libretro/bSNES"
fetch_project "$REPO_BASE/libretro/snes9x.git" "libretro-s9x" "libretro/SNES9x"
fetch_project "$REPO_BASE/libretro/snes9x-next.git" "libretro-s9x-next" "libretro/SNES9x-Next"
fetch_project "$REPO_BASE/libretro/Genesis-Plus-GX.git" "libretro-genplus" "libretro/Genplus GX"
fetch_project "$REPO_BASE/libretro/fba-libretro.git" "libretro-fba" "libretro/FBA"
...
```

Now place a sharp # in front of the cores you don't want. For example, if among those cores you only want Genplus GX

```
...
fetch_project "$REPO_BASE/libretro/RetroArch.git" "retroarch" "libretro/RetroArch"

# fetch_project_bsnes "git://gitorious.org/bsnes/bsnes.git --branch libretro" "libretro-bsnes" "libretro/bSNES"
# fetch_project "$REPO_BASE/libretro/snes9x.git" "libretro-s9x" "libretro/SNES9x"
# fetch_project "$REPO_BASE/libretro/snes9x-next.git" "libretro-s9x-next" "libretro/SNES9x-Next"
fetch_project "$REPO_BASE/libretro/Genesis-Plus-GX.git" "libretro-genplus" "libretro/Genplus GX"
# fetch_project "$REPO_BASE/libretro/fba-libretro.git" "libretro-fba" "libretro/FBA"
...
```

Now grab the source code of the cores you want to compile and RetroArch graphical user interface RGUI
```
$ cd libretro-super
$ sh libretro-fetch.sh
```

Before compiling, install the mandatory dependencies (that is, software you need in order to build programs) required to build the cores. As root, execute

```
# apt-get install build-essential
   ```

Now compile the cores. If you choose to compile all the cores, then it can take a while.
```
$ sh libretro-build.sh
```

It's not necessary to edit retroarch-build.sh to avoid compilation of uninstalled cores. The script automatically compiles only the cores that have been fetched.


To compile RetroArch graphical interface, <command>RGUI</command>, first install some more dependencies. RetroArch's dependencies can be tested with
```
$ cd retroarch
$ ./configure
```

RGUI's to install mandatory dependencies
```
# apt-get install libgl1-mesa-dev libasound2-dev
```

to install RGUI's optional dependencies
```
$ apt-get install libxml2-dev libfreetype6-dev nvidia-cg-dev libsdl1.2-dev
```

Compile <command>RGUI
```
$ sh retroarch-build.sh
```

After compilation, test RetroArch
```
$ cd retroarch
$ ./retroarch --features
```

this will tell you the features Retroarch has

To install RetroArch RGUI, cores and info files, execute the following

```
$ mkdir /home/wintermute0110/bin/libretro/unix
$ sh libretro-install.sh /home/wintermute0110/bin/libretro/unix/
$ cp retroarch/retroarch /home/wintermute0110/bin
```

Also copy the info files to /home/xbmc/bin/libretro/info/, so RetroArch gives nice information about each core.

## Compiling RetroArch (Scripted method)

Create directory <filename>~/bin/emu-libretro-super</filename>

Fetch <command>libretro-super</command> project 
<screen>$ ./clone-libretro-super</screen>


Patch files
<screen>$ libretro-build-common.sh
$ libretro-config.sh</screen>


Configure which cores you want to fetch/compile. Edit the file 
<filename>libretro-fetch.sh</filename> and comment out the unwanted stuff
at the end of the file.

Fetch the libretro and Retroarch source code
<screen>$ ./update-retroarch</screen>


Install required dependencies
<screen>$ ./install-dependencies</screen>


Compile libretro cores
<screen>$ ./compile-libretro</screen>


Compile RetroArch RGUI executable
<screen>$ ./compile-retroarch</screen>


Install Retroarch cores, info files, and RGUI executable
```
<screen>$ ./install-retroarch</screen>
```

## Basic RetroArch setup

The main configuration file is located on `~/.config/retroarch/retroarch.cfg`. Execute RetroArch once to create a default configuration file. There is an example of a configuration file located in [Github](https://github.com/libretro/RetroArch/blob/master/retroarch.cfg"). Create a directory named `~/.retroarch` to store RetroArch files (BIOS, saved games, screenshots, etc.) and then

<emphasis>Core and info directories</emphasis>: configure the 
following

```
...
# Path to a libretro implementation.
# This core will be loaded by default on launching RGUI.
libretro_path = "~/bin/bin-libretro/picodrive_libretro.so"
...
# A directory for where to search for libretro implementations.
libretro_directory = ~/bin/bin-libretro/
...
# A directory where the core info files are located. This information is
# displayed on RGUI for every core (file types supported, systems supported, etc.).
libretro_info_path = "~/bin/bin-libretro/"
...
```


<emphasis>System directory</emphasis>: this directory contains the 
BIOS necessary for running some emulators (notably Sega MegaCD and PlayStation 1).

```
$ mkdir ~/.retroarch/system
```

Change the following option in <filename>~/.config/retroarch/retroarch.cfg</filename>

```
# Sets the "system" directory.
# Implementations can query for this directory to load BIOSes, system-specific configs, etc.
system_directory = "~/.retroarch/system/"
```


<emphasis>Savefile directory</emphasis> stores the emulated battery-backed memory,
memory cards, etc.
<screen>
$ mkdir ~/.retroarch/savefile
</screen>

Change the following option in <filename>~/.config/retroarch/retroarch.cfg</filename>
<programlisting>
savefile_directory = "~/.retroarch/savefile/"
</programlisting>



<emphasis>Savestate directory</emphasis> stores your emulated saved games.
<screen>
$ mkdir ~/.retroarch/savestate
</screen>

Change the following option in <filename>~/.config/retroarch/retroarch.cfg</filename>
<programlisting>
savestate_directory = "~/.retroarch/savestate/"
</programlisting>



<emphasis>Screenshots directory</emphasis> stores the screenshots you take.
<screen>
$ mkdir ~/.retroarch/screenshot
</screen>

Change the following option in <filename>~/.config/retroarch/retroarch.cfg</filename>
```
screenshot_directory = "~/.retroarch/screenshot/"
```


<emphasis>ROM browser directory</emphasis> is where your ROMs are. You can
always navigate using RGUI, but if you configure it loading ROMs will be
much faster.

Change the following option in <filename>~/.config/retroarch/retroarch.cfg</filename>
```
rgui_browser_directory = "~/ROMs"
```

<emphasis>Cheats database (optional, avoids one warning when running RetroArch)</emphasis> 
stores cheats for your games. Firsly, create a file named 
<filename>~/.retroarch/cheat_database.xml</filename> and insert
```
<?xml version="1.0" encoding="UTF-8"?>
<codelist>
<game>
</game>
</codelist>
```

Change the following option in <filename>~/.config/retroarch/retroarch.cfg</filename>
```
cheat_database_path = "~/.retroarch/cheat_database.xml"
```

## Running RetroArch from the command line

If you run <command>retroarch</command> without any argument, RGUI
user interface will show up. From here you can load cores, games, configuring
controls, etc. (will do this in the next section).

To run retroarch from the XBMC launcher plugins, you will need to
tell retroarch which core to load. You can get a list of you installed 
cores executing

```
xbmc@NUC:~/bin/emu-libretro-super$ ls -1 ~/bin/bin-libretro/*.so 
/home/xbmc/bin/bin-libretro/bnes_libretro.so
/home/xbmc/bin/bin-libretro/bsnes_accuracy_libretro.so
/home/xbmc/bin/bin-libretro/bsnes_balanced_libretro.so
/home/xbmc/bin/bin-libretro/bsnes_performance_libretro.so
/home/xbmc/bin/bin-libretro/genesis_plus_gx_libretro.so
/home/xbmc/bin/bin-libretro/mupen64plus_libretro.so
/home/xbmc/bin/bin-libretro/pcsx_rearmed_libretro.so
/home/xbmc/bin/bin-libretro/picodrive_libretro.so
```

For example, to execute a Super Nintendo ROM you type
```
$ ./retroarch -L ~/bin/bin-libretro/bsnes_accuracy_libretro.so Mario_World.zip
```

## Basic RetroArch usage

This is a list of the basic default controls in RGUI

```
Arrows  Navigate through RetroArch's RGUI
X       Accept/OK
Z       Back
F1      While playing a game, pauses the game and shows up Retroarch menu
ESC     Exits RetroArch.
```

If you wish to test RetroArch, first load an appropiate core in Core..., and then load the ROM in Load content (CoreName)... Once you configure your joystick, you will be able to control most RetroArch settings and load cores/games with the joystick.

## Control configuration

To configure the joystick, use the RGUI interface xxxxx.

Next, configure one joystick button to access the RGUI interface and other to exit RetroArch. The easiest way to do it is editing the file `~/.config/retroarch/retroarch.conf`

```
...
input_exit_emulator = "escape"
input_exit_emulator_btn = "11"
input_exit_emulator_axis = "nul"
...
input_menu_toggle = "f1"
input_menu_toggle_btn = "13"
input_menu_toggle_axis = "nul"
...
```

## PSX BIOS

WRITE ME

## Sega MegaCD BIOS
 
WRITE ME
