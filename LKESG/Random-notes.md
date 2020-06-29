---
layout: post
title: "Random notes"
author: Wintermute0110
---

- TOC
{:toc}

# Post installation notes for Ubuntu Focal Fossa 20.04 after first installation

 * Package A recommends Package B, if the package maintainer judges that most users would not want A without also having the functionality provided by B.

 * Package A suggests Package B if B contains files that are related to (and usually enhance) the functionality of A.

 * `apt` and `apt-get` install the recommended packages by default. This can be prevented using the switch `--no-install-recommends`.

 * By default `apt install xorg` install a basic GNOME environment, including the session manager gdm3 and tons of packages like NetworkManager, ModemManager, pulseaudio, and many others. This is because xorg has a dependency `gnome-terminal | xterm | x-terminal-emulator`.

 * The previous can be prevented with `apt install xorg lxterminal`. `lxterminal` is a very light terminal emulator from the LXDE project (Openbox is the window manager of LXDE) and fulfills the `x-terminal-emulator` dependency. Mesa is installed and all `xserver-xorg-video-*` packages.

**systemd** places its configuration files in `/etc/systemd/system/` and `/lib/systemd/system/`. `/etc/systemd/system/` 

systemd configuration after first installation (GNOME was installed as a dependency of xorg):

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

# Wireless interface configuration with netplan

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
$ ip a
$ ping google.com
```

NOTE Ubuntu server does not install the `wpasupplicant` package. This package needs to be installed over the wired network before the WiFi can be used. To check if the package is installed use `$ dpkg -l | grep wpa`.

-----

[Ubuntu 20.04: Connect to WiFi from command line with Netplan](https://linuxconfig.org/ubuntu-20-04-connect-to-wifi-from-command-line)

# Systemd-networkd netplan-generated configuration files

Netplan creates a custom configuration file for `wpa_supplicant` named `/run/netplan/wpa-wlp0s20f3.conf` and a systemd-service to run `wpa_supplicant` with this config file named `/run/systemd/system/netplan-wpa-wlp0s20f3.service`. In addition, the package-default service `wpa_supplicant.service` is enabled and the other services installed by the package disabled.

```
# File /run/netplan/wpa-wlp0s20f3.conf
ctrl_interface=/run/wpa_supplicant

network={
  ssid="*****"
  key_mgmt=WPA-PSK
  psk="*****"
}
```

```
# File /run/systemd/system/netplan-wpa-wlp0s20f3.service
[Unit]
Description=WPA supplicant for netplan wlp0s20f3
DefaultDependencies=no
Requires=sys-subsystem-net-devices-wlp0s20f3.device
After=sys-subsystem-net-devices-wlp0s20f3.device
Before=network.target
Wants=network.target

[Service]
Type=simple
ExecStart=/sbin/wpa_supplicant -c /run/netplan/wpa-wlp0s20f3.conf -iwlp0s20f3
```

**[*]** Means that the service file is intalled by the `wpasupplicant` package.

```
kodi@htpc:~$ cat sysctl-list-unit-files-grep-wpa.log
[*] wpa_supplicant-nl80211@.service        disabled        enabled
[*] wpa_supplicant-wired@.service          disabled        enabled
[*] wpa_supplicant.service                 enabled         enabled
[*] wpa_supplicant@.service                disabled        enabled
[*] dbus-fi.w1.wpa_supplicant1.service     enabled         enabled  -> /lib/systemd/system/wpa_supplicant.service
    netplan-wpa-wlp0s20f3.service          enabled-runtime enabled
```

```
kodi@htpc:~$ dpkg -L wpasupplicant | grep service
/lib/systemd/system/wpa_supplicant-nl80211@.service
/lib/systemd/system/wpa_supplicant-wired@.service
/lib/systemd/system/wpa_supplicant.service
/lib/systemd/system/wpa_supplicant@.service
/usr/share/dbus-1/system-services/fi.w1.wpa_supplicant1.service
```

Option `-c` means the path to the configuration file. Option `-u` enables the D-Bus control interface. If enabled, interface definitions may be omitted. Option `-s` Logs output to syslog intead of stdout. Option `-O` Override the ctrl_interface parameter for new interfaces. Option `-i` is the interface to listen to. One `wpa_supplicant` process can control several interfaces or each interface can be controlled with multiple `wpa_supplicant` processes.

```
kodi@htpc:~$ cat ps-grep-wpa.log
root         670       1  0 15:40 ?        00:00:00 /sbin/wpa_supplicant -c /run/netplan/wpa-wlp0s20f3.conf -iwlp0s20f3
root         721       1  0 15:40 ?        00:00:00 /sbin/wpa_supplicant -u -s -O /run/wpa_supplicant
kodi        2247    2060  0 22:36 pts/0    00:00:00 grep --color=auto wpa
```

```
kodi@htpc:~$ ls -l /etc/resolv.conf
lrwxrwxrwx 1 root root 39 Apr 23 16:33 /etc/resolv.conf -> ../run/systemd/resolve/stub-resolv.conf
```

# Old configuration files for Ubuntu Bionic Beaver 18.04

In the old NUC configuration Openbox was started by the session manager `lightdm`. Network was managed with `ifupdown`. The NUC uses the 5G Wifi network.

## Sound

ALSA was used and pulseaudio removed from the system. There are three sound cards, two belong to the HDMI ports and there is a USB sound card. Kodi outpus audio on the USB sound card, resto of the applications on the HDMI.

```
# File /home/kodi/.asoundrc

# This configuration works but does not support concurrency!

pcm.!default {
  type hw
  card 0
  device 3
}

ctl.!default {
  type hw
  card 0
  device 3
}
```

```
$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Device [USB PnP Sound Device], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
```

## Network

```
# File /etc/network/interfaces

# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo wlan0 eth0
iface lo inet loopback

# Manual configuration of the interfaces for routing
iface wlan0 inet dhcp
  wpa-ssid **********
  wpa-psk **********

iface eth0 inet static
  address 192.168.12.1
  netmask 255.255.255.0
  network 192.168.12.0
  broadcast 192.168.12.255
  up /home/kodi/bin/router_up
  down /home/kodi/bin/router_down
```

```
#!/bin/bash
# File /home/kodi/bin/router_up -rwxr-xr-x kodi kodi
# Enables packet forwarding and routing.
#
# wlan0 is the interface connected to the Internet. Should be started first.
# eth0 is where the Internet should be shared
#
# See https://wiki.archlinux.org/index.php/Internet_sharing
#     https://wiki.archlinux.org/index.php/Sharing_PPP_Connection
#     https://wiki.archlinux.org/index.php/Dnsmasq

# Enable packet forwarding
echo "1" > /proc/sys/net/ipv4/ip_forward

# Start dnsmasq
/etc/init.d/dnsmasq start

# Flush iptables rules and chains
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Enable NAT with iptables
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
# iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
# iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
```

```
#!/bin/bash
# File /home/kodi/bin/router_down -rwxr-xr-x kodi kodi
# Disables packet forwarding and routing.

# Enable packet forwarding
echo "0" > /proc/sys/net/ipv4/ip_forward

# Stop dnsmasq
/etc/init.d/dnsmasq stop

# Flush iptables rules and chains
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
```

```
# File /etc/dnsmasq.conf
# Configuration file for on NUC
interface=eth0

# eth0 is up before wlan0 and thus the default /etc/resolv.conf is invalid.
# Create a resolv.conf file with the valid DNS server.
# Don't forget to edit /etc/default/dnsmasq or this line will be ignored!
# NOTE 2020: I think this is not needed.
resolv-file=/home/kodi/bin/router_resolv.conf

# Never forward plain names (without a dot or domain part)
domain-needed

# Never forward addresses in the non-routed address spaces.
bogus-priv

# DHCP configuration
dhcp-range=192.168.12.2,192.168.12.255,255.255.255.0,10h

# Permanent IP addresses
# NAS Synology, NAS Linkstation
dhcp-host=00:11:32:3f:8a:cb,192.168.12.10
dhcp-host=10:6f:3f:cb:46:b4,192.168.12.20
```

```
kodi@nuc:~$ ls -l /etc/resolv.conf 
-rw-r--r-- 1 root root 23 Sep 12  2016 /etc/resolv.conf
```

```
kodi@nuc:~$ cat /etc/resolv.conf 
nameserver 192.168.0.1
```

## Automount NFS with autofs

`/etc/autofs.conf` has not been edited and contains the default values.

```
kodi@nuc:~$ cat /etc/auto.master 
# Mount NAS.
/synology      /etc/auto.synology      --timeout=60
```

```
kodi@nuc:~$ cat /etc/auto.synology 
# Mount NAS using NFS in /synology/media/
media  -rw,user,soft,intr,rsize=8192,wsize=8192 192.168.12.10:/volume1/media/
```

```
kodi@nuc:~$ ls -l /synology
drwxrwxrwx 28 root root 4096 Feb 21 22:42 media
```

-----

[Gentoo wiki: AutoFS](https://wiki.gentoo.org/wiki/AutoFS)

## Automount SSHFS with systemd and fstab

```
# /etc/fstab: static file system information.

...

# SSHFS remote filesystems. Systemd will automount on demand.
# See https://wiki.archlinux.org/index.php/SSHFS#Automounting
# To debug filesystem mounting add options: debug,sshfs_debug
kodi@nuc:/home/kodi     /mnt/nuc     fuse.sshfs     uid=1000,gid=1000,noauto,x-systemd.automount,allow_other,reconnect,IdentityFile=/root/.ssh/kodi-NUC-rsyncbackup     0     0
```

Systemd autogenerates 2 files, `mnt-nuc.mount` and `mnt-nuc.automount`

```
$ systemctl cat mnt-nuc.automount 
# /run/systemd/generator/mnt-nuc.automount
# Automatically generated by systemd-fstab-generator

[Unit]
SourcePath=/etc/fstab
Documentation=man:fstab(5) man:systemd-fstab-generator(8)

[Automount]
Where=/mnt/nuc
```

```
$ systemctl cat mnt-nuc.mount
# /run/systemd/generator/mnt-nuc.mount
# Automatically generated by systemd-fstab-generator

[Unit]
Documentation=man:fstab(5) man:systemd-fstab-generator(8)
SourcePath=/etc/fstab

[Mount]
Where=/mnt/nuc
What=kodi@nuc:/home/kodi
Type=fuse.sshfs
Options=uid=1000,gid=1000,noauto,x-systemd.automount,allow_other,reconnect,IdentityFile=/root/.ssh/kodi-NUC-rsyncbackup
```

```
$ systemctl status mnt-nuc.automount mnt-nuc.mount 
● mnt-nuc.automount
     Loaded: loaded (/etc/fstab; generated)
     Active: active (waiting) since Fri 2020-06-26 11:47:28 JST; 1h 32min ago
   Triggers: ● mnt-nuc.mount
      Where: /mnt/nuc
       Docs: man:fstab(5)
             man:systemd-fstab-generator(8)

Warning: some journal files were not opened due to insufficient permissions.
● mnt-nuc.mount - /mnt/nuc
     Loaded: loaded (/etc/fstab; generated)
     Active: inactive (dead)
TriggeredBy: ● mnt-nuc.automount
      Where: /mnt/nuc
       What: kodi@nuc:/home/kodi
       Docs: man:fstab(5)
             man:systemd-fstab-generator(8)
```

## Misc

I do not understand how LightDM starts openbox with the current configuration. Maybe it is configured in the graphical interface of LightDM (the greeter) and not on the configuration file... If I remember correctly the OpenBox sessions was configured in the LightDM graphical interface.

```
# File /home/kodi/.xprofile

# Settings executed BEFORE the window manager.
# Window manager cannot be executed here.

# Disable DPMS and screen saver blanking
xset -dpms
xset s off
```

```
# File /home/kodi/.config/openbox/autostart.sh -rwxr-xr-x kodi kodi
# --- Init script for OpenBox
# --- This script is called by openbox-session on startup

# --- Kodi installed from Team-XBMC PPA
# kodi &
# kodi-standalone &

# --- Kodi compiled locally
/home/kodi/bin-kodi/bin/kodi-standalone
```

```
$ ls -l /etc/systemd/system/display-manager.service
lrwxrwxrwx 1 root root 35 Feb  2  2019 /etc/systemd/system/display-manager.service -> /lib/systemd/system/lightdm.service
```

```
# File /etc/lightdm/lightdm.conf
[SeatDefaults]
xserver-command=/usr/bin/X -bs -nolisten tcp
autologin-user=kodi
autologin-user-timeout=0
user-session=XBMC
greeter-session=lightdm-gtk-greeter
allow-guest=false
default-user=kodi
```

```
$ ls -l /usr/share/xsessions/
-rw-r--r-- 1 root root 1507 Jan 21  2017 LXDE.desktop
-rw-r--r-- 1 root root  198 May 18  2018 openbox.desktop
-rw-r--r-- 1 root root  198 Dec 22  2013 openbox.desktop.dis
```

```
$ pstree
systemd───lightdm─┬─Xorg───3*[{Xorg}]
                  ├─lightdm─┬─openbox─┬─openbox-autosta───sh───kodi-standalone───kodi───kodi-x11───49*[{kodi-x11}]
                  │         │         └─ssh-agent
                  │         └─2*[{lightdm}]
                  └─2*[{lightdm}]
```
