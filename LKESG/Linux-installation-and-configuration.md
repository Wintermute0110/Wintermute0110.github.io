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

**Step 1) Download the installation ISO image** 

Use one of the Ubuntu mirrors to download the ISO image of **Ubuntu 20.04 LTS (Focal Fossa) 64-bit Server install image**. The Server install image installs only the minimum set of packages required to run Linux, as oppossed to the Desktop image which installs a lot of clutter software you do not need on an HTPC.

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

One trick is to execute `lsblk` before you insert the USB drive, and then again with the USB drive inserted. The device name is the one that show up. Dismount any partitions of the UBS drive if they are mounted with `umount`.

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

 * By default the server installation creates a small `/boot/efi/` partition and then another big parition to be mounted as root with `ext4` filesystem.

 * As the **server's name** type something like **htpc**.
 
 * Create a regular user, for example with username **kodi**.

 * Install OpenSSH to be able to connect to the HTPC using SSH.

 * Once the installation finished you are asked to remove the USB drive and then the machine is rebooted. After that Ubuntu Linux is installed and you can log into the system using your username/password.

## Configuration of the wireless interface

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

In this case edit the file using `# nano 00-installer-config.yaml`. 

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
# apt install ssh software-properties-common alsa-utils lm-sensors linux-firmware git
# apt install dbus-x11 openbox pastebinit udisks2 avahi-daemon
# apt install xorg xserver-xorg-legacy xserver-xorg-video-intel mesa-utils 
# apt install libva2 i965-va-driver intel-media-va-driver vainfo
# apt install vulkan-tools
# apt install xdg-screensaver
```

`xdg-screensaver` is used by Retroarch to control the screensaver.

`apt` install tons of packages. I think recommended packages are also installed by default.

## Misc configuration

Allow **anybody** to start the X server:

```
# dpkg-reconfigure xserver-xorg-legacy
```

Now edit `/etc/X11/Xwrapper.config` and add the following into a new line at the end of the file:

```
needs_root_rights=yes
```

Give privileges to the **kodi** user you created in the installation:

```
# usermod -a -G cdrom,audio,video,plugdev,users,dialout,dip,input kodi
```

You can check the groups the user kodi belongs with:
```
# groups kodi
kodi : kodi adm ...
```

Edit `/etc/security/limits.conf` and add before the end. Remember kodi is the username, not the application. This will allow your user to get the audio thread a bit more priority.

```
kodi             -       nice            -1
```

At this point you can test the x server (graphical interface). You will need a mouse to use the X server.

```
$ startx /usr/bin/openbox-session
```

The screen will turn black (don't panic) and you will see the mouse pointer in the middle of the screen. With a right click you can open the Openbox context menu and launch a terminal. Use `glxinfo` and `vainfo` to check that the OpenGL acceleration and VA-API are working well.

## Connecting to the HTPC with SSH

In the Linux desktop/laptop edit the file `/etc/hosts` and append at the end.

```
192.168.0.20   htpc
```

Change the IP address to the one you have assigned in your router to the HTPC computer. I recommend to assign a static IP address so it does not change. To learn the MAC address of the WiFi interface use the `ip a` command in the HTPC.

After that, you can connect to your HTPC with `ssh kodi@htpc`.

## Set permissions to shutdown, suspend and mount disks

Create the file `/etc/polkit-1/localauthority/50-local.d/custom-actions.pkla`.

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

NOTE On a default Ubuntu Focal Fossa installation the kodi user is allowed to use `reboot` and `poweroff` and only for logged in users in a console. Kodi, on the other hand, uses **D-bus** and hence the polkit configuration in this section.

## Changing the time zone (Optinal)

By default the UTC is used. Kodi and many emulators require that the time is correctly set to work properly. To set the correct time execute:

```
# dpkg-reconfigure tzdata
```

By default `systemd` automatically sets the time of your HTPC from the network so the only thing you need to do is to configure the correct time zone where you are located.

[archlinux wiki: systemd-timesyncd](https://wiki.archlinux.org/index.php/systemd-timesyncd)

## Install Plymouth (Optional)

Plymouth seems to be already installed but it is not enabled. It doesn't hurt to make sure it is installed:

```
# apt install plymouth plymouth-theme-ubuntu-logo plymouth-themes
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
# update-alternatives --config default.plymouth
# update-initramfs -u
```

To search for themes use `apt search plymouth theme` and then install the themes you want with `sudo apt install`.

---------------

Plymouth documentation can be found in `/usr/share/doc/plymouth/`, to read it execute `zless /usr/share/doc/plymouth/README.Debian`.

## Change the console font size (Optional)

The default console size is rather small which can be inconvenient if your HTPC is connected to a big screen.

Execute:

```
# dpkg-reconfigure console-setup
```

Make sure you choose **UTF-8** as the encoding, choose the default in the character set, choose **VGA** as the font for the console, finally choose the `16x28` or `16x32` size. To roll back you changes, execute `dpkg-reconfigure` again and choose **Fixed** font and `8x16` size.

## Links and references

[Intel VAAPI howto with Leia v18 nightly based on Ubuntu 18.04 server](https://forum.kodi.tv/showthread.php?tid=231955)

[odroid-xu4-setup](https://github.com/yimyom/odroid-xu4-setup)

## Random notes

This are some internal notes. Ignore them!

I think `apt` installs the recommended/suggested packaged. When I reboot the HTPC after the basic configuration gnome has been installed and shows up! Recommendations are standard installed with apt. This can be prevented using the switch `--no-install-recommends`

Actually it could not be a bad thing to have gnome installed.

**systemd** places its configuration files in `/etc/systemd/system/` and `/lib/systemd/system/`

Just after the installation:

```
In /etc/systemd/system/
lrwxrwxrwx 1 root root   32 Jun  6 08:31 display-manager.service -> /lib/systemd/system/gdm3.service
```

```
In /lib/systemd/system/
lrwxrwxrwx 1 root root   11 Oct  7  2019  gdm3.service -> gdm.service
-rw-r--r-- 1 root root 1070 Oct  7  2019  gdm.service
-rw-r--r-- 1 root root  598 Apr  1 17:23  graphical.target
drwxr-xr-x 2 root root 4096 Jun  6 08:13  graphical.target.wants
```

```
# File /lib/systemd/system/gdm.service

[Unit]
Description=GNOME Display Manager

# replaces the getty
Conflicts=getty@tty1.service
After=getty@tty1.service

# replaces plymouth-quit since it quits plymouth on its own
Conflicts=plymouth-quit.service
After=plymouth-quit.service

# Needs all the dependencies of the services it's replacing
# pulled from getty@.service and plymouth-quit.service
# (except for plymouth-quit-wait.service since it waits until
# plymouth is quit, which we do)
After=rc-local.service plymouth-start.service systemd-user-sessions.service

# GDM takes responsibility for stopping plymouth, so if it fails
# for any reason, make sure plymouth still stops
OnFailure=plymouth-quit.service

[Service]
ExecStartPre=/usr/share/gdm/generate-config
ExecStart=/usr/sbin/gdm3
KillMode=mixed
Restart=always
RestartSec=1s
IgnoreSIGPIPE=no
BusName=org.gnome.DisplayManager
StandardOutput=syslog
StandardError=inherit
EnvironmentFile=-/etc/default/locale
ExecReload=/usr/share/gdm/generate-config
ExecReload=/bin/kill -SIGHUP $MAINPID
KeyringMode=shared
ExecStartPre=/usr/lib/gdm3/gdm-wait-for-drm
```

```
# File /lib/systemd/system/graphical.target

[Unit]
Description=Graphical Interface
Documentation=man:systemd.special(7)
Requires=multi-user.target
Wants=display-manager.service
Conflicts=rescue.service rescue.target
After=multi-user.target rescue.service rescue.target display-manager.service
AllowIsolate=yes
```
