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

| Mednafen name  | Full name |
|----------------|-----------|
| gb | GameBoy and GameBoy Color |
| gba | GameBoy Advance |
| nes | Nintendo Entertainment System/Famicom |
| snes | Super Nintendo Entertainment System/Super Famicom |
| gg | Sega Game Gear |
| sms | Sega Master System |
| md | Sega Genesis/MegaDrive |
| psx | Sony PlayStation |

The full documentation of Mednafen can be found [here](https://mednafen.github.io/).

## Basic Mednafen setup

The first time Mednafen is exectued it will automatically create a default configuration file and directories. Mednafen's configuration file is `~/.mednafen/mednafen-09x.cfg` (older version of Mednafen's use `~/.mednafen/mednafen.cfg`). Also, inside the `~/.mednafen/` directory you will also find the following (among other things not described in this guide),

  * `~/.mednafen/firmware/` BIOS for the PlayStation must be placed in this directory.

  * `~/.mednafen/sav/` Per-game battery backed memories and PlayStation memory cards are stored in this directory.

  * `~/.mednafen/snap/` Game screenshots are stored here.

The default parameters should be fine to run Mednafen for the first time.

## Running Mednafen from the command line

At the time of writing this guide, Mednafen remembers the command line arguments in its configuration file so they remain set (or unset)at next program call. The following list shows the main parameters you will need,

  * `-video.fs {1|0}` Full screen.

  * `-sounddevice {devName}` ALSA sound device name. Mednafen is very picky about the audio driver you use, and you will experience small sound clicks if the sound driver delay is high. See below about how to choose the sound device name {devName}.

  * `-sound.driver alsa` I recommend to use ALSA here. Check Mednafen documentation for more options here.

  * `-sms.scanlines {opacity}` Use scanlines with {opacity} between -100 and 100.

  * `-sms.stretch {value}` Stretch the emulated screen to fill the "real" screen. {value} = 0 disables stretch. {value} = aspects fills the screen preserving console aspect ratio. {value} = aspect_int fills the screen but uses integer scaling factors.

Note that Mednafen keeps separated some of the settings for the different emulated systems (in the example, the Sega Master System is used), most importanly the joystick configuration.

This is an example of how to run Mednafen from the command line. You will use this when configuring the XBMC launcher plugins. It is recommended that you run XBMC in windowed mode, open a terminal, and try to run Mednafen before configuring the launcher plugins.

```
$ mednafen -sounddevice hw:0,7 -video.fs 1 romName.zip
```

## Basic Mednafen usage

This is a list of the basic default controls in Mednafen:

| Key | Name |
|-----|------|
| <keycap>F1</keycap> | Toggle in-game quick help screen. |
| <keycap>F5</keycap> | Save state. |
| <keycap>F7</keycap> | Load state. |
| <keycap>0-9</keycap> | Select save state slot. |
| <keycap>F2</keycap> | Activate in-game input configuration process for a command key. |
| <keycap>F10</keycap> | Reset. |
| <keycap>Esc</keycap>/<keycap>F12</keycap> | Exits the emulator |

## Control configuration

To map the emulated joystick on port 1 to your real joystick or keyboard, press <keycombo action="simul"><keycap>Shift</keycap><keycap>Alt</keycap> <keycap>1</keycap></keycombo>. Mednafen will ask you to introduce up to two keys for every emulated key/button/axis. This allows to simultaneously configure your joystick and keyboard. If only the joystick wants to be used then press twice the same button.

Mednafen has the option to emulate the quick pressing on emulated buttons. If you don't have enought buttons in your real joystick for this or don't want to use this feature, then use unused keys in the keyboard when asked for "Rapid {button}". Remember to press twice the same key if you only want to map that key (as opposed to two different keys/joystick buttons).

A very nice thing about Mednafen is that it allows you to remap not only emulated joysticks keys, but also "control keys", for example, to exit the emulator, reset the emulated system, etc. This feature makes Mednafen very HTPC-friendly because a key can be mapped to exit the emulator from your real joystick and return to XBMC after you finish your play.

The default key to exit Mednafen is <keycap>Esc</keycap>. To remap this key, press . Mednafen will ask you to introduce up to two keyboard keys/joystick buttons. In the case of the Logitech F710 joystick, I use the <keycap>Logicool button</keycap> and then <keycap>Esc</keycap>, so both the joystick and the default keyboard key can be used to exit Mednafen

## Playstation BIOS

In order to play PlayStation games, Mednafen requires that the proper PlayStation BIOSes placed into <filename>WRITE ME</filename>. The files you need are:

  * `scph5500.bin` SCPH-5500 BIOS image. Required for Japan-region games.

  * `scph5501.bin` SCPH-5501 BIOS image. Required for North America/US-region games. Reportedly the same as the SCPH-7003 BIOS image.

  * `scph5502.bin` SCPH-5502 BIOS image. Required for Europe-region games.

These PSX BIOS files can be obtained from the MESS BIOS collection (or you can try to dump your own, of course). For more information, check Mednafen's [PlayStation module documentation](https://mednafen.github.io/documentation/psx.html).
