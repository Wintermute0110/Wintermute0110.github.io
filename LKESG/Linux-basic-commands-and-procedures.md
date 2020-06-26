---
layout: post
title: "Basic command and procedures"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

This section describes some very basic commands and procedures that you will use a lot when configuring your HTPC with this guide. If something is not explained in other sections of this guide have first a look here.

The [Raspberry Pi Documentation](https://github.com/raspberrypi/documentation) project has some very informative tutorials specifically for the Pi but many things are also applicable for any Linux distribution. I recommand to have a look to [introduction to the terminal](https://github.com/raspberrypi/documentation/tree/master/usage/terminal) and [Linux commands](https://github.com/raspberrypi/documentation/blob/master/linux/usage/commands.md).

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

## Configuration files

Lines starting with a `#` are comments and can be safely skipped. For example:

```
# File /home/kodi/.xinitrc

# Execute an Openbox window manager session.
# Openbox will execute the contents of /home/kodi/.config/openbox/autostart
exec openbox-session
```

is equivalent to:

```
exec openbox-session
```

In this guide all configuration files start with a line such as `# File ...` that shows where you have to place the configuration file.

## Basic Linux keyboard shortcuts

By default the Linux system in your HTPC will start in text mode because the graphic server is not installed by default. After introducing your username and password you can start typing commands in the text console. By default there are 6 text terminals named from `tty1` to `tty6`. You can switch to a different text console with **Alt + Fx**, where `x` is a number from 1 to 6. Also you can use **Alt + Right_arrow** or **Alt + Left_arrow** to cycle from one text terminal to another. 

When the X server is active you can press **Control + Alt + Fx** to return to the text console. The X server runs in terminal 7 so to go back to the graphic server, cycle over the text consoles until you reach the terminal 7.

## Rebooting and powering off your HTPC

To reboot the system use the command `reboot`. To power off your HTPC use the command `poweroff` or press the power button. By default in Ubuntu Focal Fossa both commands can be run by normal users logged into the system.

## Installing software and upgrading your system

```
# apt update
# apt search keyword1 keyword2 ...
# apt install package_name
# apt remove package_name
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

`lxterminal` is a lightweight terminal emulator with few dependencies. I recommend to use a font like **Monospace** o **Noto Mono**.

## Editing files in the text console

Use `nano` in the text-mode console. Use **Ctrl + X** to exit `nano` and press **y** to save the file.

## Editing files in the graphic server

In the X server use `mousepad`, `pluma`, `featherpad` or `geany`. These terminal emulators have few dependencies as opposed to the terminal emulators of GNOME or KDE. If in doubt I recommend to install `mousepad`.

`mousepad`, `pluma` and `geany` are based on the GTK library and `featherpad` uses Qt.

## Managing files in the text console with Midnight Commander

```
apt install mc
```

## Systemd services

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
$ systemctl cat display-manager.service
$ systemctl show display-manager.service
```

```
$ systemctl status display-manager.service
$ systemctl list-dependencies display-manager.service
$ systemctl list-dependencies --all display-manager.service
```

Targets are equivalent to runlevels. The system can be only on one runlevel at a given time.

```
$ systemctl list-unit-files --type=target
$ systemctl get-default
# systemctl set-default multi-user.target
$ systemctl list-dependencies multi-user.target
```

To boot the system in text mode use the command `# systemctl set-default multi-user.target` and to boot the system in graphical mode use `# systemctl set-default graphical.target`. The `multi-user.target` is installed by default, the `graphical.target` must be configured before you can use it.

`systemd` places its configuration files in `/etc/systemd/system/` and `/lib/systemd/system/`. The first directory can be changed by the user but the latter should never be modified as it has the system defaults installed by packages. The configuration files in the first directory takes precedence over the latter.

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
wintermute@laptop:~$ ssh-keygen -t rsa -f ~/.ssh/wintermute-laptop-rsa -N ""
```

This command creates the private key in `~/.ssh/wintermute-laptop-rsa` and the public key in `~/.ssh/wintermute-laptop-rsa.pub`. The private key file looks like:

```
$ cat ~/.ssh/wintermute-laptop-rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAsmU24mTyq564/AuXuzcIr5E8YXkDqJPXSzCcfLX1IqGYGhKn
...
P+7kPvjL3BqZS2UJwoJcMAoVnc0a24F3IuGKTpDLgQr1HDV7vtCJXA==
-----END RSA PRIVATE KEY-----
```

The public key `wintermute-laptop-rsa.pub` contains one very long line of text and looks like:

```
ssh-rsa AAAAB...fYa7 wintermute@laptop
```

**Step 2) Add the private key into the default SSH file for private keys**

```
wintermute@laptop:~$ cd ~/.ssh/
wintermute@laptop:~/.ssh$ cat wintermute-laptop-rsa >> id_rsa
wintermute@laptop:~/.ssh$ chmod 600 id_rsa
```

**Step 3) Add the public key into the `authorized_keys` file into the remote host**

```
wintermute@laptop:~/.ssh$ ssh kodi@htpc mkdir -p ~/.ssh
wintermute@laptop:~/.ssh$ cat wintermute-laptop-rsa.pub | ssh kodi@htpc "cat - >> ~/.ssh/authorized_keys"
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

## Kernel modules

To show a list of currently loaded modules:

```
$ lsmod
```

To show information about a module:

```
$ modinfo module_name
```

To list the options that are set for a loaded module use `systool`. `systool` is in the `sysfsutils` package.

```
$ systool -v -m module_name
```

[ArchLinux wiki: kernel modules](https://wiki.archlinux.org/index.php/kernel_modules)
