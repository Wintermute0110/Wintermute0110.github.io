---
layout: post
title: "Installing Kodi in Debian/Ubuntu"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

## Installing Kodi

TODO

## Compiling Kodi from source

TODO

## Launching Kodi automatically at boot time

**TODO Rewrite this section to use systemd. See Kodi forum post**

## (Optional) Configure Kodi to use VA-API hardware acceleration

**TODO See Kodi forum post**

## (Optional) Verify that Kodi is using a window manager

**TODO Rewrite**

To test if XBMC is running within the window manager `OpenBox`, in XBMC go to `Settings`, `System`, `Video Output` and select windowed display mode. XBMC should display with a window border and you will see the desktop (which should containg anyting at all except a gray background). Now, outside the XBMC window, right click and a pop-up menu will show up. This pop-up menu allows you to launch a web browser (`Chromium` by default) and the console terminal.

The procedure described above is very important. It will be used to launch and configure the emulators **BEFORE** they can be used by the XBMC launcher plugins. This procedure will be referred as "set XBMC into windowed mode and launch a terminal" in this guide.

## (Optional) Disable Kodi core dumps

When Kodi crashes (and it will do from time to time) the memory is dumped to the disk into a file name `core`. This file can be used by the developers to track what cause the core. However, core files are bulky and incovenienut. 

To disable the creation of core files at all edit the script `/usr/bin/xbmc` (or `/home/kodi/bin/kodi` if you compiled Kodi), which is an ASCII file, and change:

```
  eval ulimit -c unlimited
```

to

```
  eval ulimit -c 0
```

`eval` is a shell builtin command. Then -c option sets the maximum size of core files.

## (Optional) Use a gamepad to control Kodi

XBMC needs a joystick mapping file. There are some examples in `/usr/share/xbmc/`. The appropiate file should be copied to `~/.xbmc/userdata/keymaps/joystick.SOMENAME.xml`

In my case I used `joystick.Logitech.RumblePad.2.xml`. After rebooting XBMC... the joystick doesn't work. I enabled logging and rebooted. And then it started working!!! Maybe the calibration of the joystick is not good...



<!--
===============================================================================
* ADDING MP3 music
===============================================================================

========== Album covers ==========

By default, XBMC only recognises folder.jpg as the album cover. In order to
expand this list, advancedsettings.xml should be changed

<musicthumbs>
  <add>cover.png|cover.jpg|Cover.png|Cover.jpg|front.png|front.jpg|Front.png|Front.jpg</add>
</musicthumbs>

See http://wiki.xbmc.org/?title=Thumbnails for more information.

========== Increase number of "recently added" albums ==========

Add this to advancedsettings.xml

<musiclibrary>
  <recentlyaddeditems>100</recentlyaddeditems>
</musiclibrary>

See http://wiki.xbmc.org/index.php?title=Advancedsettings.xml for more info.
-->
