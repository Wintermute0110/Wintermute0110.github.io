---
layout: post
title: "Linux installation and initial configuration"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

In this chaper I cover the installation of Ubuntu Linux on a PC. After finish this chapter you will have a working HTPC with the network configured and ready to install Kodi, Retroarch, MAME and EmulationStation.

## Preparing the installation media

**Step 1: Download the installation ISO image** 

Use one of the Ubuntu mirrors to download the ISO image of **Ubuntu 20.04 LTS (Focal Fossa) 64-bit Server install image**. The Server install image installs only the minimum set of packages required to run Linux, as oppossed to the Desktop image which installs a lot of clutter software you do not need on an HTPC.

[Ubuntu 20.04 LTS (Focal Fossa) installation images](https://ftp.riken.jp/Linux/ubuntu-releases/focal)

**Step 2: Create a bootable USB drive** 

Plug the USB drive and use `lsblk` to know the USB drive name. For example:

```
# lsblk
sdb      8:16   1  14.9G  0 disk 
├─sdb1   8:17   1   1.6G  0 part /media/username/usb volume name
└─sdb2   8:18   1   2.4M  0 part
```

Dismount any partitions of the UBS drive if they are mounted with `umount`.

Finally, use `dd` to copy the installation ISO image into the USB drive.
`sdX` is the device name of the USB drive. **BE CAREFUL;** this is a destructive
command that will erase all the contents of the USB drive. If you specify the wrong
device name you can wipe the hard disk of your computer.

```
dd bs=4M conv=fdatasync status=progress if=path/to/input.iso of=/dev/sdX
```

[ask ubuntu: Create a bootable USB drive](https://askubuntu.com/questions/372607/how-to-create-a-bootable-ubuntu-usb-flash-drive-from-terminal)

## Installation of Ubuntu Linux

**Step 1**

Connect the NUC HDMI port to your TV or monitor. Connect a USB keyboard. The keyboard will be used for the installation and configuration. During normal you will use a gamepad to control Kodi or EmulationStation. However, a keyboard may be needed very occasionally. Finally, connect the USB drive you created in the previous step.

Switch on the power on the NUC. If necessary access the BIOS and configure it to boot from the USB drive. If you experience problems during the installation have a look to the [Install Ubuntu Server](https://ubuntu.com/tutorials/tutorial-install-ubuntu-server) guide.

 * Network configuration?

 * Best partition layout?

## Useful links

[Intel VAAPI howto with Leia v18 nightly based on Ubuntu 18.04 server](https://forum.kodi.tv/showthread.php?tid=231955)

[odroid-xu4-setup](https://github.com/yimyom/odroid-xu4-setup)


