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

Now you need to configure your `es_systems.cfg`, install some EmulationStation themes and configure your keyboard and gamepad.

## Setting up EmulationStation

### Installing a theme

The recommended EmulationStation theme is the default [Batocera theme](https://github.com/batocera-linux/batocera-themes) or the default [Retropie theme Carbon](https://github.com/RetroPie/es-theme-carbon). To download a theme from Github click on the **Clone or download** green button and then in **Download ZIP**. Themes must be placed in `/home/kodi/.emulationstation/themes/`, each theme on its own subdirectory. When started, EmulationStation scans this directory for themes automatically.

You can use Filezilla (Linux) or WinSCP (Windows) to copy files and create directories from/to your HTPC.

### Create a basic es_systems XML for testing

TODO Create a fake es_systems.cfg and some directories with fake ROMs so ES will show something when started.

### Running EmulationStation for the first time

The first time you run EmulationStation you need to configure an input device which may be a keyboard or a gamepad. I recommend you always configure the keyboard first and then configure as many gamepads as you want. You can control EmulationStation with any of the configured devices.

Create the file `/home/kodi/.config/openbox/autostart`:

```
# File /home/kodi/.config/openbox/autostart

# Start EmulationStation
/home/kodi/bin/emulationstation.sh
openbox --exit
```

From the text console you can start Emulation station with:

```
$ startx /usr/bin/openbox-session
```

Press **F4** on the keyboard to exit EmulationStation at any time.

## Start EmulationStation when the machine boots

Create the **EmulationStation** service file:

```
# File /etc/systemd/system/EmulationStation.service
[Unit]
Description = EmulationStation using xinit with Openbox WM and D-Bus
Requires = dbus.service
After = systemd-user-sessions.service sound.target network-online.target

[Service]
User = kodi
Group = kodi
Type = simple
PAMName = login
ExecStart = /usr/bin/xinit /usr/bin/dbus-launch --exit-with-session /usr/bin/openbox-session -- :0 -nolisten tcp vt7
Restart = on-abort

[Install]
WantedBy = multi-user.target
```

Now replace the current `display-manager.service` with the EmulationStation service:

```
# rm /etc/systemd/system/display-manager.service
# ln -s /etc/systemd/system/EmulationStation.service /etc/systemd/system/display-manager.service
```

-----

If you need to stop EmulationStation use the following command:
```
$ sudo systemctl stop display-manager.service
```

**IMPORTANT** If you update your `es_systems.cfg` file EmulationStation must be not running. After making changes to the EmulationStation files reboot your system with `reboot` to be safe.

## What to do next?

If you want to use EmulationStation as your frontend you need to setup some emulators as backends, for example Retroarch, MAME or Mednafen.