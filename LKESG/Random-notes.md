---
layout: post
title: "Random notes"
author: Wintermute0110
---

- TOC
{:toc}

[Go to main page](../)

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
