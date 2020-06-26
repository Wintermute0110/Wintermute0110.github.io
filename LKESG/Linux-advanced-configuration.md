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

Here I assumed that you configured your wired and wifi interfaces in your HTPC as described [here](./Linux-installation-and-configuration).

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

We will use `dsnmasq` as our DHCP server. First install it:

```
# apt install dnsmasq
```

Edit the file `/etc/dnsmasq.conf`:

```
# File /etc/dnsmasq.conf
# Configuration file for on NUC
interface=eno1

# Never forward plain names (without a dot or domain part)
domain-needed

# Never forward addresses in the non-routed address spaces.
bogus-priv

# DHCP configuration
dhcp-range=192.168.12.50,192.168.12.200,12h

# Permanent IP addresses
dhcp-host=00:11:32:3f:8a:cb,192.168.12.10
dhcp-host=10:6f:3f:cb:46:b4,192.168.12.20
```

Save the file and reload `dnsmasq`:

```
# systemctl reload dnsmasq
# systemctl enable dnsmasq
```

I recommend you assign a fixed IP to your NAS to simplify connection from the wireless network. Now you can power on or reboot your NAS and it should get its IP address automatically. From your HTPC test if the NAS is reachable:

```
$ ping 192.168.12.10
WRITE ME
```

**Step 3) Configure the firewall to do IP network address translation**

In this last step we will enable the HTPC to act as a packet router so your NAS can connect to the internet and the NAS can be connected from devices in the wireless network. Firs edit `/etc/sysctl.conf` and at the end of the file append:

```
net.ipv4.ip_forward=1
```

Save the file and apply changes with `sudo sysctl -p`.

Now it is time to configure the firewall to allow network address translation (NAT), also known as IP masquerade. `/etc/rc.local` does not exist any more in Debian/Ubuntu, so a `systemd` service must be created to run the firewall configuration. Create the file `/etc/my-firewall.sh`:

```
# File /etc/my-firewall.sh

# Flush iptables rules and chains
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Enable NAT with iptables
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

# Always return success.
exit 0
```

Save the file and make it executable with `# chmod 755 /etc/my-firewall.sh`.

Now, create the `systemd` service to the `/etc/my-firewall.sh` script executes at boot time.

```
# File /etc/systemd/system/my-firewall.service
[Unit]
Description=Service to execute iptables firewall rules
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/etc/my-firewall.sh

[Install]
WantedBy=multi-user.target
```

Save the file and reload the `systemd` configuration with `# systemctl daemon-reload`. Enable the service with `systemctl enable my-firewall.service` so it is executed at boot time.

Now, reboot your HTPC and test if you can access you NAS from the WiFi network and the NAS can connect to the Internet.

-----

Alternative firewall configuration. It is here for reference, ignore it.

```
iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -o wlan0 -j MASQUERADE
iptables -A FORWARD -s 192.168.0.0/16 -o wlan0 -j ACCEPT
iptables -A FORWARD -d 192.168.0.0/16 -m state --state ESTABLISHED,RELATED -i wlan0 -j ACCEPT
```

-----

[Build a network router and firewall with Fedora 22 and systemd-networkd](https://fedoramagazine.org/build-network-router-firewall-fedora-22-systemd-networkd/)

[Ubuntu Server Guide: DHCP](https://ubuntu.com/server/docs/network-dhcp)

[Ubuntu Server Guide: Firewall](https://ubuntu.com/server/docs/security-firewall)

## Automount files from a NAS using SSHFS

```
From Archwiki SSHFS#Automounting

Note: Keep in mind that automounting is done through the root user, therefore you cannot use hosts configured in .ssh/config of your normal user.

To let the root user use an SSH key of a normal user, specify its full path in the IdentityFile option.

And most importantly, use each sshfs mount at least once manually while root so the host's signature is added to the /root/.ssh/known_hosts file.
```

In this section we want to mount the home directory of the `kodi` user in your HTCP named `htpc` into a local directory named `/mnt/htpc/`. The user name in the local computer is `wintermute` and the name of the local computer is `laptop`. The server is `htpc` and the client is `laptop`.

Create the directory `/mnt/htpc/` with `# mkdir /mnt/htpc`. **TODO** What permissions this directory should have? According to `man sshfs` the mounpoint must be owned by the user.

The `systemd` units must be named after the mount points in the local computer. For example, if you want to mount into `/mnt/htpc/` then your `systemd` configuration files must start with `mnt-htpc.`.

```
# File /etc/systemd/system/mnt-htpc.automount

# Note that the timeout is disabled by default.

[Unit]
Description=Automount kodi@htpc:/home/kodi/ into /mnt/nuc

[Automount]
Where=/mnt/nuc
TimeoutIdleSec=1min
```

```
# File /etc/systemd/system/mnt-htpc.mount

[Unit]
Description=Mount kodi@htpc:/home/kodi/ into /mnt/nuc

[Mount]
What=kodi@htpc:/home/kodi
Where=/mnt/htpc
Type=fuse.sshfs
Options=uid=1000,gid=1000,allow_other,reconnect,IdentityFile=/root/.ssh/kodi-NUC-rsyncbackup
```

`idmap=user` maps the UID/GID of the remote server user to UID/GID of the mounting client user. However, I think that when using `systemd` to automount the mount user is always `root`. In this case `uid=USER_ID,gid=GROUP_ID` must have the user ID and group ID of the client user.

 * `allow_other`, `uid=N` and `gid=N` are options defined in `man mount.fuse`. 

 * `reconnect` is defined in `man sshfs`.

 * `IdentityFile` is defined in `man ssh_config`. The default is `~/.ssh/id_dsa`, and `~/.ssh/id_rsa`.

**TODO** Use `sshfs` to test that automount works with a normal user. To debug problems use options `--debug` (print debugging information) and `-f` (do not daemonize, stay in foreground).

```
#!/bin/bash

sshfs kodi@htpc:/home/kodi/ /mnt/htpc -o idmap=user -o reconnect
```

-----

[Automatic mounts with systemd](https://blog.tomecek.net/post/automount-with-systemd/)

[Archlinux wiki: SSHFS](https://wiki.archlinux.org/index.php/SSHFS)

[systemd.automount manpage](https://man7.org/linux/man-pages/man5/systemd.automount.5.html)

[systemd.mount manpage](https://man7.org/linux/man-pages/man5/systemd.mount.5.html)

[mount manpage](https://man7.org/linux/man-pages/man8/mount.8.html)

[mount.fuse manpage](https://man7.org/linux/man-pages/man8/mount.fuse.8.html)

[sshfs manpage](https://manpages.debian.org/experimental/sshfs/sshfs.1.en.html)

[ssh_config manpage](https://www.freebsd.org/cgi/man.cgi?ssh_config(5))

## Advanced sound configuration

**TODO Describe how to use setups with 2 or more sound cards**

**TODO Is it better to use ALSA or Pulseaudio?**
