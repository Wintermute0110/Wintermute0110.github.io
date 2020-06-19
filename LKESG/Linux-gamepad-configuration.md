---
layout: post
title: "Linux gamepad configuration"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

Nowadays most gamepads will work out of the box with Linux but ocasionally your may run into trouble. Here I will give you some examples about how to test your gamepads and how to connect/associate Bluetooth gamepads. More specific details about gamepad configuration are given in the Kodi, EmulationStation, Retroarch and MAME sections.

## Logitech F710

The wireless joystick I have is a Logitech F710. More info and documentation [here](http://gaming.logitech.com/en-us/product/f710-wireless-gamepad)

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

In Ubuntu (and Debian) the package <command>joystick</command> provides some console tools to map the joystick buttons and to calibrate the joystick. There is also a graphical calibration tool in package <command>jstest-gtk</command>.

Executing 
```
$ jstest /dev/input/js0
```

these are the buttons and axis of the joystick (when the MODE LED is off)

| Axis name | Description | Button name | Description |
|-----|-----|-----|-----|
| Axis 0 | Left analog horizontal | Button 00 | A |
| Axis 1 | Left analog vertical | Button 01 | B |
| Axis 2 | Back left button (L2 trigger) | Button 02 | X |
| Axis 3 | Right analog horizontal | Button 03 | Y |
| Axis 4 | Right analog vertical | Button 04 | Back left (L1) |
| Axis 5 | Back right button (R2 trigger) | Button 05 | Back right (R1) |
| Axis 6 | D-pad horizontal (hat) | Button 06 | BACK |
| Axis 7 | D-pad vertical (hat) | Button 07 | START |
| | | |  |  | Button 08 | Logicool button |
| | | |  |  | Button 09 | Left analog pad center |
| | | |  |  | Button 10 | Right analog pad center |

XBMC needs a joystick mapping file. There are some examples in <filename>/usr/share/xbmc/</filename>. The appropiate file should be copied to <filename>~/.xbmc/userdata/keymaps/joystick.SOMENAME.xml</filename>

In my case I used <filename>joystick.Logitech.RumblePad.2.xml</filename>. After rebooting XBMC... the joystick doesn't work. I enabled logging and rebooted. And then it started working!!! Maybe the calibration of the joystick is not good...

The kernel driver for this Logitech Joystick is <command>xpad</command>. The user space driver <command>xboxdrv</command> has many configuration options and also support button remmaping.

One interesting thing is to configure L2 and R2 as buttons rather than analog triggers. To do that with xpad, use the option XXXX (according to the documentation only works for non recognised XBox joysticks).

ArchLinux has a very nice description about how to set up kernel modules here https://wiki.archlinux.org/index.php/kernel_modules

To show information about a module

```
$ modinfo module_name
```

To list the options that are set for a loaded module

```
$ systool -v -m module_name
```

For the Logicool_Wireless_Gamepad_F710, the module xpad is loaded. You can modify the module's operation with three parameters:

<itemizedlist mark='bullet'>
<command>dpad_to_buttons</command> Map D-PAD to buttons rather 
    than axes for unknown pads.

<command>triggers_to_buttons</command> Map triggers to buttons 
    rather than axes for unknown pads.

<command>sticks_to_null</command> Do not map sticks at all for 
    unknown pads.
</itemizedlist>

Activating the option triggers_to_buttons makes the analog back triggers to behave like buttons and not axis

```
$ rmmod xpad
$ modprobe xpad triggers_to_buttons=1
```

To make this permanent, create the file <filename>/etc/modprobe.d/F710.conf</filename> and insert

```
# Logitech F710 Wireless joystick
# Make back triggers to behave like buttons and not axes
# Useful for Playstation emulators
options xpad triggers_to_buttons=1
```

With the triggers_to_buttons option ON, the configuration of the joystick, as seen by <command>jstest</command>, is

| Axis name | Description | Button name | Description |
|-----|-----|-----|-----|
| Axis 0 | Left analog horizontal | Button 00 | A |
| Axis 1 | Left analog vertical | Button 01 | B |
| Axis 2 | Right analog horizontal | Button 02 | X |
| Axis 3 | Right analog vertical | Button 03 | Y |
| Axis 4 | D-pad horizontal (hat) | Button 04 | Back left (L1) |
| Axis 5 | D-pad vertical (hat) | Button 05 | Back right (R1) |
|  |  | Button 06 | Back left trigger (L2) |
|  |  | Button 07 | Back right trigger (R2) |
|  |  | Button 08 | BACK |
|  |  | Button 09 | START |
|  |  | Button 10 | Logicool button |
|  |  | Button 11 | Left analog pad center |
|  |  | Button 12 | Right analog pad center |

Note that in XBMC and some other programs, the button and axis numbers starts counting from 1 and not from 0. This should be taken into account when doing the configuration.
