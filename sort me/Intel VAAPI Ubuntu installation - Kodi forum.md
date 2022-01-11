# Intel VAAPI howto with Leia v18 nightly based on Ubuntu 18.04 server

[link](https://forum.kodi.tv/showthread.php?tid=231955&pid=3079766#pid3079766)

Steps I followed on Ubuntu server 20.04 LTS based on the guide:

```
$ sudo apt-get update
$ sudo apt-get install software-properties-common xorg xserver-xorg-legacy alsa-utils mesa-utils git-core librtmp1 libmad0 lm-sensors libmpeg2-4 avahi-daemon libva2 vainfo i965-va-driver linux-firmware dbus-x11 udisks2 openbox pastebinit udisks2 xserver-xorg-video-intel
$ sudo apt-get dist-upgrade
$ sudo dpkg-reconfigure xserver-xorg-legacy
```

Now edit /etc/X11/Xwrapper.config and add the following into a new line at the end of the file:
```
needs_root_rights=yes
```

sudo mkdir -p /etc/X11/xorg.conf.d
cd /etc/X11/xorg.conf.d/
sudo ln -s /usr/share/doc/xserver-xorg-video-intel/xorg.conf 10-intel.conf

sudo adduser kodi (ony when not created during setup)
sudo usermod -a -G cdrom,audio,video,plugdev,users,dialout,dip,input,render kodi

create the file /etc/polkit-1/localauthority/50-local.d/custom-actions.pkla and add:
```
[Actions for kodi user]
Identity=unix-user:kodi
Action=org.freedesktop.login1.*;org.freedesktop.udisks2.*
ResultAny=yes
ResultInactive=yes
ResultActive=yes

[Untrusted Upgrade]
Identity=unix-user:kodi
Action=org.debian.apt.upgrade-packages;org.debian.apt.update-cache
ResultAny=yes
ResultInactive=yes
ResultActive=yes
```

Create the following file and put the listing into it: /etc/systemd/system/kodi.service
```
[Unit]
Description = kodi-standalone using xinit
Requires = dbus.service
After = systemd-user-sessions.service sound.target network-online.target

[Service]
User = kodi
Group = kodi
Type = simple
PAMName=login
ExecStart = /usr/bin/xinit /usr/bin/dbus-launch --exit-with-session /usr/bin/openbox-session -- :0 -nolisten tcp vt7
Restart = on-abort
LimitNICE=-1:-1

[Install]
WantedBy = multi-user.target
```

sudo rm display-manager.service (already exists so replace)
sudo ln -s /etc/systemd/system/kodi.service /etc/systemd/system/display-manager.service

sudo apt-add-repository ppa:team-xbmc/ppa
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install kodi

sudo mkdir -p /home/kodi/.config/openbox
sudo touch /home/kodi/.config/openbox/autostart
sudo chown kodi:kodi /home/kodi/.config -R

now we write the following into the created /home/kodi/.config/openbox/autostart file
```
OUTPUT=`xrandr -display :0 -q | sed '/ connected/!d;s/ .*//;q'`
xrandr -display :0 --output $OUTPUT --set "Broadcast RGB" "Full"
xsetroot #000000
xset s off -dpms
/usr/bin/kodi --standalone
while [ $? -ne 0 ]; do
    /usr/bin/kodi --standalone
done
openbox --exit
```

**BONUS: Splash screen**

sudo vi /etc/default/grub end edit the following lines to include quiet and splash
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
GRUB_CMDLINE_LINUX="quiet splash"
sudo update-grub

from: https://github.com/solbero/plymouth-them...mated-logo

sudo apt install fakeroot plymouth-label fonts-ubuntu
git clone https://github.com/solbero/plymouth-them...d-logo.git
cd plymouth-theme-kodi-animated-logo
sudo ./build.sh
sudo dpkg -i plymouth-theme-kodi-animated-logo.deb 

------------------------------------------------------------------------------------------

[link](https://forum.kodi.tv/showthread.php?tid=231955&pid=3079854#pid3079854)

Yes, change the kodi service to include in the Service section:
```
LimitNICE=-1:-1
```

That should do it. Kodi uses this to give the Audio thread more priority (among others, which get less priority). Negative value "more oomph".
