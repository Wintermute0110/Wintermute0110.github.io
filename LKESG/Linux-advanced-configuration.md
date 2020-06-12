---
layout: post
title: "Advanced Linux configuration"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

## Use your HTPC as a network router

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
---------- /etc/dnsmasq.conf ----------
# Configuration file for dnsmasq.

interface=eth0
expand-hosts
domain=internal.net

# DHCP configuration
dhcp-range=192.168.12.2,192.168.12.255,255.255.255.0,1h
dhcp-host=10:6f:3f:cb:46:b4,192.168.12.4
------------------------------------------------------------------------------
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

## Automount files from a network attached storage (NAS)

**TODO describe how to use autofs**

## Advanced sound configuration

**TODO describe how to use setups with 2 or more sound cards**

a) XBMCBuntu uses Pulseaudio... yes. If XBMC is started in a OpenBox session then pulseaudio is started also.

In Ghotam XBMCbuntu pulseaudio is not installed by default.

b) Tried to remove pulseaudio... and created a custom .asoundrc with a dmix interface. It seems to work well!!!

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
