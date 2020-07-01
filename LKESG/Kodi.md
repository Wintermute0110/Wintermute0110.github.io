---
layout: post
title: "Installing Kodi in Debian/Ubuntu"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

## Installing Kodi using Ubuntu packages

**TODO Is it really recommended to use the Ubuntu official Kodi packages?**

## Installing Kodi using them Team Kodi PPA

Follow the instructions on the [Kodi wiki: HOW-TO:Install Kodi for Linux](https://kodi.wiki/view/HOW-TO:Install_Kodi_for_Linux).

-----

[Kodi wiki: Official Ubuntu PPA](https://kodi.wiki/view/Official_Ubuntu_PPA)

## Compiling Kodi from source

If you choose to compile Kodi you can follow the instruction of my [Kodi-Install Github repository](https://github.com/Wintermute0110/Kodi-Install). 

  * The advantages of compiling Kodi yourself is that you can install the version you want and also the Retroplayer cores that for some reason are not available in the Team Kodi PPA repository. 

  * The only actual disadvantage is that the compilation may require several hours to complete, specially on low-end machines.

If you follow this approach use the next configuration options:

| Name | Directory |
|------|-----------|
| **Kodi executable** | `/home/kodi/bin-kodi/lib/kodi/kodi-x11` |
| **Kodi user data directory** | `/home/kodi/.kodi/` |
| **Kodi log file** | `/home/kodi/.kodi/temp/kodi.log` |

## Launching Kodi automatically at boot time

Edit the file `/home/kodi/.config/openbox/autostart` and at the end append:

```
# File /home/kodi/.config/openbox/autostart

# Other configuration you may have in autostart...

# Launchg a terminal emulator
# lxterminal &

# Start Kodi. Restart in case it crashes.
$KODI=/home/kodi/bin-kodi/lib/kodi/kodi-x11
$KODI --standalone
while [ $? -ne 0 ]; do
    $KODI --standalone
done
openbox --exit
```

Note that compared with the default autostart file created in the [Linux-installation-and-configuration section](Linux-installation-and-configuration) here we disable the execution of `lterminal` and instead execute Kodi.

## Controlling Kodi with a gamepad

If you have a USB keyboard and mouse attached to your HTPC they should work out of the box. Refer to the [Kodi wiki: Keyboard controls](https://kodi.wiki/view/Keyboard_controls) page to learn about the default keys. Don't be overwhelmed by the vast numbers of controls, this table summarizes the basic controls you will use 99.9% of the time:

| Key name | Main action |
|----------|-------------|
| `Escape` | Previous menu OR Home screen |
| `Return` | Select |
| `Tab` | Fullscreen playback |
| `C` | Open context menu |
| `I` | Open info menu |
| `P` | Start playing |
| `X` | Stop playing |
| `Space bar` | Pause/Play |
| `-` minus | Volume down |
| `+` plus | Volume up |
| `Arrow keys` | Navigate the graphical interface |

Note that in Kodi some keys change their meaning depending on wheter you are on the Home screen, or watching a movie (movie playback) or listening to music (music visualization). When watching a movie or listening to music you can always return to the Home screen pressing `Tab` and your media will keep playing in the background. Press `Tab` again to return to your media. Kodi uses massively the **context menu** which changes depending on the item you have selected. For example, the context menu when you are selecting a movie has options relevant for movies. You will use the `C` key a lot.

Kodi can be controller with almost [any remote control](https://kodi.wiki/view/Remote_controls) there is. However, I think the best controller for Kodi is an **Xbox 360-like gamepad**, which in addition will allow you to play your retrogames in your HTPC. Note that in Kodi Leia a gamepad **is required** to run games using Kodi Retroplayer.

-----

[Kodi wiki: Keymap](https://kodi.wiki/view/Keymap)

[Kodi wiki: Remote controls](https://kodi.wiki/view/Remote_controls)

### Configure a gamepad to control Kodi

**TODO: Rewrite this. In Kodi Leia the joystick buttons and axes are automapped in the GUI. However, the actions must be configured using an XML file.**

Kodi needs a joystick mapping file. There are some examples in `/usr/share/xbmc/`. The appropiate file should be copied to `~/.xbmc/userdata/keymaps/joystick.SOMENAME.xml`. In my case I used `joystick.Logitech.RumblePad.2.xml`. 

## (Optional) Using Kodi Retroplayer to play your games

**TODO**

## (Optional) Using files and media stored in a NAS

**TODO**

## (Optional) Configure Kodi to use VA-API hardware acceleration

**TODO See Kodi forum post**

## (Optional) Music configuration

### Album covers

By default, XBMC only recognises folder.jpg as the album cover. In order to expand this list, advancedsettings.xml should be changed:

```
<musicthumbs>
    <add>cover.png|cover.jpg|Cover.png|Cover.jpg|front.png|front.jpg|Front.png|Front.jpg</add>
</musicthumbs>
```

-----

[Kodi Wiki: Thumbnails](http://wiki.xbmc.org/?title=Thumbnails)

### Increase number of "recently added" albums

Add this to `advancedsettings.xml`

```
<musiclibrary>
    <recentlyaddeditems>100</recentlyaddeditems>
</musiclibrary>
```

-----

[Kodi wiki: Advancedsettings.xml](http://wiki.xbmc.org/index.php?title=Advancedsettings.xml)

## (Optional) Movies/video configuration

**TODO**

## (Optional) Pictures configuration

**TODO**

## (Optional) Configuring IPTV Simple

**TODO**
