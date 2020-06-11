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

```
$ cd /home/kodi/
$ git clone https://github.com/Wintermute0110/EmulationStation-Install.git
$ cd EmulationStation-Install
```

```
# ./install-build-dependencies.sh
```

```
$ git clone https://github.com/RetroPie/EmulationStation.git retropie-EmulationStation
$ cd retropie-EmulationStation
$ git submodule update --init --recursive
$ cmake .
$ make -j8
$ mkdir /home/kodi/bin
$ cp emulationstation.sh /home/kodi/bin/emulationstation.sh
$ ln -s /home/kodi/EmulationStation-Install/retropie-EmulationStation/emulationstation /home/kodi/bin/emulationstation
```

The EmulationStation executable is `/home/kodi/bin/emulationstation.sh`

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

Now replace the current `display-manager.service` from `gdm3.service` to the EmulationStation service:

```
# rm /etc/systemd/system/display-manager.service
# ln -s /etc/systemd/system/EmulationStation.service /etc/systemd/system/display-manager.service
```

Create the file `/home/kodi/.config/openbox/autostart`:

```
# File /home/kodi/.config/openbox/autostart

# Start EmulationStation
/home/kodi/bin/emulationstation.sh
openbox --exit
```

## Setting up EmulationStation

Recommended theme is Batocera or Retropie default theme (carbon).

Create a basic es_systems XML for testing.

## Notes

The first time you run EmulationStation you need to configure an input device which may be a keyboard or a gamepad. I recommend you always configure the keyboard first and then configure as many gamepads as you want. You can control EmulationStation with any of the configured devices.

## What to do next?

If you want to use EmulationStation as your frontend you need to setup some emulators as backends, for example Retroarch, MAME or Mednafen.
