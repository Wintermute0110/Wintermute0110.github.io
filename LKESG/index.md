---
layout: post
title: "Linux and Kodi Emulation Setup Guide"
author: Wintermute0110
---

**Information in this guide is terribly outdated.**

- TOC
{:toc}

[Go to main page](../)

## Introduction

This guide started as a set of personal notes I created when doing my first HTPC setup, based on XBMCbuntu installed on an Intel NUC. They proved very useful when I had to upgrade from XBMC Frodo to XBMC Gotham, were I dediced to reinstall the system from scratch to upgrade from 32-bit to 64-bit Linux kernel.

I spent hours and hours looking into the XBMC forum, other forums, web pages, tutorial here and there, etc. and eventually I decided to put all together and release this in the hope that it will be useful for the community.

## Common commands and procedures

This section describes some commands and procedures that you will use most when configuring you XBMC setup using this guide.

### Basic Linux commands and keystrokes

Tell about the key combination Alt+Crtl+1 to switch from graphical to console mode and similar stuff...

### Normal user, super user, and rebooting the system

### Installing software and upgrading your system

### Editing files

### Managing files: Midnight Commander

### Services

Services (also called <emphasis>daemons</emphasis>) are programs running in the
background that carry out many tasks. For example, the session manager (the graphical
program that greets you and prompts for use name and password and starts either XBMC
or a desktop session like KDE) is a service. It is useful to know how to start, stop,
and reload servicces.

XBMCUbuntu uses `upstart` to run services. To start a service, type as root:
```
# start {service_name}
```

To stop a service, use the <command>stop {service_name}</command> command. <command>restart {service_name}</command> reloads a service. This is very useful when you change some configuration and want to make those changes effecctive whithout rebooting the system. To list available services in your system type
```
# initctl list
```

### Passwordless SSH login

Justify why SSH login is needed and also talk about the dangers!

Never ever allow automatic login from your HTPC to your desktop/laptop computers!

Let's suppose your are operating on the host debian-laptop with username wintermute and want to automatically be able to log into host NUC (which hosts your mediacenter) with user wintermute. Then follow this steps.

 * Create a public-private key pair without any password

   ```
wintermute@laptop:~$ ssh-keygen -t rsa -f ~/.ssh/wintermute-NUC -N ""
   ```

 * Add the private key into the archive default file for private keys

   ```
laptop:~$ cd ~/.ssh/
laptop:~/.ssh$ cat wintermute-NUC >> id_rsa
laptop:~/.ssh$ chmod 600 id_rsa
   ```

 * Add the public key into the `authorized_keys` file into the remote host.
```
laptop:~/.ssh$ ssh wintermute@NUC mkdir -p ~/.ssh
laptop:~/.ssh$ cat wintermute-NUC.pub | ssh wintermute@NUC "cat - >> ~/.ssh/authorized_keys"
```

   The first command creates the directory `~/.ssh/` in the remote host NUC in the unlikely case that it has not been created yet. You can safely avoid this command if the directory already exists.


 * Test your setup. You should be able to SSH to your HTPC without being asked for a password.

 ```
laptop:~$ ssh wintermute@NUC
Welcome to Ubuntu 14.04 LTS - XBMCbuntu (GNU/Linux 3.13.0-29-generic x86_64)

Documentation:  https://help.ubuntu.com/

Last login: Sat Jul  5 01:16:52 2014 from 192.168.11.3
NUC:~$
```

It is very important to set the correct permissions and ownership in the `authorized_keys` file in the remote host. For a user named wintermute they should be:
```
$ ls -l authorized_keys
bla bla bla
```

If wrong, permissions and ownership can be changed with the following commands.
```
$ chown wintermute:wintermute authorized_keys
$ chmod 600 authorized_keys
```

## Installing and configuring XBMCbuntu Ghotam edition


### XBMC launching whitin a window manager

> Launching emulators without a window manager causes problems in XBMCbuntu. The suggested solution is to install `OpenBox` and configure it to autostart XBMC.

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

Next, `openbox-session` launchs the file <filename>~/.config/openbox/autostart.sh</filename> automatically. This file is a good place to launch XBMC.

```
# Init script for OpenBox
# This script is called by openbox-session on startup
xbmc-standalone &amp;
```

After making this changes reboot your system and when the session manager
shows (<command>lightdm</command>) start the session named 
<command>Openbox</command>. This session should be started automatically
every time the system boots, launching XBMC automatically.

To test if XBMC is running within the window manager `OpenBox`, in XBMC go to `Settings`, `System`, `Video Output` and select windowed 
display mode. XBMC should display with a window border and you will see the desktop (which should containg anyting at all except a gray background). Now, outside the XBMC window, right click and a pop-up menu will show up. This pop-up menu allows you to launch a web browser (`Chromium` by default) and the console terminal.


> The procedure described above is very important. It will be used to launch and configure the emulators <emphasis>BEFORE</emphasis> they can be used by the XBMC launcher plugins. This procedure will be referred as "set XBMC into windowed mode and launch a terminal" in this guide.

### Deactivating the screensaver

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

### Sound


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

### Networking

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

### Auto mount USB removable devices

I installed the package usbmount, which is a small utility that adds a udev
rule to call itself every time a USB disk is mounted. The USB disk can be
unmounted with pumount.

Ghotam release (Ubuntu 14.04) seems to automount USB drives automatically.

### Disable core dumps

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

## Gamepad configuration

### Logitech F710

The wireless joystick I have is a Logitech F710. More info and documentation on http://gaming.logitech.com/en-us/product/f710-wireless-gamepad

This is the output of `dmesg` just after the joystick is plugged in

```
[ 1161.417155] usb 2-1.7: new full-speed USB device number 6 using ehci_hcd
[ 1161.512684] usb 2-1.7: New USB device found, idVendor=046d, idProduct=c22f
[ 1161.512699] usb 2-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[ 1161.512710] usb 2-1.7: Product: Logicool Cordless RumblePad 2
[ 1161.512721] usb 2-1.7: Manufacturer: Logicool
[ 1161.516099] hid-generic 0003:046D:C22F.0003: hiddev0,hidraw0: USB HID v1.11 Device [Logicool Logicool Cordless RumblePad 2] on usb-0000:00:1d.0-1.7/input0
[ 1161.517662] hid-generic 0003:046D:C22F.0004: hiddev0,hidraw1: USB HID v1.11 Device [Logicool Logicool Cordless RumblePad 2] on usb-0000:00:1d.0-1.7/input1
[ 1177.329515] usb 2-1.7: USB disconnect, device number 6
[ 1177.783171] usb 2-1.7: new full-speed USB device number 7 using ehci_hcd
[ 1177.878820] usb 2-1.7: New USB device found, idVendor=046d, idProduct=c21f
[ 1177.878839] usb 2-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1177.878888] usb 2-1.7: Product: Wireless Gamepad F710
[ 1177.878899] usb 2-1.7: Manufacturer: Logicool
[ 1177.878908] usb 2-1.7: SerialNumber: 12199EDB
[ 1177.880308] Registered led device: xpad1
[ 1177.880532] input: Generic X-Box pad as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.7/2-1.7:1.0/input/input6
```

Linux detects this joystick as a Generic X-Box pad.

In Ubuntu (and Debian) the package <command>joystick</command> provides some console 
  tools to map the joystick buttons and to calibrate the joystick. There is also a graphical
  calibration tool in package <command>jstest-gtk</command>.

Executing 
```
$ jstest /dev/input/js0
```

these are the buttons and axis of the joystick (when the MODE LED is off)

<table frame="all">
<tgroup cols="4">
<thead>
  <row><entry>Axis name</entry><entry>Description</entry>
       <entry>Button name</entry><entry>Description</entry></row>
</thead>
<tbody>
  <row><entry>Axis 0</entry><entry>Left analog horizontal</entry>
       <entry>Button 00</entry><entry>A</entry></row>
  <row><entry>Axis 1</entry><entry>Left analog vertical</entry>
       <entry>Button 01</entry><entry>B</entry></row>
  <row><entry>Axis 2</entry><entry>Back left button (L2 trigger)</entry>
       <entry>Button 02</entry><entry>X</entry></row>
  <row><entry>Axis 3</entry><entry>Right analog horizontal</entry>
       <entry>Button 03</entry><entry>Y</entry></row>
  <row><entry>Axis 4</entry><entry>Right analog vertical</entry>
       <entry>Button 04</entry><entry>Back left (L1)</entry></row>
  <row><entry>Axis 5</entry><entry>Back right button (R2 trigger)</entry>
       <entry>Button 05</entry><entry>Back right (R1)</entry></row>
  <row><entry>Axis 6</entry><entry>D-pad horizontal (hat)</entry>
       <entry>Button 06</entry><entry>BACK</entry></row>
  <row><entry>Axis 7</entry><entry>D-pad vertical (hat)</entry>
       <entry>Button 07</entry><entry>START</entry></row>
  <row><entry></entry><entry></entry>
       <entry>Button 08</entry><entry>Logicool button</entry></row>
  <row><entry></entry><entry></entry>
       <entry>Button 09</entry><entry>Left analog pad center</entry></row>
  <row><entry></entry><entry></entry>
       <entry>Button 10</entry><entry>Right analog pad center</entry></row>
</tbody>
</tgroup>
</table>

XBMC needs a joystick mapping file. There are some examples 
in <filename>/usr/share/xbmc/</filename>. The appropiate file should be 
copied to <filename>~/.xbmc/userdata/keymaps/joystick.SOMENAME.xml</filename>

In my case I used <filename>joystick.Logitech.RumblePad.2.xml</filename>. 
After rebooting XBMC... the
joystick doesn't work. I enabled logging and rebooted. And then it started working!!!
Maybe the calibration of the joystick is not good...

The kernel driver for this Logitech Joystick is <command>xpad</command>. 
The user space driver <command>xboxdrv</command> has many configuration options 
and also support button remmaping.

One interesting thing is to configure L2 and R2 as buttons rather than
analog triggers. To do that with xpad, use the option XXXX (according
to the documentation only works for non recognised XBox joysticks).

ArchLinux has a very nice description about how to set up kernel modules
here https://wiki.archlinux.org/index.php/kernel_modules

To show information about a module

<screen>
$ modinfo module_name
</screen>

To list the options that are set for a loaded module

<screen>
$ systool -v -m module_name
</screen>

For the Logicool_Wireless_Gamepad_F710, the module xpad is loaded. You can 
modify the module's operation with three parameters:

<itemizedlist mark='bullet'>
<command>dpad_to_buttons</command> Map D-PAD to buttons rather 
    than axes for unknown pads.

<command>triggers_to_buttons</command> Map triggers to buttons 
    rather than axes for unknown pads.

<command>sticks_to_null</command> Do not map sticks at all for 
    unknown pads.
</itemizedlist>

Activating the option triggers_to_buttons makes the analog back triggers to
behave like buttons and not axis

```
$ rmmod xpad
$ modprobe xpad triggers_to_buttons=1
```

To make this permanent, create the file <filename>/etc/modprobe.d/F710.conf</filename> 
and insert

```
# Logitech F710 Wireless joystick
# Make back triggers to behave like buttons and not axes
# Useful for Playstation emulators
options xpad triggers_to_buttons=1
```

With the triggers_to_buttons option ON, the configuration of the joystick,
as seen by <command>jstest</command>, is

<table frame="all">
<tgroup cols="4">
<thead>
  <row><entry>Axis name</entry><entry>Description</entry>
       <entry>Button name</entry><entry>Description</entry></row>
</thead>
<tbody>
  <row><entry>Axis 0</entry><entry>Left analog horizontal</entry>
       <entry>Button 00</entry><entry>A</entry></row>
  <row><entry>Axis 1</entry><entry>Left analog vertical</entry>
       <entry>Button 01</entry><entry>B</entry></row>
  <row><entry>Axis 2</entry><entry>Right analog horizontal</entry>
       <entry>Button 02</entry><entry>X</entry></row>
  <row><entry>Axis 3</entry><entry>Right analog vertical</entry>
       <entry>Button 03</entry><entry>Y</entry></row>
  <row><entry>Axis 4</entry><entry>D-pad horizontal (hat)</entry>
       <entry>Button 04</entry><entry>Back left (L1)</entry></row>
  <row><entry>Axis 5</entry><entry>D-pad vertical (hat)</entry>
       <entry>Button 05</entry><entry>Back right (R1)</entry></row>
  <row><entry></entry><entry></entry><entry>Button 06</entry><entry>Back left trigger (L2)</entry></row>
  <row><entry></entry><entry></entry><entry>Button 07</entry><entry>Back right trigger (R2)</entry></row>
  <row><entry></entry><entry></entry><entry>Button 08</entry><entry>BACK</entry></row>
  <row><entry></entry><entry></entry><entry>Button 09</entry><entry>START</entry></row>
  <row><entry></entry><entry></entry><entry>Button 10</entry><entry>Logicool button</entry></row>
  <row><entry></entry><entry></entry><entry>Button 11</entry><entry>Left analog pad center</entry></row>
  <row><entry></entry><entry></entry><entry>Button 12</entry><entry>Right analog pad center</entry></row>  
</tbody>
</tgroup>
</table>

Note that in XBMC and some other programs, the button and axis numbers starts 
counting from 1 and not from 0. This should be taken into account when doing
the configuration.
</sect2>

## Mednafen

Mednafen is a fine emulator available for many operating systems. The following table lists the name of some of the console systems emulated.

<table frame="all">
<title>Mednafen most popular emulated systems</title>
<tgroup cols="2">
  <thead>
    <row><entry>Mednafen name</entry><entry>Full name</entry></row>
  </thead>
  <tbody>
    <row><entry>gb</entry><entry>GameBoy and GameBoy Color</entry></row>
    <row><entry>gba</entry><entry>GameBoy Advance</entry></row>
    <row><entry>nes</entry><entry>Nintendo Entertainment System/Famicom</entry></row>
    <row><entry>snes</entry><entry>Super Nintendo Entertainment System/Super Famicom</entry></row>
    <row><entry>gg</entry><entry>Sega Game Gear</entry></row>
    <row><entry>sms</entry><entry>Sega Master System</entry></row>
    <row><entry>md</entry><entry>Sega Genesis/MegaDrive</entry></row>
    <row><entry>psx</entry><entry>Sony PlayStation</entry></row>
  </tbody>
</tgroup>
</table>

The full documentation of Mednafen can be found <ulink url="http://mednafen.sourceforge.net/documentation/">here</ulink>.

### Updating Mednafen (optional)

Mednafen version in Trusty is very old (0.8.D.3). Use the following 
<ulink url="http://www.ubuntuupdates.org/ppa/getdeb_games?dist=trusty">PPA</ulink>
to install the latests version (the PPA also has lots of other games and emulators,
have a look). To activate the PPA, create the file 
<filename>/etc/apt/sources.list.d/getdeb.list</filename> and insert

```
# Getdeb PPA for mednafen and other games and emus
deb http://archive.getdeb.net/ubuntu trusty-getdeb games
```

### Basic Mednafen setup

The first time Mednafen is run it will
automatically create a default configuration file and directories.
Mednafen's configuration file
is <filename>~/.mednafen/mednafen-09x.cfg</filename> (older version of
Mednafen's use 
<filename>~/.mednafen/mednafen.cfg</filename>). Also, inside the 
<filename>~/.mednafen/</filename> directory you will also find the following
(among other things not described in this guide),

<itemizedlist mark='bullet'>
<filename>~/.mednafen/firmware/</filename> BIOS for the PlayStation must
be placed in this directory.

<filename>~/.mednafen/sav/</filename> Per-game battery backed
memories and PlayStation memory cards are stored in this directory.

<filename>~/.mednafen/snap/</filename> Game screenshots are stored 
here.
</itemizedlist>

The default parameters should be fine to run Mednafen for the first time.

### Running Mednafen from the command line

At the time of writing this guide, Mednafen remembers 
the command line arguments in its configuration file so they remain set 
(or unset)at next program call. The following list shows the main parameters
you will need,

<itemizedlist mark='bullet'>
<command>-video.fs {1|0}</command> Full screen.

<command>-sounddevice {devName}</command> ALSA sound device name.
Mednafen is very picky about the audio driver you use, and
you will experience small sound clicks if the sound driver delay is high. See below
about how to choose the sound device name {devName}.

<command>-sound.driver alsa</command> I recommend to use ALSA here. Check
Mednafen documentation for more options here.

<command>-sms.scanlines {opacity}</command> Use scanlines with {opacity} 
between -100 and 100.

<command>-sms.stretch {value}</command> Stretch the emulated screen
to fill the "real" screen. {value} = 0 disables stretch. {value} = aspects fills 
the screen preserving console aspect ratio. {value} = aspect_int fills the 
screen but uses integer scaling factors.
</itemizedlist>

Note that Mednafen keeps separated 
some of the settings for the different emulated systems (in the example, the
Sega Master System is used), most importanly the joystick configuration.

This is an example of how to run Mednafen from
the command line. You will use this when configuring the XBMC launcher plugins.
It is recommended that you run XBMC in windowed mode, open a terminal, and try to
run Mednafen before configuring the launcher plugins.

```
$ mednafen -sounddevice hw:0,7 -video.fs 1 romName.zip
```

### Basic Mednafen usage

This is a list of the basic <emphasis>default</emphasis> controls in Mednafen

<itemizedlist mark='bullet'>
<keycap>F1</keycap> Toggle in-game quick help screen.
<keycap>F5</keycap> Save state.
<keycap>F7</keycap> Load state.
<keycap>0-9</keycap> Select save state slot.
<keycap>F2</keycap> Activate in-game input configuration process for a command key.
<keycap>F10</keycap> Reset.
<keycap>Esc</keycap>/<keycap>F12</keycap> Exits the emulator
</itemizedlist>

### Control configuration

To map the emulated joystick on port 1 to your real joystick or keyboard, 
press <keycombo action="simul"><keycap>Shift</keycap><keycap>Alt</keycap>
<keycap>1</keycap></keycombo>. Mednafen will ask
you to introduce up to two keys for every emulated key/button/axis. This
allows to simultaneously configure your joystick and keyboard. If only the
joystick wants to be used then press twice the same button.

Mednafen has the option to emulate the quick
pressing on emulated buttons. If you don't have enought buttons in your real
joystick for this or don't want to use this feature, then use unused keys 
in the keyboard when asked for "Rapid {button}".
Remember to press twice the same key if you only want to map that key (as
opposed to two different keys/joystick buttons).

A very nice thing about Mednafen is that it
allows you to remap not only emulated joysticks keys, but also "control keys",
for example, to exit the emulator, reset the emulated system, etc. This feature
makes Mednafen very HTPC-friendly because a key can be
mapped to exit the emulator from your real joystick and return to XBMC after you
finish your play.

The default key to exit Mednafen is 
<keycap>Esc</keycap>. To remap this key, press . 
Mednafen will ask you to introduce up to two keyboard
keys/joystick buttons. In the case of the Logitech F710 joystick, I use the
<keycap>Logicool button</keycap> and then <keycap>Esc</keycap>, so both the
joystick and the default keyboard key can be used to exit 
Mednafen

### Playstation BIOS

In order to play PlayStation games, Mednafen requires that the proper PlayStation BIOSes placed into <filename>WRITE ME</filename>. The files you will need are:

<itemizedlist mark='bullet'>
<filename>scph5500.bin</filename> SCPH-5500 BIOS image. Required 
for Japan-region games.

<filename>scph5501.bin</filename> SCPH-5501 BIOS image. Required 
for North America/US-region games. Reportedly the same as the SCPH-7003 BIOS image.

<filename>scph5502.bin</filename> SCPH-5502 BIOS image. Required 
for Europe-region games.
</itemizedlist>

These PSX BIOS files can be obtained from the MESS BIOS
collection (or you can try to dump your own, of course).

For more information, check Mednafen's
<ulink url="http://mednafen.sourceforge.net/documentation/psx.html">PlayStation 
documentation</ulink>.

## MAME

The Multi Arcade Machine Emulator needs little introduction.

If you have doubts check the MAME
<ulink url="http://www.mamedev.org/devwiki/index.php?title=Frequently_Asked_Questions">FAQ</ulink>.

### Updating MAME (optional)

The MAME version in Trusty is old (0.152). The following
<ulink url="https://launchpad.net/~c.falco/+archive/mame">PPA</ulink>
contains up-to-date versions of MAME. Create the file 
<filename>/etc/apt/sources.list.d/mamePPA.list</filename> 
and insert

```
<programlisting>
# Cesare Falco unofficial MAME builds
deb http://ppa.launchpad.net/c.falco/mame/ubuntu trusty main 
deb-src http://ppa.launchpad.net/c.falco/mame/ubuntu trusty main 
</programlisting>
```

It's much more convenient to configure MAME to 
use an offline scraper, and provide the downloaded artwork and games description
files. Have a look at
https://code.google.com/p/romcollectionbrowser/wiki/HowToAddMAMEOffline

### Basic MAME setup

The first time that MAME is run it will
create the directory <filename>~/.mame</filename> to store its stuff. A full screen
information window will show up stating "No games found. Check your rompath".

The first step is to create a default configuration file and move it
to the <filename>~/.mame</filename>. Execute

<screen>
$ mame -createconfig
$ mv mame.ini .mame
</screen>

Create a folder <filename>~/ROMs/roms-mame</filename> and put some MAME ROMs there to test

```
$ mkdir ~/ROMs/roms-mame/
$ cp romName.zip ~/ROMs/roms-mame/
```

Next, edit the mame configuration file <filename>~/.mame/mame.ini</filename> and locate the following line

```
...
rompath $HOME/mame/roms;/usr/local/share/games/mame/roms;/usr/share/games/mame/roms
...
```

and change it into this

```
...
rompath $HOME/ROMs/roms-mame
...
```

If you now execute MAME it will show you a list of the games you copied into <filename>~/ROMs/roms-mame</filename> and also an option to configure the controls.

### Running MAME from the command line

This is an example of how to run MAME from the command line.

<screen>
$ mame romName
</screen>

MAME uses the SDL library
for video and sound. If you want to force SDL to use ALSA and a specific
sound card other than the default then execute

<screen>
$ export SDL_AUDIODRIVER=alsa
$ export AUDIODEV=hw:1,3
$ mame romName
</screen>

By default, MAME should start in full screen mode. If not,
edit <filename>~/.mame/mame.ini</filename> and change

```
...
window 1
...
```

into

```
...
window 0
...
```

### Basic MAME usage

MAME has a nice in-game menu that can be used to change the controls and other settings. This is a short list of the most useful default controls.

| Key | Control |
|-----|---------|
| `TAB` | Open/Closes the in-game configration menu. |
| `Esc` | Exits the emulator. User Interface cancel. |
| `5`  | Player 1 insert coin |
| `1` | Player 1 start |

### Control configuration

Most controls can be configured from the in-game menu, as described [here](http://www.mamedev.org/devwiki/index.php?title=FAQ:Controls#How_do_I_configure_the_keys.3F").

Press <keycap>Tab</keycap> in-game and choose Input: general
to configure controls for all games, or Input: This Game to
change controls only for the running game. Then, select the input you want to configure, press enter 
followed by the key you want it mapped to. More fancy key combinations can be made. 
To map this key OR that key, set one of the keys as before, wait until 
MAME accepts it, then repeat for second key.


For the Logitech F710 joystick, this are the recommended controls to remap

In Input: general -> Player 1 controls remap P1 Up, P1 Down, P1 Left, P1 Right to the joystick D-pad and the keyboard arrows.

In Input: general -> Player 1 controls remap P1 Button 1, P1 Button 2, P1 Button 3, and P1 Button 4 to the joystick 4 central buttons (and some keys if you want).

In Input: general -> Other controls remap 1 Player Start to the joystick <keycap>START</keycap> button and Coin 1 to the joystick <keycap>BACK</keycap> button.

Finally, in Input: general -> User Interface 
remap UI Select to the joystick button <keycap>A</keycap> and to
the default key <keycap>RETURN</keycap> (it is important to being able to control the
User Interface both with the joystick and the keyboard),
Config Menu to the joystick button <keycap>Right analog pad center</keycap>
and to the default key <keycap>TAB</keycap>, and
UI Cancel to the F710 joystick button <keycap>Logicool button</keycap>
and to the default key <keycap>ESC</keycap>.
Note that UI Cancel is used to exit the menu, but also to
exit the emulator and return to XBMC.

Additionally, controls can be configured editing the file `~/.mame/cfg/default.cfg`, which is an XML file. You will only see entries in this file for key bindings you have modified (an not the defaults). Editing this file is useful when you do a mistake using the User Interface and want to roll-back to default controls. If you decide to change this file,  keep in mind that in MAME joystick buttons are numbered from 1 to N, not from 0 to N-1 like in `jstest`.

## RetroArch

RetroArch is a multi-system emulator that
keeps separated the emulator graphical user interface from the emulation
engine (referred as <emphasis>cores</emphasis> in RetroArch).
This emulator is very friendly with HTPC setups because you can configure
all the settings from your joystick, among other things. It takes a bit
of effort to set it up, but once this is done you can emulate a vast
number of systems easily. The main cores currently 
implemented in RetroArch are

<itemizedlist mark='bullet'>
<command>libretro-bsnes</command> bSNES/Higan (Super Nintendo)
<command>libretro-bnes</command> bNES/Higan (Nintendo 8 bit)
<command>libretro-genplus</command> Genesis Plus GX (Sega Master System/MegaDrive)
<command>libretro-pcsx-rearmed</command> PCSX ReARMed (PlayStation1)
<command>libretro-mednafen</command> Mednafen many cores
<command>libretro-picodrive</command> Picodrive (Sega 8/16bit/32X/MegaCD)
<command>libretro-mupen64plus</command> Mupen64Plus (Nintendo 64)
<command>libretro-meteor</command> Meteor (GameBoy Advance)
<command>libretro-vba-next</command> VBA Next (GameBoy Advance)
</itemizedlist>

A full list of the supported cores is [here](http://www.libretro.com/index.php/ecosystem/"). This list is a bit outdated and a lot of work is currently going on. Have a look here for the [GitHub repository](https://github.com/libretro/RetroArch/) where you can always find the latest information. The best source of RetroArch documentation is the [GitHub Wiki](https://github.com/libretro/RetroArch/wiki").

There is a PPA offering Retroarch packages. However, it is not very difficult
to build it from source. Also, be aware that the configuration depends on
the installation path of the executables!

### Compiling RetroArch (Manual method)

This is a step by step guide similar to the one found [here](https://github.com/libretro/RetroArch/wiki/Compilation-guide-%28Linux%29).


 * Create the folder <filename>~/bin/emu-libretro-super</filename>
   ```
$ mkdir ~/bin
$ mkdir ~/bin/emu-libretro-super
$ cd ~/bin/emu-libretro-super
```

 * Fetch <command>libretro-super</command> from GitHub
```
$ git clone git://github.com/libretro/libretro-super.git
```

 * Edit `./libretro-super/libretro-fetch.sh` to install only the wanted emulation cores. At the end of the file you will see

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

 * Now grab the source code of the cores you want to compile and RetroArch graphical user interface RGUI
```
$ cd libretro-super
$ sh libretro-fetch.sh
```

 * Before compiling, install the mandatory dependencies (that is, software you need in order to build programs) required to build the cores. As root, execute

   ```
# apt-get install build-essential
   ```

 * Now compile the cores. If you choose to compile all the cores, then it can take a while.
```
$ sh libretro-build.sh
```

It's not necessary to edit retroarch-build.sh to avoid compilation of uninstalled
cores. The script automatically compiles only the cores that have been fetched.


 * To compile RetroArch graphical interface, <command>RGUI</command>, first install some more dependencies. RetroArch's dependencies can be tested with
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

 * Compile <command>RGUI
```
$ sh retroarch-build.sh
```

 * After compilation, test RetroArch
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

### Compiling RetroArch (Scripted method)


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

### Basic RetroArch setup

The main configuration file is located on 
`~/.config/retroarch/retroarch.cfg`.
Execute RetroArch once to create a default configuration file. There 
is an example of a configuration file located in [Github](https://github.com/libretro/RetroArch/blob/master/retroarch.cfg").
Create a directory named `~/.retroarch` to store RetroArch files (BIOS, saved games, screenshots, etc.) and then

<emphasis>Core and info directories</emphasis>: configure the 
following

```
<programlisting>
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
</programlisting>

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
<programlisting>
screenshot_directory = "~/.retroarch/screenshot/"
</programlisting>



<emphasis>ROM browser directory</emphasis> is where your ROMs are. You can
always navigate using RGUI, but if you configure it loading ROMs will be
much faster.

Change the following option in <filename>~/.config/retroarch/retroarch.cfg</filename>
<programlisting>
rgui_browser_directory = "~/ROMs"
</programlisting>



<emphasis>Cheats database (optional, avoids one warning when running RetroArch)</emphasis> 
stores cheats for your games. Firsly, create a file named 
<filename>~/.retroarch/cheat_database.xml</filename> and insert
```
<programlisting language="XML" role="XML">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;codelist>
&lt;game>
&lt;/game>
&lt;/codelist>
</programlisting>
```

Change the following option in <filename>~/.config/retroarch/retroarch.cfg</filename>
```
cheat_database_path = "~/.retroarch/cheat_database.xml"
```

### Running RetroArch from the command line

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

### Basic RetroArch usage

This is a list of the basic default controls in RGUI

```
<keycap>Arrows</keycap> navigate through RetroArch's RGUI.
<keycap>X</keycap> Accept/OK.
<keycap>Z</keycap> back.
<keycap>F1</keycap> while in game, show RGUI interface (and
pauses the game).
<keycap>ESC</keycap> Exits RetroArch.
```

If you wish to test RetroArch, first load an appropiate core in Core..., and then load the ROM in Load content (CoreName)... Once you configure your joystick, you will be able to control most RetroArch settings and load cores/games with the joystick.

### Control configuration

To configure the joystick, use the RGUI interface xxxxx.

Next, configure one joystick button to access the RGUI interface and other
to exit RetroArch. The easiest way to do it is editing the file 
<filename>~/.config/retroarch/retroarch.conf</filename>

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

### PSX BIOS

WRITE ME

### Sega MegaCD BIOS
 
WRITE ME

## Configuring XBMC's emulator launcher plugins

I have to think how to organise this...

At this point of the guide, you should have a running XBMC system
that executes XBMC within a window manager. You are able to set XBMC
in a Window, open a terminal console and launch one emulator from there.
You will also have some ROMs organized into the appropriate directories.
Now it's time to set up XBMC so you can nicely launch the emulator/s of
your choice from its graphical interface

 * Rom Collection Browser: it is the default XBMC launcher plugin. This plugin is on
the official repositories. The plugin seems to work well (once the window manager
issue has been solved). However, this plugin is EXTREMELY SLOW when scraping
ROM collections. Even if local art work exists (for example, MAME artwork), the
scraping is very slow. It can take DAYS for large ROM collections.

   RCB creates an NFO file for every ROM it founds. This files can be used by AL to scrap game information. MAME can be configured to scrape NFO files from a customised version of CATVER.ini (however, for large collections even the offline scraper is slow).

 * Advanced Launcher: it is not as good looking as RCB, but it is much faster. Also, it support several different emulators for every ROM collection. ROM launchers can be divided into categories, so ROMs from different systems don't get mixed. Scraping is also quite fast, and only two images are required.

   Every launcher in AL can have the scrapers configure before adding ROMs.


## ROMs

Explain about the various kinds of ROM collections (NoIntro, Goodsets, TOSEC, etc.).
Also explain about the ROM naming schemes. Finally, propose a directory structure
to be created to store ROM. Also talk about ROM filtering.

## Configuring the Advanced Launcher plugin for XBMC

 * For every emulator, 2 artwork directories are required

   a) Thumbnails path

   b) Fanarts

 * Emulators added

```
<programlisting>
Arcade
|- MAME
Nintendo
|- NES (Mednafen)
|- SNES (Mednafen)
|- Game Boy Color (Mednafen)
|- Game Boy Advance (RetroArch VBA-Next)
SEGA
|- GG  (Mednafen)
|- SMS (Mednafen)
|- Genesis (Mednafen)
|- 32X (RetroArch Picodrive)
|- MegaCD (RetroArch Picodrive)
SONY
|- PSX (Mednafen)
</programlisting>
```

## Configuring the ROM Collection Browser plugin for XBMC

In this section

 * Same emulators as Advanced Launcher.

 * For every emulator, 1 artwork is required. RCB creates inside more subdirectories for the several kinds of fanart.

 * MAME is configured to scrape NFO files and artwork offline.

 * Console systems are configure to scrape information and configuration online.


## TODO

 * Finish the scripts to copy/update console ROMS. Modify the scripts so they gather the ROMS from the torrent file rather than create intermediate folders with the ROMS.

 * The scripts to update console ROMS should create a log file with the ROMs copied.

 * Improve the script to copy/update MAME roms, so ROMs are updated according to the list.

 * Guess a methodology to update the ROM collections in AL and RCB which doesn't take very long. Scraping a whole ROM collection takes many hours!

 * Make a PERL script to check the configuration of AL, and maybe generate it automatically... this will save a lot of time.

 * Explain how to autogenerate SSH keys for automatic login and easy backup with rsync.
