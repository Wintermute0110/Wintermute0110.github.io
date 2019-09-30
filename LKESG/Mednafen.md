---
layout: post
title: "Mednafen usage notes"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

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
