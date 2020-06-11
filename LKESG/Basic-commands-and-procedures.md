---
layout: post
title: "Basic command and procedures"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

This section describes some commands and procedures that you will use most when configuring you XBMC setup using this guide.

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

## Terminal emulator

Use `sakura`, it is a lightweight terminal emulator with few dependencies. With right click you can open the context menu to configure it. I recommend to use a font like **Monospace** o **Noto Mono**.

## Editing files

Use `nano` in the text-mode console.

In the graphical interface ...

## Managing files: Midnight Commander

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
wintermute@laptop:~$ ssh-keygen -t rsa -f ~/.ssh/wintermute-NUC -N ""
```

**Step 2) Add the private key into the archive default file for private keys**

```
laptop:~$ cd ~/.ssh/
laptop:~/.ssh$ cat wintermute-NUC >> id_rsa
laptop:~/.ssh$ chmod 600 id_rsa
```

**Step 3) Add the public key into the `authorized_keys` file into the remote host**

```
laptop:~/.ssh$ ssh wintermute@NUC mkdir -p ~/.ssh
laptop:~/.ssh$ cat wintermute-NUC.pub | ssh wintermute@NUC "cat - >> ~/.ssh/authorized_keys"
```

The first command creates the directory `~/.ssh/` in the remote host NUC in the unlikely case that it has not been created yet. You can safely avoid this command if the directory already exists.

**Step 4) Test your setup. You should be able to SSH to your HTPC without being asked for a password**

```
laptop:~$ ssh wintermute@NUC
Welcome to Ubuntu 14.04 LTS - XBMCbuntu (GNU/Linux 3.13.0-29-generic x86_64)

Documentation:  https://help.ubuntu.com/

Last login: Sat Jul  5 01:16:52 2014 from 192.168.11.3
NUC:~$
```

It is very important to set the correct permissions and ownership in the `authorized_keys` file in the remote host. For a user named wintermute they should be:

```
$ ls -l authorized_keys
bla bla bla
```

If wrong, permissions and ownership can be changed with the following commands.

```
$ chown wintermute:wintermute authorized_keys
$ chmod 600 authorized_keys
```
