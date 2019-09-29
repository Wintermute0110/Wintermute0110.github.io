The `<Favourites>` virtual launcher allows you to have a carefully curated list of Favourite ROMs.
AEL management of Favourite ROMs is very robust and allows you to keep your Favourites up to date
even if you rename ROMs, update ROM sets (this is important now that MAME is updated *once per
month*) or update your emulator version.

**NOTE** Favourites is only available for *ROMs* and not *standalone launchers*.


## Adding ROMs to Favourites ##

You can add ROMs to Favourites from any *ROM launcher*, *[Browse by ...]* virtual launcher, or
*ROM Collection*.

To add a ROM to Favourites, select that ROM, open the context menu and click on **Add ROM to
AEL Favourites**. A confirmation window will show up and then click **Yes**. If the ROM is
already in Favourites, a confirmation window will ask wheter the current ROM in Favourites
should be replaced or not.


## Understanding Favourite ROMs ##

Favourite ROMs are separated entities from the ROMs in your launchers and are stored in a
separated database. Favourite ROMs also include some metadata from their launcher, like
the launching application, args, etc. If you delete a Favourite ROM from its original launcher
the Favourite ROM will launch, providing the ROM is still in the same path and that the emulator
executable exists. The *parent ROM* is the original ROM you used to create the Favourite from.
The *parent launcher* is the original launcher of the parent ROM.

A Favourite ROM will have the same metadata and artwork/assets as the parent ROM at the time of
creation. However, you can edit both the metadta and artwork of a Favourite ROM and the parent
ROM will not be affected at all. Also, Favourite ROM assets/artwork are stored in a special
directory different from the artwork directories of the parent launcher.

When Favourite ROMs are displayed, a status tag is added at the end of the ROM name,

 * **[OK]** Both the parent launcher and the parent ROM exist.
 
 * **[Unlinked ROM]** The parent launcher of the ROM is OK. Also, the ROM file name stored in the
   database can be found. However, the parent ROM fingerprint cannot be found in the parent 
   launcher ROM database. You reach this situation if you deleted the parent ROM from the parent launcher.
   
   **NOTE** Every time a ROM is added to a launcher, AEL creates a unique ROM fingerprint (romID).
   This ROM fingerprint is different even if you add the same ROM to the same launcher again!
   
 * **[Unlinked Launcher]** The parent launcher of the Favourite ROM cannot be found. Note that
   if the parent launcher cannot be found then the parent ROM does not exist in the database either.
   
 * **[Broken]** ROM filename does not exist. ROM is unplayable. Note that the parent ROM is also
   unplayable.

You can play both *Unlinked ROMs* and *Unlinked Launcher* ROMs if the ROM file exists and you have 
not changed your emulator/launcher executable. However, it is recommended to keep all your favourites
linked (*OK* status) because this allows to copy launcher information, metadata and assets from
the parent. For example: you can change the launching application in the parent launcher because
you installed a new version of your emulator. Later, you can use AEL to update the launching
information of your Favourite ROM with the launcher info from the parent ROM.


## Checking Favourite ROMs ##

To check your Favourite ROMs, open the context menu in any Favourite ROM, click on *Manage
Favourite ROMs*, *Check Favourite ROMs*. This will refresh the Favourite ROM tags.


## Repairing Favourite ROMs (batch) ##

AEL is capable of repairing Unlinked/Broken ROMs. This may be useful, for example, if a new version
of MAME is out, you replace your MAME ROMs, and it happens that a ROM you have in favourites
has been renamed.

Note that the repairing options from the *Manage Favourite ROMs* will process *all your Favourite 
ROMs in a batch. To do so, open the context menu in any Favourite ROM, click on *Manage Favourite 
ROMs*. You have the following options for repair:

 * **Repair Unlinked Launcher/Broken ROMs (by filename)** This will compare each UL/Broken
   Favourite against all the ROMs in all your launchers. A new parent ROM will matched if the
   filenames (including the full path) match.

   This option is ideal if you accidentally deleted a launcher, then recreated it again and
   you did not change the directory where ROMs are stored. If you have several launchers/emulators
   pointing to the same ROMs directory, it may happen that the wrong launcher is matched.
   
 * **Repair Unlinked Launcher/Broken ROMs (by basename)** Same as the above, but only the
   ROM filename (no full path) will be used for matching.
   
   Note that this is more prone to errors because it may happen that you may have a ROM with
   the same name on different platforms.
 
 * **Repair Unlinked ROMs** The parent launcher exists and all the ROMs currently in that
   launcher will be searched by basename.

When you click on any of these options, you will be asked about the way Favourite ROMs must be
repaired when a match is found:

 1. **Relink and update launcher info** Just update the ROM/launcher fingerprint, ROM filename and 
    all the ROM launcher information: launcher app, launcher arguments, etc.
   
    Metadata and asset/artwork of the Favourite ROM won't change.
 
 2. **Relink and update metadata** Same as 1 and also copy metadata from parent ROM to Favourite ROM. 
    Favourite ROM artwork will be kept.
 
 3. **Relink and update artwork** Same as 1 and also copy artwork from parent ROM. Favourite ROM
    metadata remains untouched.
 
 4. **Relink and update everything** Same as 1 and also copy artwork and metadta. Favourite ROM
    will be totally refreshed with the new parent ROM.


## Relinik/Repairing Favourite ROMs (individual ROM) ##

To relink/repair a Favourite ROM, open the Favourite ROM context menu, then click on
*Edit ROM in Favourites*, *Manage Favourite ROM object...*. You have the following relink/repair
options:

 1. **Choose another parent ROM (launcher info only)** First you will choose the new parent
    launcher among all launchers in AEL. Then, you will choose a new parent ROM in that launcher.
    ROM/Launcher fingerprints will be updated and the filename of the parent ROM and the launcher
    information will be refreshed.

    Metadata and artwork of your Favourite ROM will be left unchanged.
    
 2. **Choose another parent ROM (update all)** Same as 1, but Favourite ROM metadata and artwork will 
    be updated with the parent.
 
 3. **Copy launcher info from parent ROM** Only works for linked Favourite ROMs.

 4. **Copy metadata from parent ROM** Only works for linked Favourite ROMs.
 
 5. **Copy assets from parent ROM** Only works for linked Favourite ROMs.
 
 6. **Copy all from parent ROM** Only works for linked Favourite ROMs.
