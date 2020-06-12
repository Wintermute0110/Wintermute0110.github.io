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

**TODO Rewrite this section to use systemd**

**NOTE** Launching emulators without a window manager causes problems in XBMCbuntu. The suggested solution is to install `OpenBox` and configure it to autostart XBMC.

In Gotham XBMCbuntu OpenBox is already installed. X sessions scripts (run by the session manager (`kdm`, `lightdm`) are located in `/usr/share/xsessions/` (in Debian is the same directory). Create the file `/usr/share/xsessions/openbox.desktop` and insert:

```
[Desktop Entry]
Name=Openbox
Comment=Log in using the Openbox window manager (without a session manager)
Exec=/usr/bin/openbox-session
TryExec=/usr/bin/openbox-session
Icon=openbox
Type=Application
```

Next, `openbox-session` launches the file `~/.config/openbox/autostart.sh` automatically. This file is a good place to launch XBMC.

```
# Init script for OpenBox
# This script is called by openbox-session on startup
xbmc-standalone &
```

After making this changes reboot your system and when the session manager shows (`lightdm`) start the session named `Openbox`. This session should be started automatically every time the system boots, launching XBMC automatically.

To test if XBMC is running within the window manager `OpenBox`, in XBMC go to `Settings`, `System`, `Video Output` and select windowed display mode. XBMC should display with a window border and you will see the desktop (which should containg anyting at all except a gray background). Now, outside the XBMC window, right click and a pop-up menu will show up. This pop-up menu allows you to launch a web browser (`Chromium` by default) and the console terminal.

The procedure described above is very important. It will be used to launch and configure the emulators **BEFORE** they can be used by the XBMC launcher plugins. This procedure will be referred as "set XBMC into windowed mode and launch a terminal" in this guide.

## Deactivating the screensaver

To show the current screensaver and DPMS settings execute
```
$ xset q
```

In the OpenBox session, DPMS is no.

In order to disable it, xset settings can be place in xprofile file

After restarting the OpenBox XBMC session, everything seems OK and DPMS is disabled.

[ArchLinux wiki Display Power Management Signaling](https://wiki.archlinux.org/index.php/Display_Power_Management_Signaling)

## (Optional) Disable Kodi core dumps

To disable nasty XBMC core dump files edit `/usr/bin/xbmc`, which is an ASCII file, and change

```
  eval ulimit -c unlimited
```

to

```
  eval ulimit -c 0
```

`eval` is a shell builtin command. Then -c option sets the maximum size of core files. Core dumps can be disable system wide in 
`/etc/sysctl.conf`, but it's more complicated.


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
