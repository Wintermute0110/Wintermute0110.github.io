---
layout: post
title: "Installing Kodi in Debian/Ubuntu"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

## XBMC launching whitin a window manager

**NOTE** Launching emulators without a window manager causes problems in XBMCbuntu. The suggested solution is to install `OpenBox` and configure it to autostart XBMC.

In Gotham XBMCbuntu OpenBox is already installed. X sessions scripts (run by the session manager (`kdm`, `lightdm`)
are located in `/usr/share/xsessions/` (in Debian is the same directory). Create the file `/usr/share/xsessions/openbox.desktop` and insert:

```
[Desktop Entry]
Name=Openbox
Comment=Log in using the Openbox window manager (without a session manager)
Exec=/usr/bin/openbox-session
TryExec=/usr/bin/openbox-session
Icon=openbox
Type=Application
```

Next, `openbox-session` launchs the file `~/.config/openbox/autostart.sh` automatically. This file is a good place to launch XBMC.

```
# Init script for OpenBox
# This script is called by openbox-session on startup
xbmc-standalone &amp;
```

After making this changes reboot your system and when the session manager shows (`lightdm`) start the session named `Openbox`. This session should be started automatically every time the system boots, launching XBMC automatically.

To test if XBMC is running within the window manager `OpenBox`, in XBMC go to `Settings`, `System`, `Video Output` and select windowed display mode. XBMC should display with a window border and you will see the desktop (which should containg anyting at all except a gray background). Now, outside the XBMC window, right click and a pop-up menu will show up. This pop-up menu allows you to launch a web browser (`Chromium` by default) and the console terminal.

> The procedure described above is very important. It will be used to launch and configure the emulators <emphasis>BEFORE</emphasis> they can be used by the XBMC launcher plugins. This procedure will be referred as "set XBMC into windowed mode and launch a terminal" in this guide.

## Deactivating the screensaver

To show the current screensaver and DPMS settings execute
```
$ xset q
```

In the OpenBox session, DPMS is no.

In order to disable it, xset settings can be place in xprofile file

After restarting the OpenBox XBMC session, everything seems OK: DPMS 
is disabled.

[ArchLinux wiki Display Power Management Signaling](https://wiki.archlinux.org/index.php/Display_Power_Management_Signaling)

[ArchLinux wiki Xprofile](https://wiki.archlinux.org/index.php/Xprofile)

## Sound


a) XBMCBuntu uses Pulseaudio... yes. If XBMC is started in a OpenBox session
then pulseaudio is started also.

In Ghotam XBMCbuntu pulseaudio is not installed by default.

b) Tried to remove pulseaudio... and created a custom .asoundrc with a dmix interface.
It seems to work well!!!

```
# File /home/kodi/.asoundrc
pcm.dmixer {
  type dmix
  ipc_key 2048
  slave {
    # Always use pure hw. dmix will reformat/resample audio.
    pcm "hw:0,7"
    # If you get stuttering/or non-working audio, fiddle around with these
    period_size 512
    buffer_size 4096
    # HDMI, I'll assume 48kHz
    rate 48000
    # Should be default for pretty much any soundcard.
    format S16_LE
  }
  bindings {
    0 0
    1 1
  }
}

pcm.!default {
  type plug
  slave.pcm dmixer
}

### This configuration works but does not support
### concurrency!
# pcm.!default {
#  type hw
#  card 0
#  device 7
#}
#ctl.!default {
#  type hw
#  card 0
#  device 7
#}
------------------------------------------------------------------------------
```

c) For SDL applications, there are several environment variables name SDL_* that can
be used to configure the audio driver and the sound card for a specific driver. Check
SDL documentation for that.

d) If several ALSA applications should share the same sound card, the a configuration file
.asoundrc, with a mixer device, should be created. Also, make sure that XBMC uses this
mixer device instead of the soundcard. If not, XBMC can block the ALSA sound device.

Add stuff about the USB sound card, and about Mednafen's problems with dmix devices
(sound latency and emulator unresponsivenes).

e) To list the sound cards in the system use

```
$ aplay -l
```

To set the volumen of the sound card use

```
$ alsamixer -c NN
```

where NN is the soundcar number (0, 1, ...). If only one sound card is in the system then it is not necessary to use the -c option. Make sure all sound card volumes are at maximum!

## Networking

Connecting the NAS to the Buffalo router makes the network almost unusable for watching pictures or movies. Maximum speed of the wireless connection is about 1 Mbyte/s. To solve this, I will connect the NAS to the Gigabit ethernet port of the Intel NUC. The Intel NUC will act as a router so the NAS can be accesed from the wireless network.

The Buffalo has an option to do routing (move packets to subnetworks). For example,

```
Buffalo wireless network: 192.168.11.1/255.255.255.0
 |
Intel NUC wlan0: 192.168.11.7/255.255.255.0
 |
 | IPv4 Routing
 |
Intel NUC eth0: 192.168.12.1/255.255.255.0
 |
NAS: 192.168.12.2/255.255.255.0
```

In the network computers, the file /etc/hosts can be edited to include the following DNS entries (append at the end).

```
---------- /etc/dnsmasq.conf ----------
# Wintermute0110 custom DNS
192.168.11.7   NUC
192.168.12.4   NAS
------------------------------------------------------------------------------
```

a) First thing is to install a DHCP server on the Intel NUC, to configure the NAS.
ArchLinux wiki (https://wiki.archlinux.org/index.php/router) proposes dnsmasq.

```
<programlisting>
---------- /etc/dnsmasq.conf ----------
# Configuration file for dnsmasq.

interface=eth0
expand-hosts
domain=internal.net

# DHCP configuration
dhcp-range=192.168.12.2,192.168.12.255,255.255.255.0,1h
dhcp-host=10:6f:3f:cb:46:b4,192.168.12.4
------------------------------------------------------------------------------
</programlisting>
```

b) Next, configure /etc/network/interfaces. If an interface is configured here,
then Network Manager will ignore it (which is good).

```
# File /etc/network/interfaces
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo eth0 wlan0
iface lo inet loopback

# Manual configuration of the interfaces for routing
iface eth0 inet static
  address 192.168.12.1
  netmask 255.255.255.0
  network 192.168.12.0
  broadcast 192.168.12.255
  up /etc/init.d/dnsmasq start
  down /etc/init.d/dnsmasq stop

iface wlan0 inet dhcp
  wpa-ssid ESSID-NAME
  wpa-psk your_password
  up   echo "1" > /proc/sys/net/ipv4/ip_forward
  down echo "0" > /proc/sys/net/ipv4/ip_forward
```

With this configuration, the interfaces should be automatically initiated
during boot.

NOTE: in Ghotam XBMCBuntu DNS stopped working, because of a bad /etc/resolv.conf.
Since I use static network configration and ifup/ifdown scripts, I 
deactivated Network Manager using
```
# stop network-manager
```

Create an override file for the upstart job:
```
# echo "manual" | sudo tee /etc/init/network-manager.override
```

and deleted /etc/resolv.conf. Then, I regenerated /etc/resolv.conf with dhclient
```
# dhclient -v wlan0
```

I am not completely sure if Network Manager was responsible of this (managing
wlan0 and or eth0, which were supposed to be unmanaged). Now it seems to work well.

## Auto mount USB removable devices

I installed the package usbmount, which is a small utility that adds a udev
rule to call itself every time a USB disk is mounted. The USB disk can be
unmounted with pumount.

Ghotam release (Ubuntu 14.04) seems to automount USB drives automatically.

## Disable core dumps

To disable nasty XBMC core dump files edit <filename>/usr/bin/xbmc</filename>, 
which is an ASCII file, and change

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
