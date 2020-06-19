---
layout: post
title: "Advanced Linux configuration"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

In this section I explain how to setup more complex configurations suchs as configuring audio with multiple sound cards or use your HTPC as a network route to connect the HTPC with a NAS using the wired Ethernet port.

## Use your HTPC as a network router

**TODO** Rewrite this section to use `systemd-networkd`.

**RATIONALE** If you use a NAS to store large files used by the HTPC it is better to use a wired connection between the HTPC and the NAS. The NAS will be acting as a network router to you can connect to the NAS using the wireless network.

```

 |-----------------|    |-----------------|
 | Wireless router |    |                 |
 |                 |    |                 |
 |                 |    |                 |
 |-----------------|    |-----------------|

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

[Build a network router and firewall with Fedora 22 and systemd-networkd](https://fedoramagazine.org/build-network-router-firewall-fedora-22-systemd-networkd/)

## Automount files from a network attached storage (NAS)

**TODO Rewrite this section to use systemd automount to mount sshfs filesystems**

[Github proprietary/mnt-mymountpoint.mount](https://gist.github.com/proprietary/96f6f08758fb98da8467880904191f64)

[Systemd automount vs autofs](https://unix.stackexchange.com/questions/374103/systemd-automount-vs-autofs)

[Automatic mounts with systemd](https://blog.tomecek.net/post/automount-with-systemd/)

## Advanced sound configuration

**TODO describe how to use setups with 2 or more sound cards**

**Is it better to use ALSA or Pulseaudio?**
