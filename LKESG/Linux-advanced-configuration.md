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

**Technicalities and useful links**

Alternative firewall configuration. It is here for reference, ignore it.

```
iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -o wlan0 -j MASQUERADE
iptables -A FORWARD -s 192.168.0.0/16 -o wlan0 -j ACCEPT
iptables -A FORWARD -d 192.168.0.0/16 -m state --state ESTABLISHED,RELATED -i wlan0 -j ACCEPT
```

[Build a network router and firewall with Fedora 22 and systemd-networkd](https://fedoramagazine.org/build-network-router-firewall-fedora-22-systemd-networkd/)

[Ubuntu Server Guide: DHCP](https://ubuntu.com/server/docs/network-dhcp)

[Ubuntu Server Guide: Firewall](https://ubuntu.com/server/docs/security-firewall)

## Network mount using SSHFS

In this section we want to mount on-demand the home directory of the `kodi` user in your HTCP named `htpc` into a local directory named `/mnt/htpc/`. The user name in the local computer is `wintermute` and the name of the local computer is `laptop`. The server is `htpc` and the client is `laptop`.

### Mount as a regular user

Create a mountpoint directory in the client machine, for example `/home/wintermute/remotes/myhtpc`.

To mount the remote filesystem use:

```
$ sshfs kodi@htpc:/home/kodi /home/wintermute/remotes/myhtpc
```

To umount the remote filesystem use:

```
$ COMPLETE ME
```

If you run intro trouble use the option `-d` to enable debug output and run sshfs in the foreground (option `-d` implies `-f`):

```
$ sshfs kodi@htpc:/home/kodi /home/wintermute/remotes/myhtpc -d
```

`sshfs` will ask for a password everytime you mount the remote filesystem. You can [configure SSH for passwordless login](./Linux-basic-commands-and-procedures#passwordless-ssh-login) so you will not need to type the password everytime. Note that setting up SSH passwordless login is mandatory for on-demand mounting.

### Automount using systemd

**Step 1) Configure passwordless SSH login**

First [configure SSH for passwordless login](./Linux-basic-commands-and-procedures#passwordless-ssh-login) so the user `wintermute` can connect to the HTPC as user `kodi`. Skip this step if you already did so.

**Step 2) Connect to the HTPC as root user**

Connect to your HTPC `kodi` user as the client machine root user:

```
# ssh kodi@htpc
```

You will be asked for the `kodi` password and this is OK. SSH asks if you want to add the host fingerprint to the authorized keys file, answer `yes`. The purpose of this step is for the HTPC fingerprint to be added to the root authorized hosts file `/root/.ssh/authorized_keys`. If you connect a second time you will be prompted for the `kodi` user password only.

**Step 3) Configure systemd for automounting**

Create the directory `/mnt/htpc/` with `# mkdir /mnt/htpc`.

Now create the following `systemd` configuration files. The `systemd` units must be named after the mount points in the local computer. For example, if you want to mount into `/mnt/htpc/` then your `systemd` then configuration files must be named `mnt-htpc.automount` and `mnt-htpc.mount`. You need root permissions to create files in `/etc/` so use `$ sudo nano my_file_name` to create the files.

```
# File /etc/systemd/system/mnt-htpc.automount
# Note that the timeout is disabled by default.

[Unit]
Description=Automount kodi@htpc:/home/kodi/ into /mnt/htpc

[Automount]
Where=/mnt/htpc
TimeoutIdleSec=1min

[Install]
WantedBy=multi-user.target
```

```
# File /etc/systemd/system/mnt-htpc.mount

[Unit]
Description=Mount kodi@htpc:/home/kodi/ into /mnt/htpc

[Mount]
What=kodi@htpc:/home/kodi
Where=/mnt/htpc
Type=fuse.sshfs
Options=uid=1000,gid=1000,allow_other,reconnect,IdentityFile=/home/wintermute/.ssh/id_rsa

[Install]
WantedBy=multi-user.target
```

I recommend to create a symbolic link into your home directory to access your HTPC remote filesystem conveniently. If you create the symlink into your home directory `/home/wintermute` everytime you do `ls` you get a delay due to the network. We avoid this creating a `~/remotes` directory.

```
$ cd /home/wintermute
$ mkdir -p remotes
$ ln -s /mnt/htpc /home/wintermute/remotes/htpc
```

**Step 4) Optimization of SSHFS**

The data transfer speed of SSH can be dramatically increased tuning some of the SSH options.

First test that SSH is able to connect to the remote machine with no compression and a faster encryption algorithm:

```
$ ssh -o Ciphers=aes128-ctr -o Compression=no kodi@htpc
```

If everything works edit `/etc/systemd/system/mnt-htpc.mount`:

```
Options=uid=1000,gid=1000,allow_other,reconnect,IdentityFile=/home/wintermute/.ssh/id_rsa,Ciphers=aes128-ctr,Compression=no,ServerAliveInterval=15,ServerAliveCountMax=2
```

-----

**Technicalities and useful links**

systemd automount uses the root user to run `ssh` and `sshfs` processes. In other words, each `sshfs` process has an associated `ssh` process to transmit the data over the network. A regular user cannot unmount the filesystem with `umount`. If the directory `/mnt/htpc` is configured to automount with system, just doing `$ ls -l /mnt` triggers the automount.

From the `systemd.mount` manpage:

> Note that the options `User=` and `Group=` are not useful for mount units. systemd passes two parameters to mount(8); the values of `What=` and `Where=`. When invoked in this way, mount(8) does not read any options from `/etc/fstab`, and must be run as `UID 0`.

From Archwiki SSHFS#Automounting:

> Keep in mind that automounting is done through the root user, therefore you cannot use hosts configured in `~/.ssh/config` of your normal user. To let the root user use an SSH key of a normal user, specify its full path in the IdentityFile option. And most importantly, use each sshfs mount at least once manually while root so the host's signature is added to the /root/.ssh/known_hosts file.

 * Option `idmap=user` maps the UID/GID of the remote server user to UID/GID of the mounting client user. However, when using `systemd` to automount the mount user is always `root`. In this case `uid=USER_ID,gid=GROUP_ID` must have the user ID and group ID of the client user.

 * Options `allow_other`, `uid=N` and `gid=N` are options defined in `man mount.fuse`. 

 * Options `reconnect` is defined in `man sshfs`.

 * Option `IdentityFile` is defined in `man ssh_config`. The default is `~/.ssh/id_dsa`, and `~/.ssh/id_rsa`.

[Automatic mounts with systemd](https://blog.tomecek.net/post/automount-with-systemd/)

[Archlinux wiki: SSHFS](https://wiki.archlinux.org/index.php/SSHFS)

[Jake's blog: NAS Performance: NFS vs. SMB vs. SSHFS](https://blog.ja-ke.tech/2019/08/27/nas-performance-sshfs-nfs-smb.html)

[Odds and Ends: Optimizing SSHFS, moving files into subdirectories, and getting placeholder images](https://ideatrash.net/2016/08/odds-and-ends-optimizing-sshfs-moving.html)

Man pages: [systemd.automount](https://man7.org/linux/man-pages/man5/systemd.automount.5.html) [systemd.mount](https://man7.org/linux/man-pages/man5/systemd.mount.5.html) [mount](https://man7.org/linux/man-pages/man8/mount.8.html) [mount.fuse](https://man7.org/linux/man-pages/man8/mount.fuse.8.html) [ssh](https://manpages.debian.org/unstable/openssh-client/ssh.1.en.html) [sshfs](https://manpages.debian.org/unstable/sshfs/sshfs.1.en.html) [ssh_config](https://manpages.debian.org/unstable/openssh-client/ssh_config.5.en.html)

## Network mount using NFS

**NOTE Work in progress**

To access your HTPC to upload/download files SSHFS could be the most convenient system if you have a Linux desktop. However, if you have a network attached storage (NAS) the network filesystem (NFS) may be better. Windows users probably will need to use SAMBA (Windows network) in their NAS.

### Mount manually

To test if NFS is working:

```
# mount -t nfs 172.16.24.192:/srv/nfs/music /mnt/myshare
```

-----

[serverfault: Mount an NFS share as non root user in cli](https://serverfault.com/questions/825246/mount-an-nfs-share-as-non-root-user-in-cli)

### Automount using systemd

**TODO** Can a regular user, for example `kodi`, acess the files? When the `kodi` user creates a file what is the UID/GID in the server?

Disable and stop the `mnt-myshare.mount` unit, and enable and start `mnt-myshare.automount` to automount the share when the mount path is being accessed. Remember that the `systemd` configuration file names must match the name of the mount point directory.

```
# File /etc/systemd/system/mnt-myshare.automount

[Unit]
Description=Automount myshare

[Automount]
Where=/mnt/myshare
TimeoutIdleSec=1min

[Install]
WantedBy=multi-user.target
```

```
# File /etc/systemd/system/mnt-myshare.mount

[Unit]
Description=Mount NFS share at boot

[Mount]
What=172.16.24.192:/mnt/myshare
Where=/mnt/myshare
Options=noatime
Type=nfs
TimeoutSec=30

[Install]
WantedBy=multi-user.target
```

-----

[Archlinux wiki: NFS](https://wiki.archlinux.org/index.php/NFS)

[HOWTO setup a small server](http://chschneider.eu/linux/server/nfs.shtml)

[Synology: How to access files on Synology NAS within the local network (NFS)](https://www.synology.com/en-us/knowledgebase/DSM/tutorial/File_Sharing/How_to_access_files_on_Synology_NAS_within_the_local_network_NFS)

## Network mount using Samba (Windows network)

**TODO**

Note that like NFS, only the root user can mount SAMBA filesystems. Editing `fstab` options, mounting can be allowed by regular users.

-----

[ask ubuntu: How do I mount Samba share as non-root user](https://askubuntu.com/questions/24348/how-do-i-mount-samba-share-as-non-root-user)

## Setting up a Samba server (Windows network)

**TODO**

This section describes how to configure a Samba server in your HTPC. This is useful if you want to connect to your HTCP from a Windows computer to upload/download files from/to your HTPC.

**Step 1) Installing Samba**

**Step 2) Samba configuration**

**TODO Descibe how to configure samba to share /home/kodi/**

**Step 3) Connecting to your HTPC from a Windows computer**

## Advanced sound configuration

**TODO Describe how to use setups with 2 or more sound cards**

**TODO Is it better to use ALSA or Pulseaudio?**
