---
layout: post
title: "Basic command and procedures"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

This section describes some commands and procedures that you will use most when configuring you XBMC setup using this guide.

## Unprivileged user commands and root commands

Some commands must be run by an unprivileged user. In this case the prompt ends with the `$` character.

```
wintermute@pc:~$ lsblk
```

Other commands must be run with **root** privileges. In this case the prompt ends with a `#` character.

```
root@pc:~# dd bs=4M conv=fdatasync status=progress if=path/to/input.iso of=/dev/sdd
```

You can also use **sudo** to run privileged commands. `# sudo dd bs=4M ...` is equivalent to the previous example (do not type the `#` character which indicates the command must be run by the **root** user).

In Ubuntu the root user does not have a password by default. Sometimes using **sudo** all the time is inconvenient, specially when you need to use many privileged commands in a row. To become the user `root` you can type `$ sudo su`. To exit the **root** session and return to the unprivileged user session type `exit`.

## Basic Linux commands and keystrokes

Tell about the key combination Alt+Crtl+1 to switch from graphical to console mode and similar stuff...

## Installing software and upgrading your system

```
# apt update ...
# apt search ...
# apt install ...
# apt remove ...
```

-----

From time to time upgrade the software in your HTPC. Execute:

```
# apt update
# apt dist-upgrade
# apt autoremove
# apt clean
```

## Terminal emulator in the X server

Use `sakura`, it is a lightweight terminal emulator with few dependencies. With right click you can open the context menu to configure it. I recommend to use a font like **Monospace** o **Noto Mono**.

## Editing files in the text console

Use `nano` in the text-mode console.

In the graphical interface ...

## Managing files in the text console with Midnight Commander

```
apt install mc
```

## Services

Services are programs running in the background that carry out many tasks. For example, the session manager (the graphical program that greets you and prompts for use name and password) is a service. Most Linux distributions nowadays, including Ubuntu and Debian, use `systemd` to run and manage services.

```
# systemctl start display-manager
# systemctl stop display-manager
# systemctl restart display-manager
# systemctl reload display-manager
```

```
# systemctl enable display-manager
# systemctl disable display-manager
```

```
$ systemctl list-units
$ systemctl list-units --all
$ systemctl list-unit-files
```

```
$ systemctl status display-manager
$ systemctl show display-manager
$ systemctl cat display-manager
$ systemctl list-dependencies display-manager
$ systemctl list-dependencies --all display-manager
```

Targets are equivalent to runlevels. The system can be only on one runlevel at a given time.

```
$ systemctl list-unit-files --type=target
$ systemctl get-default
$ sudo systemctl set-default multi-user.target
$ systemctl list-dependencies multi-user.target
```

-----

[Systemd Essentials](https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal)

[Understanding Systemd Units and Unit Files](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files)

[How To Use Journalctl to View and Manipulate Systemd Logs](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)

[systemd.special](https://www.freedesktop.org/software/systemd/man/systemd.special.html) 

[systemd manpages](https://www.freedesktop.org/software/systemd/man/index.html)

## Passwordless SSH login

In this example your desktop computer is named **laptop** and your username in **laptop** is **wintermute**. You want to setup passwordless SSH connections to your HTPC machine named **htpc** with username **kodi**.

**Step 1) Create a passwordless public-private key pair**

```
wintermute@laptop:~$ ssh-keygen -t rsa -f ~/.ssh/wintermute-laptop -N ""
```

This command creates the private key in `wintermute-laptop` and the public key in `wintermute-laptop.pub`. The private key file `~/.ssh/wintermute-laptop` looks like:

```
$ cat ~/.ssh/wintermute-laptop
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAsmU24mTyq564/AuXuzcIr5E8YXkDqJPXSzCcfLX1IqGYGhKn
...
P+7kPvjL3BqZS2UJwoJcMAoVnc0a24F3IuGKTpDLgQr1HDV7vtCJXA==
-----END RSA PRIVATE KEY-----
```

The public key `wintermute-laptop.pub` contains one very long line of text and looks like:

```
ssh-rsa AAAAB...fYa7 wintermute@laptop
```

**Step 2) Add the private key into the default SSH file for private keys**

```
wintermute@laptop:~$ cd ~/.ssh/
wintermute@laptop:~/.ssh$ cat wintermute-laptop >> id_rsa
wintermute@laptop:~/.ssh$ chmod 600 id_rsa
```

**Step 3) Add the public key into the `authorized_keys` file into the remote host**

```
wintermute@laptop:~/.ssh$ ssh kodi@htpc mkdir -p ~/.ssh
wintermute@laptop:~/.ssh$ cat wintermute-laptop.pub | ssh kodi@htpc "cat - >> ~/.ssh/authorized_keys"
```

The first command creates the directory `~/.ssh/` in the remote host **htpc**. You can safely skip this command if the directory already exists.

**Step 4) Test your setup**

You should be able to SSH to your HTPC without being asked for a password.

```
wintermute@laptop:~$ ssh kodi@htpc
Welcome to Ubuntu 14.04 LTS - XBMCbuntu (GNU/Linux 3.13.0-29-generic x86_64)

Last login: Sat Jul  5 01:16:52 2014 from 192.168.11.3
NUC:~$
```

If you get into trouble check that the `authorized_keys` file in the remote host has the correct permissions and ownership. For a user named `kodi` it should be:

```
$ ls -l ~/.ssh/authorized_keys
bla bla bla
```

If permissions and ownership are wrong, changed them with the following commands:

```
$ chown kodi:kodi ~/.ssh/authorized_keys
$ chmod 600 ~/.ssh/authorized_keys
```

**Step 5) Connect to more computers**

You can use your public/private key to connect to more than one computer. Just copy the public key into as many hosts as you want.
