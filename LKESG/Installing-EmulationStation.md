---
layout: post
title: "EmulationStation installation in Ubuntu/Debian"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

In this chaper I cover the installation of EmulationStation on Ubuntu Linux.

## Installation of the EmulationStation executable

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

## Autoboot EmulationStation

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

Now replace the `display-manager.service` from `gdm3.service` to the EmulationStation service:

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

## Current problems

EmulationStation cannot reboot or poweroff the system.

EmulationStation does weird things when clicking on reboot or shutdown. For example, the ES process never finishes. I must investigate the source code to see what's going on. To test it use the `emulationstation.sh` file and add echo messages to simulation system reboot/shutdown.

## Notes

The first time you run EmulationStation you need to configure an input device which may be a keyboard or a gamepad. I recommend you always configure the keyboard first and then configure as many gamepads as you want. You can control EmulationStation with any of the configured devices.
