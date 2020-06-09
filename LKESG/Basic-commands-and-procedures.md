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

## Normal user, super user, and rebooting the system


## Installing software and upgrading your system


## Upgrading your system

From time to time upgrade the sotware in your HTPC. Execute:

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

Services are programs running in the background that carry out many tasks. For example, the session manager (the graphical
program that greets you and prompts for use name and password and starts either XBMC
or a desktop session like KDE) is a service. It is useful to know how to start, stop,
and reload servicces.

Ubuntu/Debian use `systemd` to run and manage services. To start a service, type as root:

```
# systemctl
```

To stop a service, use the <command>stop {service_name}</command> command. <command>restart {service_name}</command> reloads a service. This is very useful when you change some configuration and want to make those changes effecctive whithout rebooting the system. To list available services in your system type

```
# initctl list
```

```
# systemctl start display-manager
# systemctl stop display-manager
# systemctl restart display-manager
# systemctl status display-manager
```

## Passwordless SSH login

Justify why SSH login is needed and also talk about the dangers!

Never ever allow automatic login from your HTPC to your desktop/laptop computers!

Let's suppose your are operating on the host debian-laptop with username wintermute and want to automatically be able to log into host NUC (which hosts your mediacenter) with user wintermute. Then follow this steps.

 * Create a public-private key pair without any password

   ```
wintermute@laptop:~$ ssh-keygen -t rsa -f ~/.ssh/wintermute-NUC -N ""
   ```

 * Add the private key into the archive default file for private keys

   ```
laptop:~$ cd ~/.ssh/
laptop:~/.ssh$ cat wintermute-NUC >> id_rsa
laptop:~/.ssh$ chmod 600 id_rsa
   ```

 * Add the public key into the `authorized_keys` file into the remote host.
```
laptop:~/.ssh$ ssh wintermute@NUC mkdir -p ~/.ssh
laptop:~/.ssh$ cat wintermute-NUC.pub | ssh wintermute@NUC "cat - >> ~/.ssh/authorized_keys"
```

   The first command creates the directory `~/.ssh/` in the remote host NUC in the unlikely case that it has not been created yet. You can safely avoid this command if the directory already exists.


 * Test your setup. You should be able to SSH to your HTPC without being asked for a password.

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
