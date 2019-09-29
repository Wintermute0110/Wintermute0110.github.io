Emulator application and argument setup for Linux using Retroarch and MAME.

Detailed MAME configuration here. Detailed Retroarch configuration here.

A detailed list of supported Retroarch cores is on the [Libretro wiki](http://wiki.libretro.com/index.php?title=Main_Page).

Also the [Libretro super information files](https://github.com/libretro/libretro-super/tree/master/dist/info) on Github.

[Go to AEL index page](/AEL/)

<a name="systems"></a>
### Index of systems ###

<!--
    Include all platforms supported by AEL.
    Alphabetical order as `ls -l "Launchers XML Linux/"`
    Same order as the AEL Asset Library README
-->

| Category | System/Platform | Short name | Release date  |  DAT support  |
| :------: | :-------------: | :--------: | :-----------: | :-----------: |
| <sub>Arcade</sub> | <sub>[MAME](#atari-2600)</sub> | <sub>atari-2600</sub> | <sub>1977</sub> | <sub>No-Intro</sub> |
| <sub>Atari</sub> | <sub>[Atari 2600](#atari-2600)</sub> | <sub>atari-2600</sub> | <sub>1977</sub> | <sub>No-Intro</sub> |
| <sub>Atari</sub> | <sub>[Atari 5200](#atari-5200)</sub> | <sub>atari-5200</sub> | <sub>1982</sub> | <sub>No-Intro</sub> |
| <sub>Atari</sub> | <sub>[Atari 7800](#atari-7800)</sub> | <sub>atari-7800</sub> | <sub>1986</sub> | <sub>No-Intro</sub> |
| <sub>Atari</sub> | <sub>[Atari Jaguar](#atari-jaguar)</sub> | <sub>atari-jaguar</sub> | <sub>1993</sub> | <sub>No-Intro</sub> |
| <sub>Atari</sub> | <sub>[Atari Jaguar CD](#atari-jaguarcd)</sub> | <sub>atari-jaguarcd</sub> | <sub>1993</sub> | <sub>No-Intro</sub> |
| <sub>Atari</sub> | <sub>[Atari Lynx](#atari-lynx)</sub> | <sub>atari-lynx</sub> | <sub>1989</sub> | <sub>No-Intro</sub> |
| <sub>Computers</sub> | <sub>[Amstrad CPC](#com-amstrad-cpc)</sub> | <sub>com-amstrad-cpc</sub> | <sub>xxxx</sub> | <sub>---</sub> |
| <sub>Computers</sub> | <sub>[Atari 8-bit](#com-atari-8bit)</sub> | <sub>com-atari-8bit</sub> | <sub>xxxx</sub> | <sub>---</sub> |
| <sub>Computers</sub> | <sub>[Atari ST](#com-atari-st)</sub> | <sub>com-atari-st</sub> | <sub>xxxx</sub> | <sub>---</sub> |
| <sub>Computers</sub> | <sub>[Commodore 64](#com-c64)</sub> | <sub>com-c64</sub> | <sub>xxx</sub> | <sub>---</sub> |
| <sub>Computers</sub> | <sub>[Commodore Amiga](#com-amiga)</sub> | <sub>com-amiga</sub> | <sub>xxx</sub> | <sub>---</sub> |
| <sub>Computers</sub> | <sub>[Microsoft MSX](#com-msx)</sub> | <sub>com-msx</sub>       | <sub>1983</sub> | <sub>No-Intro</sub> |
| <sub>Computers</sub> | <sub>[Microsoft MSX2](#com-msx2)</sub> | <sub>com-msx2</sub>     | <sub>1985</sub> | <sub>No-Intro</sub> |
| <sub>Computers</sub> | <sub>[Sinclair ZX Spectrum](#com-msx2)</sub> | <sub>com-spectrum</sub> | <sub>xxx</sub> | <sub>No-Intro</sub> |

| <sub>Consoles</sub> | <sub>[3DO Interactive Multiplayer](#con-3do)</sub> | <sub>1993</sub> | <sub>n/a</sub> |
| <sub>Consoles</sub> | <sub>[Amiga CD32](#con-3do)</sub> | <sub>xxxx</sub> | <sub>n/a</sub> |
| <sub>Consoles</sub> | <sub>[Magnavox Odyssey2](#con-odyssey2)</sub> | <sub>1978</sub> | <sub>No-Intro</sub> |
| <sub>Consoles</sub> | <sub>[Colecovision](#con-coleco)</sub> | <sub>1982</sub> | <sub>No-Intro</sub> |
| <sub>Consoles</sub> | <sub>[Philips Videopac+](#con-videopac)</sub> | <sub>1983</sub> | <sub>No-Intro</sub> |
| <sub>Consoles</sub> | <sub>[Bandai WonderSwan](#con-wswan)</sub> | <sub>1999</sub> | <sub>No-Intro</sub> |
| <sub>Consoles</sub> | <sub>[Bandai WonderSwan Color](#con-wswancolor)</sub> | <sub>2000</sub> | <sub>No-Intro</sub> |

| <sub>Games</sub> | <sub>[Cave Story (NX Engine)](#games-nxengine)</sub> | <sub>xxxx</sub> | <sub>No-Intro</sub> |

| <sub>NEC</sub> | <sub>[PC Engine](#nec-pcengine)</sub> | <sub>nec-pce</sub> | <sub>1987</sub> | <sub>No-Intro</sub> |
| <sub>NEC</sub> | <sub>[PC Engine CD-ROM2](#nec-pcenginecd)</sub> | <sub>nec-pcecd</sub> | <sub>1988</sub> | <sub>n/a</sub> |
| <sub>NEC</sub> | <sub>[PC-FX](#nec-pcfx)</sub> | <sub>nec-pcfx</sub> | <sub>1994</sub> | <sub>n/a</sub> |
| <sub>NEC</sub> | <sub>[SuperGrafx](#nec-sg)</sub> | <sub>nec-sgx</sub> | <sub>1989</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[Game Boy](#nintendo-gb)</sub> | <sub>nintendo-gb</sub> | <sub>1989</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[Game Boy Color](#nintendo-gbcolor)</sub> | <sub>nintendo-gbcolor</sub> | <sub>1998</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[Game Boy Advance](#nintendo-gba)</sub> | <sub>nintendo-gba</sub> | <sub>2001</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[Pokemon Mini](#nintendo-pokemini)</sub> | <sub>nintendo-pokemini</sub> | <sub>2001</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[3DS](#nintendo-3ds)</sub> | <sub>nintendo-3ds</sub> | <sub>2004</sub> | <sub>n/a</sub> |
| <sub>Nintendo</sub> | <sub>[DS](#nintendo-ds)</sub> | <sub>nintendo-ds</sub> | <sub>2004</sub> | <sub>n/a</sub> |
| <sub>Nintendo</sub> | <sub>[DSi](#nintendo-dsi)</sub> | <sub>nintendo-dsi</sub> | <sub>2004</sub> | <sub>n/a</sub> |
| <sub>Nintendo</sub> | <sub>[NES](#nintendo-nes)</sub> | <sub>nintendo-nes</sub> | <sub>1983</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[FDS](#nintendo-fds)</sub> | <sub>nintendo-fds</sub> | <sub>1986</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[Satellaview](#nintendo-satellaview)</sub> | <sub>nintendo-satellaview</sub> | <sub>1995</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[SNES](#nintendo-snes)</sub> | <sub>nintendo-snes</sub> | <sub>1990</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[Virtual Boy](#nintendo-vb)</sub> | <sub>nintendo-vb</sub> | <sub>1995</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[Nintendo 64](#nintendo-n64)</sub> | <sub>nintendo-n64</sub> | <sub>1996</sub> | <sub>No-Intro</sub> |
| <sub>Nintendo</sub> | <sub>[Nintendo 64 DD](#nintendo-n64dd)</sub> | <sub>nintendo-n64dd</sub> | <sub>1996</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[SG-1000](#sega-sg1000)</sub> | <sub>sega-sg1000</sub> | <sub>1983</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[Master System](#sega-sms)</sub> | <sub>sega-sms</sub> | <sub>1985</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[Genesis](#sega-genesis)</sub> | <sub>sega-genesis</sub> | <sub>1988</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[Game Gear](#sega-gg)</sub> | <sub>sega-gamegear</sub> | <sub>1990</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[Mega CD](#sega-megacd)</sub> | <sub>sega-megacd</sub> | <sub>1991</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[PICO](#sega-pico)</sub> | <sub>sega-pico</sub> | <sub>1993</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[32X](#sega-32x)</sub> | <sub>sega-32x</sub> | <sub>1994</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[Saturn](#sega-saturn)</sub> | <sub>sega-saturn</sub> | <sub>1994</sub> | <sub>No-Intro</sub> |
| <sub>SEGA</sub> | <sub>[Dreamcast](#sega-dc)</sub> | <sub>sega-dreamcast</sub> | <sub>1998</sub> | <sub>No-Intro</sub> |
| <sub>SNK</sub> | <sub>[Neo Geo Pocket](#snk-ngp)</sub> | <sub>snk-ngp</sub> | <sub>1998</sub> | <sub>n/a</sub> |
| <sub>SNK</sub> | <sub>[Neo Geo Pocket Color](#snk-ngpc)</sub> | <sub>snk-ngpc</sub> | <sub>1999</sub> | <sub>n/a</sub> |
| <sub>SONY</sub> | <sub>[SONY Playstation](#sony-psx)</sub> | <sub>sony-psx</sub> | <sub>1994</sub> | <sub>No-Intro</sub> |
| <sub>SONY</sub> | <sub>[SONY PSP](#sony-psp)</sub> | <sub>sone-psp</sub> | <sub>2004</sub> | <sub>No-Intro</sub> |
