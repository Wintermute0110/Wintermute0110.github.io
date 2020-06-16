---
layout: post
title: "Linux installation and initial configuration"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

In this chaper I cover the installation of Ubuntu Linux on a PC architecture with an Intel graphics card. After finishing this chapter you will have a working home theater personal computer (HTPC) with the network configured and ready to install Kodi or EmulationStation as your frontend and optionally some emulators such as Retroarch, MAME or Mednafen.

In this guide I assume you have a Linux desktop or laptop as your main computer. Windows users will need to google a bit for additional procedures in some steps of this guide. For example, to connect to the HTPC computer using SSH Linux users can do it natively, Windows users need to use additional software such as [PuTTY](https://www.putty.org/).

During normal use of your HTPC your will control it with a gamepad. However, a keyboard and mouse will be required during the installation and configuration.

## User name and HTPC computer name

When you install Ubuntu Linux you are asked for a regular or unprivileged user name. In this guide I use the `kodi` user name with home directory `/home/kodi`. Note that you can choose the user name you want, however **BE AWARE** that you will need to change some configuration files and file path names to mach the user name.

In this guide your HTPC computer will be named `htpc`. Again, you can use the name you want but pay attention because you will need to change some commands and/or configuration files to match your HTPC name. For example, to connect to your HTPC computer using SSH you can use `kodi@htpc` where `kodi` is the user name and `htpc` is the HTPC computer name. If you use different values for the user name or computer name you will need to change or adapt the instructions of this guide accordingly.

## Preparing the installation media

We will use a USB drive to install Ubuntu 20.40 Focal Fossa.

**Step 1) Download the installation ISO image** 

Use one of the Ubuntu mirrors to download the ISO image of **Ubuntu 20.04 LTS (Focal Fossa) 64-bit Server install image**. The server install image installs only the minimum set of packages required to run Linux, as oppossed to the Ubuntu Desktop image which installs a lot of clutter software you do not need on an HTPC.

[Ubuntu 20.04 LTS (Focal Fossa) installation images](https://ftp.riken.jp/Linux/ubuntu-releases/focal)

**Step 2) Create a bootable USB drive** 

Plug in the USB drive and use `lsblk` to learn the USB drive name. For example:

```
wintermute@pc:~$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sdb      8:16   0 931.5G  0 disk 
└─sdb1   8:17   0 931.5G  0 part /home
sdc      8:32   0 447.1G  0 disk 
├─sdc1   8:33   0   953M  0 part /boot
├─sdc2   8:34   0  22.4G  0 part [SWAP]
└─sdc3   8:35   0 423.9G  0 part /
sdd      8:48   1   3.8G  0 disk 
├─sdd1   8:49   1   1.8G  0 part 
└─sdd2   8:50   1   3.7M  0 part 
```

One trick is to execute `lsblk` before you insert the USB drive, and then again with the USB drive inserted. The device name of the USB drive is the new one that show up. Dismount any partitions of the UBS drive if they are mounted with `umount`, in some systems partitions are mounted automatically when you insert removable drives.

Use `dd` to copy the installation ISO image into the USB drive. `sdX` is the device name of the USB drive, substitute the `X` with the appropiate letter. **BE CAREFUL** `dd` is a destructive command that will erase all the contents of the USB drive. If you specify the wrong device name you can wipe the hard disk of your computer. The `sync` command after `dd` is not strictly necessary but better safe than sorry.

```
root@pc:~# dd bs=4M conv=fdatasync status=progress if=path/to/input.iso of=/dev/sdX
root@pc:~# sync
```

[ask ubuntu: Create a bootable USB drive](https://askubuntu.com/questions/372607/how-to-create-a-bootable-ubuntu-usb-flash-drive-from-terminal)

## Installation of Ubuntu Linux

Connect the NUC HDMI port to your TV or monitor. Connect a USB keyboard. The keyboard will be used for the installation and configuration. During normal you will use a gamepad to control Kodi or EmulationStation. However, a keyboard may be needed very occasionally. Finally, connect the USB drive you created in the previous step.

Switch on the power on the NUC. If necessary access the BIOS and configure it to boot from the USB drive. If you experience problems during the installation have a look to the [Install Ubuntu Server](https://ubuntu.com/tutorials/tutorial-install-ubuntu-server) guide.

 * Wireless interface was not autodetected. Ethernet wired interfaces can be configured in the installation program.

 * By default the server installation creates a small `/boot/efi/` partition and then another big parition to be mounted as root with `ext4` filesystem. No swap partition is created.

 * As the **server's name** type something like **htpc**.
 
 * Create a regular user, for example with username **kodi**.

 * Install OpenSSH to be able to connect to the HTPC using SSH.

 * Once the installation has finished you are asked to remove the USB drive and then the machine is rebooted. After that Ubuntu Linux is installed and you can log into the system using your username/password. The graphical interface is not installed yet so you have the text-based console.

 * **TODO** is trim enabled for SSDs? Check this out.

## Network configuration

### Configuration of the wired Ethernet interface

-----

**TODO** Rewrite this section to use `systemd-networkd` and remove `netplan`, `NetworkManager`, etc. `systemd-networkd` has a built-in DHCP client. `systemd-networkd` requires `wpa_supplicant`. `systemd-networkd` allows to setup comples networks setups such as packet routers with NAT.

[Archwiki: Systemd-networkd](https://wiki.archlinux.org/index.php/Systemd-networkd)

### (Optional) Configuration of the wireless interface

**Step 1) Identify the name of the wifi interface**

```
kodi@htpc:~$ ls /sys/class/net
eno1   lo   wlp0s20f3
```

Wireless interface names start with `w`. In this case the interface name is `wlp0s20f3`.

**Step 2) Edit the network configuration file**

```
kodi@htpc:~$ ls /etc/netplan
00-installer-config.yaml
```

In this case edit the file using `# nano /etc/netplan/00-installer-config.yaml`. 

```
# File /etc/netplan/00-installer-config.yaml
network:
  ethernets:
    eth0:
      dhcp4: true
      optional: true
  version: 2
  wifis:
    wlp3s0:
      optional: true
      access-points:
        "SSID-NAME-HERE":
          password: "PASSWORD-HERE"
      dhcp4: true
```

**Step 3) Apply changes and test network**

```
# netplan apply
```

If there are issues use:

```
# netplan --debug apply
```

Test the network with:

```
# ip a
# ping google.com
```

NOTE Ubuntu server does not install the `wpasupplicant` package. This package needs to be installed over the wired network before the WiFi can be used. To check if the package is installed use `$ dpkg -l | grep wpa`.

[Ubuntu 20.04: Connect to WiFi from command line with Netplan](https://linuxconfig.org/ubuntu-20-04-connect-to-wifi-from-command-line)

## Installing software

```
root@htpc:~# apt install ssh software-properties-common alsa-utils lm-sensors linux-firmware git
root@htpc:~# apt install dbus-x11 openbox pastebinit udisks2 avahi-daemon
root@htpc:~# apt install xorg xserver-xorg-legacy xserver-xorg-video-intel mesa-utils 
root@htpc:~# apt install libva2 i965-va-driver intel-media-va-driver vainfo
root@htpc:~# apt install vulkan-tools
root@htpc:~# apt install xdg-screensaver
```

`xdg-screensaver` is used by Retroarch to control the screensaver.

`apt` install tons of packages by default. I think recommended packages are installed by default.

## Basic HTPC configuration

Allow **anybody** to start the X server:

```
root@htpc:~# dpkg-reconfigure xserver-xorg-legacy
```

Now edit `/etc/X11/Xwrapper.config` and add the following into a new line at the end of the file:

```
needs_root_rights=yes
```

Give privileges to the **kodi** user you created in the installation:

```
root@htpc:~# usermod -a -G cdrom,audio,video,plugdev,users,dialout,dip,input kodi
```

You can check the groups the user kodi belongs with:
```
root@htpc:~# groups kodi
kodi : kodi adm ...
```

Edit `/etc/security/limits.conf` and add before the end. Remember kodi is the username, not the application. This will allow your user to get the audio thread a bit more priority.

```
kodi             -       nice            -1
```

Now create the file `/home/kodi/.xinitrc` that will be used by `startx`.

```
# File /home/kodi/.xinitrc

# Execute an Openbox window manager session.
# Openbox will execute the contents of /home/kodi/.config/openbox/autostart
exec openbox-session
```

Now create the file `/home/kodi/.config/openbox/autostart`:

```
# File /home/kodi/.config/openbox/autostart
# Commands here are blocking. Use a trailing & to run concurrently.

# The screensaver can cause problems with EmulationStation or Kodi.
# Disable the screensaver and the power management.
# To check the status of the screensaver use the command `$ xset q`
xset s off -dpms &
```

At this point you can test the X server (graphical interface). You will need a mouse to use the X server.

```
kodi@htpc:~$ startx
```

The screen will turn black (don't panic) and you will see the mouse pointer in the middle of the screen. With a right click you can open the Openbox context menu and launch a graphic terminal. In the graphic terminal type `glxinfo`, `vulkaninfo` and `vainfo` to check that the OpenGL acceleration, Vulkan acceleration and VA-API are working well.

To exit the X server bring up the Openbox context menu with a mouse right click and click on **Exit**. You will return to the text console.

-----

[ArchLinux wiki Display Power Management Signaling](https://wiki.archlinux.org/index.php/Display_Power_Management_Signaling)

## Set permissions to shutdown, suspend and mount disks

Kodi and EmulationStation will use D-Bus to reboot and power off your HTPC and it is necessary to give privileges to the Kodi user. Create the file `/etc/polkit-1/localauthority/50-local.d/custom-actions.pkla`.

```
# File /etc/polkit-1/localauthority/50-local.d/custom-actions.pkla root:root 644
[Actions for kodi user]
Identity=unix-user:kodi
Action=org.freedesktop.login1.*;org.freedesktop.udisks2.*
ResultAny=yes
ResultInactive=yes
ResultActive=yes

[Untrusted Upgrade]
Identity=unix-user:kodi
Action=org.debian.apt.upgrade-packages;org.debian.apt.update-cache
ResultAny=yes
ResultInactive=yes
ResultActive=yes
```

## (Optional) Connecting to the HTPC with SSH

In your Linux desktop/laptop edit the file `/etc/hosts` and append at the end.

```
192.168.0.20   htpc
```

Change the IP address to the one you have assigned in your router to the HTPC computer. I recommend to assign a static IP address so it does not change when you reboot your computers. To learn the MAC address of the WiFi interface of your HTPC use the `ip a` command in the HTPC. After that, you can connect to your HTPC with `ssh kodi@htpc`.

If you don't modify `/etc/hosts` then you need to use the **IP adress** of your HTPC instead of the network name.

## (Optional) Changing the time zone

By default the UTC is used. Kodi and many emulators require that the time is correctly set to work properly. To set the correct time execute:

```
root@htpc:~# dpkg-reconfigure tzdata
```

By default `systemd` automatically sets the time of your HTPC from the network so the only thing you need to do is to configure the correct time zone where you are located.

[archlinux wiki: systemd-timesyncd](https://wiki.archlinux.org/index.php/systemd-timesyncd)

## (Optional) Install Plymouth

Plymouth seems to be already installed but it is not enabled. It doesn't hurt to make sure it is installed:

```
root@htpc:~# apt install plymouth plymouth-theme-ubuntu-logo plymouth-themes
```

Edit the file `/etc/initramfs-tools/modules` and add at the end:

```
# Intel graphics card.
i915 modeset=1
```

Then update the initramfs with `sudo update-initramfs -u`

Edit the file `/etc/default/grub` and add the `splash` word to:

```
GRUB_CMDLINE_LINUX_DEFAULT="splash"
```

If there are more arguments then add `splash` at the end separated with one space from the previous word. Now execute `sudo update-grub`. You can check the current kernel command line with `cat /proc/cmdline` if you run into trouble.

To change the plymouth theme execute:

```
root@htpc:~# update-alternatives --config default.plymouth
root@htpc:~# update-initramfs -u
```

To search for themes use `apt search plymouth theme` and then install the themes you want with `sudo apt install`.

----------

Plymouth documentation can be found in `/usr/share/doc/plymouth/`, to read it execute `$ zless /usr/share/doc/plymouth/README.Debian`.

## (Optional) Change the console font size

The default console size is rather small which can be inconvenient if your HTPC is connected to a big screen. To change the default console font execute:

```
root@htpc:~# dpkg-reconfigure console-setup
```

Make sure you choose **UTF-8** as the encoding, choose the default in the character set, choose **VGA** as the font for the console, finally choose the `16x28` or `16x32` size. To roll back you changes and set the default values, execute `dpkg-reconfigure console-setup` and choose **Fixed** font and `8x16` size.

## (Optional) Unneeded software cleanup

`ModemManager`, `NetworkManager`, `unattended upgrades`, ...
