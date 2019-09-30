Configuration and notes for console emulators.

[Go to Setup index page](./Setup-Index)

[Go to AEL index page](/AEL/)

**Table of contents**

- TOC
{:toc}

<!--
    Same order as in Setup-Index.md
-->

## Atari 2600

No-Intro ROMs for Atari 2600 have `a26` extension.

### Retroarch Stella core (Linux, Windows, Android)

[Stella core INFO file](https://github.com/libretro/libretro-super/blob/master/dist/info/stella_libretro.info).
Stella supports the following ROM extensions: `a26`, `bin`. Stella can load `zip` files.
Stella does not require any BIOS.

[Linux Atari 2600 Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Atari%020-%020Atari%0202600%020-%020Retroarch.xml)

### MAME (Linux, Windows)

| <sub>MAME machine</sub> | <sub>Comments</sub> | <sub>Clone of</sub> | <sub>Media types</sub> |
|-------------------------|---------------------|---------------------|------------------------|
| <sub>a2600</sub>        | <sub>Atari 2600 (NTSC)</sub> |                  | <sub>cartridge</sub> |
| <sub>a2600p</sub>       | <sub>Atari 2600 (NTSC)</sub> | <sub>a2600</sub> | <sub>cartridge</sub> |

## Atari 5200 ###

No-Intro ROMs for Atari 5200 have `a52` extension.

### Retroarch Atari800 core (Linux, Windows, Android)

[Atari800 core INFO file](https://github.com/libretro/libretro-super/blob/master/dist/info/atari800_libretro.info).
Atari800 supports the following ROM extentions: `xfd`, `atr`, `atx`, `cdm`, `cas`, `bin`, `a52`, `xex`.
Atari800 can load `zip` files.

| <sub>BIOS</sub> | <sub>Mandatory</sub> | <sub>MD5</sub> | <sub>Info</sub> |
|-----------------|----------------------|----------------|-----------------|
| <sub>5200.rom</sub> | <sub>yes</sub> | <sub>281f20ea4320404ec820fb7ec0693b38</sub> | <sub>Found on MAME machine `a5200.zip` and No-Intro ROM `[BIOS] Atari 5200 (USA).a52`<sub> |

[Linux Atari 5200 Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Atari%020-%020Atari%0205200%020-%020Retroarch.xml)

### MAME (Linux, Windows)

| <sub>MAME machine</sub> | <sub>Comments</sub> | <sub>Clone of</sub> | <sub>Media types</sub> |
|-------------------------|---------------------|---------------------|------------------------|
| <sub>a5200</sub>        | <sub>Atari 5200</sub> | | <sub>cartridge</sub> |

-------------------------------------------------

### Atari 7800 ###

No-Intro ROMs for Atari 7800 have `a78` extension.

#### Retroarch ProSystem core (Linux, Windows, Android)

[ProSystem core INFO file](https://github.com/libretro/libretro-super/blob/master/dist/info/prosystem_libretro.info).
ProSystem supports the following ROM extensions: `a78`, `bin`. ProSystem can load `zip` files.

| <sub>BIOS</sub> | <sub>Mandatory</sub> | <sub>MD5</sub> | <sub>Info</sub> |
|-----------------|----------------------|----------------|-----------------|
| <sub>7800 BIOS (U).rom</sub> | <sub>yes</sub> | <sub>0763f1ffb006ddbe32e52d497ee848ae</sub> | <sub>Found on MAME machine `a7800` as `7800.u7` and No-Intro ROM `[BIOS] Atari 7800 (USA).a78`<sub> |
| <sub>7800 BIOS (E).rom</sub> | <sub>yes</sub> | <sub>397bb566584be7b9764e7a68974c4263</sub> | <sub>Found on MAME machine `a7800p` as `7800pal.rom` and No-Intro ROM `[BIOS] Atari 7800 (Europe).a78`<sub> |

[Linux Atari 7800 Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/Launchers%20XML%20Linux/Atari%207800%20-%20Retroarch%20(Linux).xml)

#### MAME (Linux, Windows)

| <sub>MAME machine</sub> | <sub>Comments</sub> | <sub>Clone of</sub> | <sub>Media types</sub> |
|-------------------------|---------------------|---------------------|------------------------|
| <sub>a7800</sub>        | <sub>Atari 7800 (NTSC)</sub> |                  | <sub>cartridge</sub> |
| <sub>a7800p</sub>       | <sub>Atari 7800 (PAL)</sub>  | <sub>a7800</sub> | <sub>cartridge</sub> |

<a name="atari-lynx"></a>
***
### Atari Lynx ###

No-Intro ROMs for Atari Lynx have `xxx` extension.

#### Retroarch Beetle Lynx core (Linux, Windows, Android)

[Beetle Lynx core INFO file](https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_lynx_libretro.info)

Can Beetle Lynx load ZIP files?

Beetle Lynx core requires BIOS `lynxboot.img` (MD5 fcd403db69f54290b51035d82f835e7b).
This BIOS can be found on MAME machine `lynx.zip` as `lynxa.bin`.

[Linux Atari Lynx Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/Launchers%20XML%20Linux/Atari%20Lynx%20-%20Retroarch%20(Linux).xml)

#### Retroarch Handy core (Linux, Windows, Android)

[Handy core INFO file](https://github.com/libretro/libretro-super/blob/master/dist/info/handy_libretro.info)
BIOS is optional in Handy core.

<a name="atari-jaguar"></a>
***
### Atari Jaguar ###

#### Retroarch Virtual Jaguar core (Linux, Windows, Android)

[Virtual Jaguar core INFO file](https://github.com/libretro/libretro-super/blob/master/dist/info/virtualjaguar_libretro.info)
Can Virtual Jaguar core loads ZIP files?

[Linux Atari Jaguar Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/Launchers%20XML%20Linux/Atari%20Jaguar%20-%20Retroarch%20(Linux).xml)

<a name="con-odyssey2"></a>
***
### Magnavox Odyssey2 ###

#### Retroarch O2EM core (Linux, Windows, Android)

[O2EM core INFO file](https://github.com/libretro/libretro-super/blob/master/dist/info/o2em_libretro.info)

O2EM core requires BIOS `o2rom.bin` (MD5 562d5ebf9e030a40d6fabfc2f33139fd). 
This BIOS can be found on MAME machine `odyssey2.zip` as `o2bios.rom`.

[Linux Magnavox Odyssey2 Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/Launchers%20XML%20Linux/Magnavox%20Odyssey%202%20-%20Retroarch%20(Linux).xml)

<a name="con-coleco"></a>
***
### Colecovision ###

#### Retroarch blueMSX core (Linux, Windows, Android)

[blueMSX core INFO file](https://github.com/libretro/libretro-super/blob/master/dist/info/bluemsx_libretro.info)

 * blueMSX cannot load Colecovision ROMs at the moment (March 2017). Apparently something is hardcoded in the blueMSX 
   core to always make it boot the core into MSX mode rather than Colecovision.

[Colecovision Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Consoles - Colecovision - Retroarch.xml)

#### MAME

[Colecovision MAME XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Consoles - Colecovision - MAME.xml)

<a name="con-videopac"></a>
***
### Philips Videopac+ ###

#### Retroarch

 * [O2EM core INFO file].
 * O2EM core requires BIOS `c52.bin` (MD5 f1071cdb0b6b10dde94d3bc8a6146387).
   This BIOS can be found on MAME machine `videopac`.
 * O2EM core requiresBIOS `g7400.bin` (MD5 `c500ff71236068e0dc0d0603d265ae76`).
   This BIOS can be found on MAME machine `g7400`.
 * O2EM core requiresBIOS `jopac.bin` (MD5 xxxxx).
   This BIOS can be found on MAME machine `jopac` (Jopac JO7400).
 * There is a discrepancy in BIOS file names in [O2EM core INFO file]!

[O2EM core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/o2em_libretro.info

[Philips Videopac+ Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Consoles - Philips Videopac+ - Retroarch.xml)


<a name="con-3do"></a>
***
### 3DO ###

#### Retroarch

 * [4DO core INFO file].
 * 4DO core requires BIOS `panafz10.bin` (MD5 `51f2f43ae2f3508a14d9f56597e2d3ce`).
   This BIOS can be found on MAME machine `3do`.
 * Important: 4DO core requires ISO files to be loaded and not CUE.

[4DO core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/4do_libretro.info

[3DO Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Consoles - 3DO - Retroarch.xml)


<a name="con-wswan"></a>
***
### Bandai WonderSwan ###

#### Retroarch

 * [Beetle WonderSwan core INFO file].

[Beetle WonderSwan core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_wswan_libretro.info

[Bandai WonderSwan Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Consoles - Bandai WonderSwan - Retroarch.xml)


<a name="con-wswancolor"></a>
***
### Bandai WonderSwan Color ###

#### Retroarch

 * [Beetle WonderSwan core INFO file].

[Beetle WonderSwan core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_wswan_libretro.info

[Bandai WonderSwan Color Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Consoles - Bandai WonderSwan Color - Retroarch.xml)


<a name="nec-pcengine"></a>
***
### NEC PC Engine ###

#### Retroarch

* [Beetle PCE Fast core INFO file]. ROM extensions: `pce`, `cue`, `ccd`, `iso`, `img`, `bin`.
  Beetle PCE Fast core supports loading ZIP files.
* Beetle PCE Fast core requires BIOS `syscard3.pce` (MD5 `ff1a674273fe3540ccef576376407d1d`).

[Beetle PCE Fast core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_pce_fast_libretro.info

[PC Engine Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/NEC PC Engine - Retroarch.xml)


<a name="nec-pcenginecd"></a>
***
### NEC PC Engine CD-ROM2 ###

#### Retroarch

 * [Beetle PCE Fast core INFO file]. ROM extensions: `pce`, `cue`, `ccd`, `iso`, `img`, `bin`.
    Beetle PCE Fast core supports loading ZIP files.
 * Beetle PCE Fast core requires BIOS `syscard3.pce` (MD5 `ff1a674273fe3540ccef576376407d1d`).

[Beetle PCE Fast core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_pce_fast_libretro.info

[PC Engine CD-ROM2 Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/NEC PC Engine CD-ROM2 - Retroarch.xml)


<a name="nec-sg"></a>
***
### NEC SuperGrafx ###

#### Retroarch

 * [Beetle SGX core INFO file]. ROM extensions: `pce`, `sgx`, `cue`, `ccd`. 
   Beetle SGX core supports loading ZIP files.
 * Beetle SGX core requires BIOS `syscard3.pce` (MD5 `ff1a674273fe3540ccef576376407d1d`).

[Beetle SGX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_supergrafx_libretro.info

[SuperGrafx Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/NEC SuperGrafx - Retroarch.xml)


<a name="nec-pcfx"></a>
***
### NEC PC-FX ###

#### Retroarch

 * [Beetle PC-FX core INFO file]. Beetle PC-FX core ROM extensions: `cue`, `ccd`, `toc`.
 * Beetle PC-FX core requires BIOS `pcfx.rom` (MD5 `08e36edbea28a017f79f8d4f7ff9b6d7`).
   This BIOS can be found on MAME machine `pcfx` as `pcfxbios.bin`.

[Beetle PC-FX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_pcfx_libretro.info

[PC-FX Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/NEC PC-FX - Retroarch.xml)


<a name="nintendo-gb"></a>
***
### Nintendo Game Boy ###

#### Retroarch

 * [Gambatte core INFO file]. Gambatte core ROM extensions: `gb`, `gbc`, `dmg`.
 * Gambatte core optional BIOS `gb_bios.bin` (MD5 `32fbbd84168d3482956eb3c5051637f5`).
 * [mGBA core INFO file]. mGBA core ROM extensions: `gb`, `gbc`, `gba`

[Gambatte core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/gambatte_libretro.info
[mGBA core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mgba_libretro.info

[GameBoy Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo GameBoy - Retroarch.xml)


<a name="nintendo-gbcolor"></a>
***
### Nintendo Game Boy Color ###

#### Retroarch

 * [Gambatte core INFO file]. Gambatte core ROM extensions: `gb`, `gbc`, `dmg`.
 * Gambatte core optional BIOS `gbc_bios.bin` (MD5 `dbfce9db9deaa2567f6a84fde55f9680`).
 * [mGBA core INFO file]. mGBA core ROM extensions: `gb`, `gbc`, `gba`.

[Gambatte core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/gambatte_libretro.info
[mGBA core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mgba_libretro.info

[GameBoy Color Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo GameBoy Color - Retroarch.xml)


<a name="nintendo-gba"></a>
***
### Nintendo Game Boy Advance ###

#### Retroarch

 * [VBA-M core INFO file]. VBA-M core ROM extensions: `gba`.
 * [Meteor core INFO file].
 * [mGBA core INFO file]. mGBA core ROM extensions: `gb`, `gbc`, `gba`.
 * mGBA core optional BIOS `gba_bios.bin` (MD5 `a860e8c0b6d573d191e4ec7db1b1e4f6`).
 * [VBA-M core INFO file]. VBA-M core ROM extensions: `gba`.
 * [VBA Next core INFO file]. VBA Next core ROM extensions: `gba`.
 * VBA Next core requires BIOS `gba_bios.bin` (MD5 `a860e8c0b6d573d191e4ec7db1b1e4f6`).

[VBA-M core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/vbam_libretro.info
[Meteor core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/meteor_libretro.info
[mGBA core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mgba_libretro.info
[VBA Next core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/vba_next_libretro.info

[GameBoy Advance Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo GameBoy Advance - Retroarch.xml)


<a name="nintendo-pokemini"></a>
***
### Nintendo Pokemon Mini ###

#### Retroarch

 * [PokeMini core INFO file]. PokeMini core ROM extensions: `min`.
 * PokeMini core requires BIOS `bios.min` (MD5 `1e4fb124a3a886865acb574f388c803d `).

[PokeMini core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/pokemini_libretro.info

[Pokemon Mini Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo Pokemon Mini - Retroarch.xml)


<a name="nintendo-ds"></a>
***
### Nintendo DS ###

#### Retroarch

 * [DeSmuME core INFO file]. DeSmuME core ROM extensions: `nds`, `bin`.
 * [melonDS core INFO file]. melonDS core ROM extensions: `nds`.

[DeSmuME core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/desmume_libretro.info
[melonDS core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/melonds_libretro.info

[Nintendo DS Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo DS - Retroarch.xml)


<a name="nintendo-nes"></a>
***
### Nintendo NES ###

#### Retroarch

 * [FCEUmm core INFO file]. FCEUmm core ROM extensions: `fds`, `nes`, `unif`.

 * [Nestopia core INFO file]. Nestopia core ROM extensions: `nes`, `fds`, `unf`, `unif`.
 
 * [QuickNES core INFO file]. QuickNES core ROM extensions: `nes`.


[FCEUmm core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/fceumm_libretro.info
[Nestopia core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/nestopia_libretro.info
[QuickNES core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/quicknes_libretro.info

[NES Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo NES - Retroarch.xml)


<a name="nintendo-FDS"></a>
***
### Nintendo FDS (Famicom Disk System) ###

#### Retroarch

 * [Nestopia core INFO file]. Nestopia core ROM extensions: `nes`, `fds`, `unf`, `unif`.
 * Nestopia core requires BIOS `disksys.rom` (MD5 `ca30b50f880eb660a320674ed365ef7a `).
   This BIOS is the No-Intro ROM `[BIOS] Nintendo Famicom Disk System (Japan).bin`.

 * [FCEUmm core INFO file]. FCEUmm core ROM extensions: `fds`, `nes`, `unif`.
 * FCEUmm core requires BIOS `disksys.rom` (MD5 `ca30b50f880eb660a320674ed365ef7a `).
   This BIOS is the No-Intro ROM `[BIOS] Nintendo Famicom Disk System (Japan).bin`.

[FCEUmm core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/fceumm_libretro.info
[Nestopia core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/nestopia_libretro.info

[FDS Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo FDS - Retroarch.xml)


<a name="nintendo-satellaview"></a>
***
### Nintendo Satellaview ###

#### Retroarch

Snes9x core is able to run Satellaview ROMs. A BIOS is required.


<a name="nintendo-snes"></a>
***
### Nintendo SNES ###

#### Retroarch

 * [bsnes/higan Balanced core INFO file]. bsnes/higan Balanced core ROM extensions: `sfc`, `smc`, `bml`.
 * bsnes/higan Balanced core has a lot of optional BIOSes.
 * [Beetle bsnes core INFO file]. Beetle bsnes core ROM extensions: `smc`, `fig`, `bs`, `st`, `sfc`.
 * Snex9x ...
 
[bsnes/higan Balanced core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/bsnes_balanced_libretro.info
[Beetle bsnes core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_snes_libretro.info

[SNES Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo SNES - Retroarch.xml)


<a name="nintendo-vb"></a>
***
### Nintendo Virtual Boy ###

#### Retroarch

 * [Beetle VB core INFO file]. Beetle VB core ROM extensions: `vb`, `vboy`, `bin`.

[Beetle VB core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_vb_libretro.info

[SNES Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo SNES - Retroarch.xml)


<a name="nintendo-n64"></a>
***
### Nintendo 64 ###

#### Retroarch

 * [Mupen64Plus OpenGL core INFO file]. Mupen64Plus OpenGL core ROM extensions: `n64`, `v64`, `z64`, `bin`, `u1`, `ndd`.
 * [ParaLLEl N64 core INFO file]. ParaLLEl N64 core ROM extensions: `n64`, `v64`, `z64`, `bin`, `u1`, `ndd`.

[Mupen64Plus OpenGL core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mupen64plus_libretro.info
[ParaLLEl N64 core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/parallel_n64_libretro.info

[Nintendo 64 Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo 64 - Retroarch.xml)


<a name="nintendo-n64dd"></a>
***
### Nintendo 64 DD ###

#### Retroarch

 * [Mupen64Plus OpenGL core INFO file]. Mupen64Plus OpenGL core ROM extensions: `n64`, `v64`, `z64`, `bin`, `u1`, `ndd`
 * [ParaLLEl N64 core INFO file]. ParaLLEl N64 core ROM extensions: `n64`, `v64`, `z64`, `bin`, `u1`, `ndd`.
 * ParaLLEl N64 core optinal BIOS `64DD_IPL.bin` (MD5 `8d3d9f294b6e174bc7b1d2fd1c727530`).

[Mupen64Plus OpenGL core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mupen64plus_libretro.info
[ParaLLEl N64 core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/parallel_n64_libretro.info

[Nintendo 64 DD Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Nintendo 64 DD - Retroarch.xml)


<a name="sega-sg1000"></a>
***
### SEGA SG-1000 ###

#### Retroarch

 * [Genesis Plus GX core INFO file]. ROM extensions: `mdx`, `md`, `smd`, `gen`, `bin`, `cue`, `iso`, `sms`, `gg`, `sg`.
 * [blueMSX core INFO file]. ROM extensions: `rom`, `ri`, `mx1`, `mx2`, `col`, `dsk`, `sg`, `sc`.

[Genesis Plus GX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/genesis_plus_gx_libretro.info
[blueMSX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/bluemsx_libretro.info

[SG-1000 Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega SG-1000 - Retroarch.xml)


<a name="sega-sms"></a>
***
### SEGA Master System ###

#### Retroarch

 * [Genesis Plus GX core INFO file]. ROM extensions: `mdx`, `md`, `smd`, `gen`, `bin`, `cue`, `iso`, `sms`, `gg`, `sg`.
 * [PicoDrive core INFO file]. ROM extensions: `bin`, `gen`, `smd`, `md`, `32x`, `cue`, `iso`, `sms`.

[Genesis Plus GX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/genesis_plus_gx_libretro.info
[PicoDrive core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/picodrive_libretro.info

[Master System Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega SMS - Retroarch.xml)

#### MAME

[Master System MAME XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega SMS - MAME.xml)


<a name="sega-gg"></a>
***
### SEGA Game Gear ###

#### Retroarch

 * [Genesis Plus GX core INFO file]. ROM extensions: `mdx`, `md`, `smd`, `gen`, `bin`, `cue`, `iso`, `sms`, `gg`, `sg`.

[Genesis Plus GX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/genesis_plus_gx_libretro.info

[Game Gear Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega Game Gear - Retroarch.xml)


<a name="sega-genesis"></a>
***
### SEGA Genesis / Mega Drive ###

#### Retroarch

 * [Genesis Plus GX core INFO file]. ROM extensions: `mdx`, `md`, `smd`, `gen`, `bin`, `cue`, `iso`, `sms`, `gg`, `sg`.
 * [PicoDrive core INFO file]. ROM extensions: `bin`, `gen`, `smd`, `md`, `32x`, `cue`, `iso`, `sms`.
 * [BlastEm core INFO file]. ROM extensions: `md`, `bin`, `smd`.

[Genesis Plus GX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/genesis_plus_gx_libretro.info
[PicoDrive core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/picodrive_libretro.info
[BlastEm core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/blastem_libretro.info

[Genesis Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega Genesis - Retroarch.xml)


<a name="sega-megacd"></a>
***
### SEGA MegaCD / Sega CD ###

#### Retroarch

 * [Genesis Plus GX core INFO file]. ROM extensions: `mdx`, `md`, `smd`, `gen`, `bin`, `cue`, `iso`, `sms`, `gg`, `sg`.
 * Genesis Plus GX core requires BIOS `bios_CD_E.bin` and requires BIOS `bios_CD_U.bin` and
   requires BIOS `bios_CD_J.bin`.
 * [PicoDrive core INFO file]. ROM extensions: `bin`, `gen`, `smd`, `md`, `32x`, `cue`, `iso`, `sms`.
 * PicoDrive core requires BIOS `bios_CD_E.bin` (MD5 `e66fa1dc5820d254611fdcdba0662372`) and
   requires BIOS `bios_CD_U.bin` (MD5 `2efd74e3232ff260e371b99f84024f7f`) and
   requires BIOS `bios_CD_J.bin` (MD5 `278a9397d192149e84e820ac621a8edd`).

[Genesis Plus GX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/genesis_plus_gx_libretro.info
[PicoDrive core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/picodrive_libretro.info

[Mega CD Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega Mega CD - Retroarch.xml)


<a name="sega-pico"></a>
***
### SEGA PICO

#### Retroarch

 * [Genesis Plus GX core INFO file]. ROM extensions: `mdx`, `md`, `smd`, `gen`, `bin`, `cue`, `iso`, `sms`, `gg`, `sg`.
 * [PicoDrive core INFO file]. ROM extensions: `bin`, `gen`, `smd`, `md`, `32x`, `cue`, `iso`, `sms`.

[Genesis Plus GX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/genesis_plus_gx_libretro.info
[PicoDrive core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/picodrive_libretro.info

[Sega PICO Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega PICO - Retroarch.xml)


<a name="sega-32x"></a>
***
### SEGA 32X

#### Retroarch

  * [PicoDrive core INFO file]. ROM extensions: `bin`, `gen`, `smd`, `md`, `32x`, `cue`, `iso`, `sms`.

[PicoDrive core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/picodrive_libretro.info

[Sega 32X Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega 32X - Retroarch.xml)


<a name="sega-saturn"></a>
***
### SEGA Saturn

#### Retroarch

 * [Beetle Saturn core INFO file]. ROM extensions: `cue`, `toc`, `m3u`, `ccd`.
 * Beetle Saturn core requires BIOS `sega_101.bin` (MD5 `85ec9ca47d8f6807718151cbcca8b964`) and
   BIOS `mpr-17933.bin` (MD5 `3240872c70984b6cbfda1586cab68dbe`) and
 * [Yabause core INFO file]. ROM extensions: `bin`, `cue`, `iso`.
 * Yabause core optional BIOS `saturn_bios.bin` (MD5 `af5828fdff51384f99b3c4926be27762`).

[Beetle Saturn core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_saturn_libretro.info
[Yabause core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/yabause_libretro.info

[Saturn Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega Saturn - Retroarch.xml)


<a name="sega-dc"></a>
***
### SEGA Dreamcast

#### Retroarch

 * [Reicast core INFO file]. ROM extensions: `cdi`, `gdi`, `chd`, `cue`.
 * Reicast core requires BIOS `dc/dc_boot.bin` (MD5 `e10c53c2f8b90bab96ead2d368858623`) and
   BIOS `dc/dc_flash.bin` (MD5 `0a93f7940c455905bea6e392dfde92a4`) and

[Reicast core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/reicast_libretro.info

[Dreamcast Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sega Dreamcast - Retroarch.xml)


<a name="snk-ngp"></a>
***
### Neo Geo Pocket ###

#### Retroarch

 * [Beetle NeoPop core INFO file]. Beetle NeoPop core ROM extensions: `ngp`, `ngc`.

[Beetle NeoPop core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_ngp_libretro.info

[Neo Geo Pocket Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/SNK Neo Geo Pocket - Retroarch.xml)


<a name="snk-ngpc"></a>
***
### Neo Geo Pocket Color ###

#### Retroarch

 * [Beetle NeoPop core INFO file]. Beetle NeoPop core ROM extensions: `ngp`, `ngc`.

[Beetle NeoPop core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_ngp_libretro.info

[Neo Geo Pocket Color Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/SNK Neo Geo Pocket Color - Retroarch.xml)


<a name="sony-psx"></a>
***
### SONY Playstation ###

#### Retroarch

 *  [Beetle PSX core INFO file]. Beetle PSX core ROM extensions: `cue`, `toc`, `m3u`, `ccd`, `exe`, `pbp`.
 * Beetle PSX core requires BIOS `scph5500.bin` (MD5 `8dd7d5296a650fac7319bce665a6a53c`), 
   BIOS `scph5501.bin` (MD5 `490f666e1afb15b7362b406ed1cea246`) and
   BIOS `scph5502.bin` (MD5 `32736f17079d0b2b7024407c39bd3050`).

[Beetle PSX core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/mednafen_psx_libretro.info

[Sony PlayStation Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sony PlayStation - Retroarch.xml)


<a name="sony-psp"></a>
***
### SONY PSP ###

#### Retroarch

 * [PPSSPP core INFO file]. PPSSPP core ROM extensions: `elf`, `iso`, `cso`, `prx`, `pbp`.
 * PPSSPP core requires PPSSPP requires the asset files, lang folder, and flash0 folder inside 
   the `system\PPSSPP` directory.
  
[PPSSPP core INFO file]: https://github.com/libretro/libretro-super/blob/master/dist/info/ppsspp_libretro.info

[Sony PSP Retroarch XML](https://github.com/Wintermute0110/AEL-asset-library/blob/master/autoconfig-linux-console/Sony PSP - Retroarch.xml)
