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

**RATIONALE** If you use a NAS to store large files used by the HTPC it is better to use a wired Ethernet connection between the HTPC and the NAS rather than WiFi. The HTPC will have a DHCP server on the Ethernet port so the NAS will get an IP address automatically. Also, the HTPC will act as a network router so the NAS can access the Internet for software upgrades and you can connect to the NAS from the WiFi network.

```
 |--------------------|         |------------------------------------------|          |--------------------|
 | Wireless router    |         | HTPC Intel NUC                           |          | Synology NAS       |
 |                    |  WiFi   |                     | DHCP server        |          |                    |
 | WiFi interface     | network | wlp0s20f3           | eno1               | Ethernet | Ethernet interface |
 |   IP 192.168.11.1  |         |   IP  192.168.11.xx |   IP 192.168.12.1  | cable    |   IP 192.168.12.20 |
 | Mask 255.255.255.0 |         | Mask  255.255.255.0 | Mask 255.255.255.0 |----------| Mask 255.255.255.0 |
 |--------------------|         |------------------------------------------|          |--------------------|
```

Here I assumed that you configured your wired and wifi interfaces in your HTPC as described [here](Linux-installation-and-configuration).

**Step 1) Assign a fixed IP to the wired interface**

Edit the file `/etc/systemd/network/20-wired.network`:

```
[Match]
Name=eno1

[Network]
Address=192.168.12.1/24
IPForward=yes
```

Edit the file `/etc/systemd/network/30-wireless.network`:

```
# File /etc/systemd/network/30-wireless.network

[Match]
Name=wlp0s20f3

[Network]
DHCP=ipv4
IPForward=yes
```

Verify that `systemd-resolved` is working:

```
# systemctl enable systemd-resolved
# systemctl start systemd-resolved
```

```
# rm -f /etc/resolv.conf
# ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
```

Reboot and verify:

**CHANGE THIS**

```
$ networkctl
IDX LINK             TYPE               OPERATIONAL SETUP     
  1 lo               loopback           carrier     unmanaged 
  2 eth0             ether              routable    configured
  3 eth1             ether              routable    configured
```

**Step 2) Setup the DHCP server on the wired interface**

```
# apt install dnsmasq
```

```
# systemctl enable dnsmasq
```

Edit the file `/etc/dnsmasq.conf`:

```
# File /etc/dnsmasq.conf
dhcp-authoritative
interface=eno1
dhcp-range=192.168.12.50,192.168.12.150,12h
```

Save the file and reload dnsmasq

```
# systemctl reload dnsmasq
```

Now you can switch on your NAS. The NAS should get its IP address automatically.

```
$ ping xx.xx.xx.xx
WRITE ME
```

**Step 3) Configure the firewall to do IP network address translation**

Edit `/etc/sysctl.conf` and at the end of the file append:

```
net.ipv4.ip_forward=1
```

Apply changes with `sudo sysctl -p`.

Now edit `/etc/rc.local` and append at the end:

```
iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -o ppp0 -j MASQUERADE
iptables -A FORWARD -s 192.168.0.0/16 -o ppp0 -j ACCEPT
iptables -A FORWARD -d 192.168.0.0/16 -m state --state ESTABLISHED,RELATED -i ppp0 -j ACCEPT
```

Now, reboot your HTPC and test if you can access you NAS from the WiFi network and the NAS can connect to the Internet.

-----

[Build a network router and firewall with Fedora 22 and systemd-networkd](https://fedoramagazine.org/build-network-router-firewall-fedora-22-systemd-networkd/)

[Ubuntu Server Guide: DHCP](https://ubuntu.com/server/docs/network-dhcp)

[Ubuntu Server Guide: Firewall](https://ubuntu.com/server/docs/security-firewall)

## Automount files from a network attached storage (NAS)

**TODO Rewrite this section to use systemd automount to mount sshfs filesystems**



-----

[Github proprietary/mnt-mymountpoint.mount](https://gist.github.com/proprietary/96f6f08758fb98da8467880904191f64)

[Systemd automount vs autofs](https://unix.stackexchange.com/questions/374103/systemd-automount-vs-autofs)

[Automatic mounts with systemd](https://blog.tomecek.net/post/automount-with-systemd/)

## Advanced sound configuration

**TODO describe how to use setups with 2 or more sound cards**

**Is it better to use ALSA or Pulseaudio?**
