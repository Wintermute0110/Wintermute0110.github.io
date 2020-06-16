---
layout: post
title: "Random notes"
author: Wintermute0110
---

- TOC
{:toc}

# Post installation notes for Ubuntu Focal Fossa 20.04

I think `apt` installs the recommended/suggested packaged. When I reboot the HTPC after the basic configuration gnome has been installed and shows up! Recommendations are standard installed with apt. This can be prevented using the switch `--no-install-recommends`

Actually it could not be a bad thing to have gnome installed. Graphical editor, terminal, etc., are ready to use.

**systemd** places its configuration files in `/etc/systemd/system/` and `/lib/systemd/system/`.

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
# iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
# iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
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
```

## Autofs

**TODO**

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
