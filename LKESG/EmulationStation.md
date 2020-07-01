---
layout: post
title: "EmulationStation installation in Ubuntu/Debian"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

In this chapter I cover the installation of EmulationStation as a front-end for your games in your HTPC. You will need a working HTPC with Ubuntu Linux installed as described in [Linux installation and initial configuration](./LKESG/Linux-installation-and-configuration).

## Installation of EmulationStation (compile from source)

First clone a repository I made to simplify the installation of the Retropie fork of EmulationStation:

```
$ cd /home/kodi/
$ git clone https://github.com/Wintermute0110/EmulationStation-Install.git
```

Install the required software and libraries required to build EmulationStation:

```
$ cd /home/kodi/EmulationStation-Install
$ sudo install-build-dependencies.sh
```

Get the EmulationStation source code:

```
$ cd /home/kodi/EmulationStation-Install
$ git clone https://github.com/RetroPie/EmulationStation.git retropie-ES
$ cd retropie-ES
$ git submodule update --init --recursive
```

Before compilation it is necessary to change a couple of lines of C++ code. Use `nano es-core/src/platform.cpp` and in the function `void processQuitMode()` comment the following lines by adding a `//`. The final result must look like this:

```c++
       case QuitMode::REBOOT:
                LOG(LogInfo) << "Rebooting system";
                touch("/tmp/es-sysrestart");
                // runRestartCommand();
                break;
        case QuitMode::SHUTDOWN:
                LOG(LogInfo) << "Shutting system down";
                touch("/tmp/es-shutdown");
                // runShutdownCommand();
                break;
```

Now build the EmulationStation executable with:

```
$ cd /home/kodi/EmulationStation-Install/retropie-ES
$ cmake .
$ make -j8
```

Finally, create a soft link to the EmulationStation executable and copy a helper script required to reset/power off your HTPC using D-Bus. The emulation station executable `emulationstation` must be in the same directory as the script `emulationstation.sh`, that's why we create the soft link:

```
$ cd /home/kodi/EmulationStation-Install
$ mkdir /home/kodi/bin
$ cp emulationstation.sh /home/kodi/bin/emulationstation.sh
$ chmod 755 /home/kodi/bin/emulationstation.sh
$ ln -s /home/kodi/EmulationStation-Install/retropie-ES/emulationstation /home/kodi/bin/emulationstation
```

Now you need to configure your `es_systems.cfg`, install some EmulationStation themes and configure your keyboard and gamepad to control EmulationStation.

## Setting up EmulationStation

### Installing a theme

The recommended EmulationStation theme is the default [Batocera theme](https://github.com/batocera-linux/batocera-themes) or the default [Retropie Carbon theme](https://github.com/RetroPie/es-theme-carbon). To download a theme from Github click on the **Clone or download** green button and then in **Download ZIP**. Themes must be placed in `/home/kodi/.emulationstation/themes/`, each theme on its own subdirectory. Theme directory names are irrelevant. When started, EmulationStation scans this directory for themes automatically.

 * If you download the Batocera default theme from Github, place the contents of the directory `themes/batocera` into `/home/kodi/.emulationstation/batocera/`. When downloading from Github, inside the ZIP file the contents of the repository are placed inside a directory named `batocera-themes-master` where `master` is the master branch of the repository.

 * If you download the Retropie Carbon theme move the directory `es-theme-carbon-master` into `/home/kodi/.emulationstation/themes/`.

In Linux you can use Filezilla or use SSHFS to mount the remote `/home/kodi/` HTPC directory into a local directory. In Windows you can use WinSCP (or any other SFTP application) to copy files and create directories from/to your HTPC. Once you have updated your themes you must restart EmulationStation to see the changes.

To make things cristal clear this is an example of the layout after both themes are installed:

```
/home/kodi/.emulationstation/themes/batocera/main.xml
...
/home/kodi/.emulationstation/themes/batocera/3do/theme.xml
/home/kodi/.emulationstation/themes/batocera/3do/_data/
...
/home/kodi/.emulationstation/themes/es-theme-carbon-master/theme.xml
...
/home/kodi/.emulationstation/themes/es-theme-carbon-master/3ds/theme.xml
/home/kodi/.emulationstation/themes/es-theme-carbon-master/3ds/art/
...
```

### Create a basic es_systems XML for testing

Create a fake `es_systems.cfg` file.

```
<?xml version="1.0"?>
<!-- File /home/kodi/.emulationstation/es_systems.cfg -->
<systemList>
  <system>
    <name>megadrive</name>
    <fullname>Sega Mega Drive</fullname>
    <path>/home/kodi/roms/megadrive</path>
    <extension>.smd .bin .gen .md .zip</extension>
    <command>ls %ROM%</command>
    <platform>megadrive</platform>
    <theme>megadrive</theme>
  </system>
  </system>
</systemList>
```

Create a directory for your MegaDrive ROMs and create one fake ROM:

```
$ mkdir -p /home/kodi/roms/megadrive
$ touch "/home/kodi/roms/megadrive/Sonic The Hedgehog 2 (World).zip"
```

This is just for testing, nothing will launch when you click in your ROM. Later you can replace `es_systems.cfg` with a real one and place real ROMs.

## Running EmulationStation for the first time

The first time you run EmulationStation you need to configure an input device which may be a keyboard or a gamepad. I recommend you always configure the keyboard first and then configure as many gamepads as you want. You can control EmulationStation with any of the configured devices, however if you do not configure any control device you cannot control ES at all!

 * If your system is configured to boot in the X server then open a `lxterminal` and execute `$ /home/kodi/bin/emulationstation.sh`.

 * If you system is configure to boot in the text console you can start EmulationStation with `$ startx`. 

Press **F4** on the keyboard to exit EmulationStation at any time. Once you have finished setting up the controls in EmulationStation reboot your HTPC and EmulationStation should start automatically.

## Running EmulationStation automatically at boot

Edit the file `/home/kodi/.config/openbox/autostart` and at the end append:

```
# File /home/kodi/.config/openbox/autostart

# Other configuration you may have in autostart...

# Launchg a terminal emulator
# lxterminal &

# Start EmulationStation
/home/kodi/bin/emulationstation.sh
openbox --exit
```

Note that compared with the default `autostart` file created in the [Linux-installation-and-configuration section](Linux-installation-and-configuration) here we disable the execution of `xlterminal` and instead execute EmulationStation.

## Updating EmulationStation files

When updating EmulationStation files, for example `~/.emulationstation/es_systems.cfg`, EmulationStation must be not running. If you need to stop EmulationStation use the following command:

```
$ sudo systemctl stop display-manager.service
```

You can start EmulationStation again with:

```
$ sudo systemctl start display-manager.service
```

It is fine to use these commands from the text console in your HTPC with a keyboard connected or using a remote terminal with SSH.

## What to do next?

If you want to use EmulationStation as your frontend you need to setup some real emulators as backends, for example `Retroarch`, `MAME` or `Mednafen`. Once you setup and test your emulator you need to create a real `es_systems.cfg`.
