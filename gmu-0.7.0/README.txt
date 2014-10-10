The Gmu Music Player

Version 0.7.0

Copyright (c) 2006-2010 Johannes Heimansberg
http://wejp.k.vu/projects/gmu/

Gmu is a music player for portable handheld consoles. It comes
with a file browser and a playlist. It supports various play modes.
It also has a cover viewer and can display lyrics (either from a
text file or embedded lyrics from an ID3v2 tag).
Currently, Gmu is available for the GP2X (both F100 and F200 versions),
the GP2X Wiz and the Dingoo A320 (running Dingux).
Gmu is open source software licensed under the GPLv2 and comes without
any warranty. For details see file "COPYING". Gmu has been written by
me, Johannes Heimansberg.

Table of contents
-----------------

1.  Installation
2.  Supported file formats
3.  Controls
3.1 GP2X defaults
3.2 Dingoo defaults
3.3 Custom key mappings
4.  Command line arguments
5.  Config file
5.1 Log bot
6.  Libraries used by Gmu


1. Installation
---------------

Extract the .zip archive on the SD card.

==> GP2X & Wiz release
To run the player start gmu-gp2x.gpu or gmu-wiz.gpu depending on
which device you are using.

On the Wiz the Start button is labled "Menu". Both are the same.

==> Dingoo A320 release
Make sure you use a recent version of Dingux and its root
filesystem (uclibc based). 

To make running Gmu on the Dingoo a little easier, I've included
a shell script called gmu.dge. Simply execute that script from a
file browser or menu application (like dmenu). Previously this
script was called gmu.goo, but since the .dge extension has been
becoming more popular for executables on Dingux, I've chosen to
rename it to gmu.dge.

==> Ben NanoNote release
In the future the Ben NanoNote should come with Gmu preinstalled.
Until then, you cann install Gmu with opkg:

opkg install gmu_0.7.0-1_xburst.ipk

Once Gmu has been installed on the NanoNote, you can run it by
executing 'gmu'.
Make sure you are using a recent kernel and rootfs. Older versions
contain errors that might prevent Gmu from running. Use at least
version 2006-03-26. When using that rootfs version, you also need
to replace the broken libSDL-1.2.so.0 file located in /usr/lib with
a working one.


2. Supported file formats
-------------------------

Audio file formats are supported through decoder plugins, so 
file format support may vary from one platform to another. For
the following file formats there are decoder plugins available:

- Ogg Vorbis
- MP3
- MP2
- Musepack (MPC)
- FLAC
- WavPack
- Several module formats (MOD, IT, STM, S3M, XM, 669, ULT)
- Lots of ADBLIB module formats (A2M, ADL, AMD, BAM, CFF, CMF, DFM, DMO,
                                 DRO, DTM, HSC, HSP, IMF, KSM, LAA, LDS, M,
                                 MAD, MID, MSC, MTK, RAD, RIX, ROL, SA2,
                                 SAT, SCI, SNG, XAD, XAS, XSM)
- M3U (Gmu can load and save M3U playlists)

The decoder plugins use external libraries for decoding the
specific audio files. Those libraries must be available for
the target platform for the decoder plugins to work.


3. Controls
-----------

3.1 GP2X defaults
-----------------

These are the default controls. You can remap all button
by creating your own keymap file. See below for details.
These key mappings assume that the stick click is available,
which is not the case for GP2X-F200 units. When using a
GP2X-F200 run the Gmu setup tool and select the 
gp2x-f200.keymap file or create your own keymap file.
With the gp2x-f200.keymap file the left shoulder button is
used as the modifier key instead of the stick click.

Global:
R            - Skip to next track in playlist/Start playback
L            - Skip to previous track in playlist
CLICK+R      - Seek 10 seconds forward (**)
CLICK+L      - Seek 10 seconds backward (**)
START        - Pause/resume playback
X            - Stop playback
CLICK+START  - Exit player
SELECT       - Toggle file browser/playlist view/track info
VOL+/-       - Increase/lower volume
CLICK+SELECT - Toggle hold (LCD is turned off in hold state)
CLICK+A      - Program info
CLICK+VOL-   - Toggle time elapsed/remaining

File browser:
A            - Play file without adding it to the playlist
B            - Add selected file to the playlist/Change directory
Y            - Add selected directory and all sub directories
CLICK+B      - Insert selected file after selected playlist item
CLICK+X      - Delete selected file (*)

Playlist:
A            - Change play mode (continue, repeat all, 
               repeat track, random, random+repeat)
B            - Play selected track
Y            - Remove selected track
CLICK+Y      - Clear playlist
CLICK+X      - Delete the file of the selected track (*)

Track info viewer:
A            - Show/hide cover artwork
B            - Show/hide text

(*) These actions are disabled by default. If you want 
to be able to delete files from the file browser and/or
playlist browser, you need to uncomment these lines in
your default.keymap file:

#FileBrowserDeleteFile=Mod+X
#PlaylistDeleteFile=Mod+X

Simply remove the '#' to enable these key mappings.

(**) Seeking does not work with all file formats.

3.2 Dingoo defaults
-------------------

The default key mapping for the Dingoo A320 is as follows:

R            - Skip to next track in playlist/Start playback
L            - Skip to previous track in playlist
SELECT+R     - Seek 10 seconds forward (**)
SELECT+L     - Seek 10 seconds backward (**)
X            - Pause/resume playback
SELECT+X     - Stop playback
SELECT+START - Exit player
START        - Toggle file browser/playlist view/track info
LEFT/RIGHT   - Increase/lower volume
SELECT+A     - Program info
SELECT+LEFT  - Toggle time elapsed/remaining

File browser:
A            - Play file without adding it to the playlist
B            - Add selected file to the playlist/Change directory
Y            - Add selected directory and all sub directories
SELECT+B     - Insert selected file after selected playlist item

Playlist:
A            - Change play mode (continue, repeat all, 
               repeat track, random, random+repeat)
B            - Play selected track
Y            - Remove selected track
SELECT+Y     - Clear playlist
SELECT+RIGHT - Enqueue selected item

Track info viewer:
A            - Show/hide cover artwork
B            - Show/hide text


3.3 Ben NanoNote defaults
-------------------------

The default key mapping for the Ben NanoNote is as follows:

M            - Skip to next track in playlist/Start playback
N            - Skip to previous track in playlist
Alt+M        - Seek 10 seconds forward (**)
Alt+N        - Seek 10 seconds backward (**)
P            - Pause/resume playback
Alt+X        - Stop playback
Alt+Enter    - Exit player
Tab          - Toggle file browser/playlist view/track info
Volume Up/Dn - Increase/lower volume
Alt+A        - Program info
T            - Toggle time elapsed/remaining

File browser:
A            - Play file without adding it to the playlist
B            - Add selected file to the playlist/Change directory
Y            - Add selected directory and all sub directories
SELECT+B     - Insert selected file after selected playlist item

Playlist:
R            - Change play mode (continue, repeat all, 
               repeat track, random, random+repeat)
B            - Play selected track
Y            - Remove selected track
Alt+Y        - Clear playlist
Q            - Enqueue selected item

Track info viewer:
A            - Show/hide cover artwork
B            - Show/hide text


3.4 Custom key mappings
-----------------------

You can customize Gmu's key mappings if you don't like
the defaults. To do that open the .keymap file in 
a text editor or copy it to a new file with the .keymap 
extension (such as my.keymap) and open that one in an 
editor. The name of the default .keymap file depends on
which device you are using. E.g. on a Dingoo it is called
dingoo.keymap, while on a Wiz it is called wiz.keymap.
The first thing you need to know is, that Gmu uses one
button as a meta key (modifier). If that key is pressed,
all other buttons have a different meaning. This way you
can have twice as many functions mapped to the keys as 
you could have without a meta key. Ok, actually it is 
only twice as many minus one, as the meta key itself does 
not have a function anymore.
First, you should choose one of the buttons as you meta
key. You can change it by editing the Modifier= line.
By default it is set to

Modifier=STICK_CLICK

on the GP2X and

Modifier=SELECT

on the Dingoo.

If you prefer to use the START button for example,
you would have to change it to

Modifier=START

All other functions can be defined the same way (Function=Button),
with the exception that you can use the previously defined meta key
in the definitions. You can do that by using "Mod+" followed by the
button name.
Lets say you want to map the random function to the Y button when
the modifier (meta) button is pressed you would do it by changing
the PlaylistToggleRandomMode line as follows:

PlaylistToggleRandomMode=Mod+Y

Possible buttons are:
A, B, X, Y, START, SELECT, L, R, VOL+, VOL-, STICK_CLICK,
STICK_LEFT, STICK_RIGHT, STICK_UP and STICK_DOWN.

There are a few alternate keymap example files included.
To use them, either edit your gmu.conf and change the
KeyMap=default.keymap line accordingly or use the Gmu
setup tool to change it.


4. Command line arguments
-------------------------

Gmu now accepts files to be added through the command line.
This can be useful, if you want to run Gmu through a file
manager.
You can add multiple files on the command line and they
will be added to the playlist and playback will be started
automatically.

Example:
./gmu song1.mp3 another_song.ogg cool_tune.s3m list.m3u

This would add the three files and the contents of the 
playlist file "list.m3u" to the playlist in the 
given order and start playback with the first song.

To enable the random playback mode you can use the -r flag.

Example:
./gmu -r list.m3u

You can use the -m flag if you do not want gmu to start the
gp2xmenu on exit. Only use this from a script unless you
want to reboot your gp2x.

With the -s option you can load another theme instead of
the default theme specified in the configuration file.

Example:

./gmu -s theme_name

The Gmu setup tool can be launched by using the -c parameter.
There is a shell script called gmu-setup.gpu included in the
Gmu archive that runs Gmu with the -c parameter.


5. Config file
--------------

Gmu's config file name again depends on the device you are using.
On the GP2X it is called gmu.gp2x.conf, while on the Dingoo it is
called gmu.dingoo.conf. It is a plain text file, with UNIX linebreaks.
You can open it in any real text editor, such as vim, Geany, or 
Notepad++ (Windows only). Do not use Notepad or (which is even worse)
Wordpad.

Please note: Most of the following options can be changed 
through the Gmu setup tool without editing the config file.
In the 0.7.0 series the setup tool is currently not available.

Supported options:

* DefaultFileBrowserPath

You can use this to define the path where the file browser
will start. It is set to "." by default, which is the
current directory. You can set it to any path you like.
Both absolute and relative paths can be used. Make sure
the path exists otherwise gmu will fall back to its current
directory.

* DefaultSkin

With this option you can specify the default skin which Gmu
loads if no -s parameter is used. By default it is set to
default-modern. There are a few other themes included with Gmu
by default, which can be used instead.
Please note that from Gmu 0.7.0_BETA8 onwards, Gmu uses a new
more advanced theme format. Versions 0.7.0_BETA8 and newer are
no longer compatible with the classic skin file format.

* KeyMap

With this option you can specify the key map file Gmu loads
on start up. By default it is set to default.keymap.

* RememberLastPlaylist

This option can be set to "yes" or "no". If set to yes
(which is the default) gmu will save its playlist on exit
and restore it the next time gmu is started. Gmu stores
the playlist in a file called "playlist.m3u" located in
Gmu's directory.
You can disable this behaviour by setting it to "no".

* AutoSelectCurrentPlaylistItem

This option can be set to "yes" or "no". If set to yes
Gmu moves the cursor to the current playlist item each
time a new track begins.

* AllowVolumeControlInHoldState

This option can be set to "yes" or "no". When set to yes
you can adjust the volume even if the player is in the
hold state. The default is "no".

* SecondsUntilBacklightPowerOff

When this option is set to any number greater than zero,
the screen backlight will be turned of after the given
number of seconds of inactivity. Any key press turns it 
back on again. The action of the key you used to turn 
it on again is executed normally. If you just want to 
turn the screen on again, press the stick button.

* EnableCoverArtwork

This option can be set to "yes" or "no". If set to "yes"
Gmu tries to find a cover artwork for the current track
and displays it in the track info view.

* CoverArtworkFilePattern

This option tells Gmu for what files it should search as
a cover image. It is set to "cover.jpg;*.jpg" by default.
Gmu will use the first file that matches the given patterns.
Allowed wildcards are * (which means any number of 
arbitrary characters), the ? (which means exactly one
arbitrary character) and the $ sign (which stands for the 
file name of the current file without its extension). Besides
those you can use any other character. Those characters match
themselves.
Gmu searches for the cover image in the same directory
where the current file is located.
You can use multiple patterns each seperated by a semicolon
(;). The first pattern given has the highest priority.
With "cover.jpg;*.jpg" Gmu would try to find a cover.jpg in 
the directory first and if it is not found it would try any 
other jpg file.   

Examples:

CoverArtworkFilePattern=cover*.jpg matches every filename
that starts with "cover" followed by any number of characters
including 0), followed by ".jpg".

CoverArtworkFilePattern=cover?a.png matches every filename
that starts with "cover" followed by one arbitrary character,
followed by "a.png".

CoverArtworkFilePattern=cover.jpg matches the file called
"cover.jpg" and nothing else.

Assuming the current file is called great_song.ogg with this
pattern:

CoverArtworkFilePattern=$.jpg;$.png;cover.jpg 

Gmu tries to find a file called great_song.jpg first, then 
(if the first one was not found) great_song.png and if even
that was not found, it tries to find cover.jpg. 


If no file is found that matches the given pattern, no cover
will be displayed.
Gmu will resize the image to fit on the screen if neccessary,
but using HUGE images should be avoided as it slows down
the cover loading and can even cause Gmu to run out of memory
if the dimensions of the image are very large (such as 
3000 x 2000 pixels which would need 17 MB in memory even
if the jpg file is much smaller in file size). Recent Gmu
versions no longer run out of memory but refuse to load files
with large dimensions.

* CoverArtworkLarge

This option can be set to "yes" or "no". If set to "yes"
Gmu scales the cover image to fit the screen's width.
You can scroll up and down to see the whole image if its
height is larger than the screen height.
If the option is set to "no" (which is the default) Gmu
scales the image so that its width is at most half the
screen width. The actual width depends on the image 
proportions as Gmu keeps the aspect ratio of the image.

* SmallCoverArtworkAlignment

This option can be set to "left" or "right". If set to
"left" and large cover artwork is disabled, the cover 
artwork will be aligned on the left side and the text
on the right side. When set to "right" it is the other
way round. It is set to "right" by default.

* LoadEmbeddedCoverArtwork

This option can be set to "first", "last" or "no". If set
to "first" Gmu tries to load a cover image embedded in 
the audio file first and if that is not available Gmu 
tries to load an image file matching the given pattern.
If set to "last" Gmu will try to load a cover image from
file first and if none is found it tries to load an image
from the song meta data.
If set to "no" Gmu will not try to load a cover from the
meta data at all.
This option has no effect if EnableCoverArtwork is set to
"no".
LoadEmbeddedCoverArtwork is set to "first" by default.

* LyricsFilePattern

This option tells Gmu for what files it should search as
a lyrics text file. It is set to "$.txt;*.txt" by default.
Gmu will use the first file that matches the given patterns.
Allowed wildcards are * (which means any number of 
arbitrary characters), the ? (which means exactly one
arbitrary character) and the $ sign (which stands for the 
file name of the current file without its extension). Besides
those you can use any other character. Those characters match
themselves.
Gmu searches for the lyrics text file in the same directory
where the current file is located. Gmu auto-detects the
charset used in the text file. The charset can be either UTF-8
or ISO-8859-1.
For examples how to use this option have a look at the examples
in the CoverArtworkFilePattern section.

* FileSystemCharset

This option can be either set to UTF-8 or ISO-8859-1. It
selects the charset of the file system. By default it is
set to UTF-8. If file names appear with weird characters
in Gmu's file browser you might want to try setting it
to ISO-8859-1.

* PlaylistSavePresets

This option is a semicolon separated list of .m3u 
file names. Up to ten file names can be specified here.
When saving a playlist in Gmu you can choose one filename
out of this list as the target file name.

* DefaultPlayMode

This option can be set to "continue", "repeatall", "repeat1",
"random" or "random+repeat".
In continue mode Gmu plays one track after another and stops
after playing the last track in the playlist.
In repeatall mode Gmu repeatedly plays all tracks in the 
playlist.
In repeat1 mode Gmu repeatedly plays the currently selected
track.
In random mode Gmu plays all tracks in the playlist in random
order.
In random+repeat mode Gmu repeatedly plays all tracks in the
playlist in random order.
No matter which play mode has been selected through this option,
you can still select another play mode from within Gmu. When
"RemeberSettings" is set to "yes" Gmu stores the selected play
mode on exit as the new "DefaultPlayMode".

* TimeDisplay

This option can be either set to "elapsed" or "remaining".
When set to "elapsed" Gmu shows the elapsed time of each
track by default, otherwise Gmu shows the remaining time
(if total track time is available). This option is set
to "elapsed" by default. No matter what this option is
set to, you can always toggle the time display from
within Gmu. The default keymapping for this is 
STICK_CLICK + VOL-.

* Scroll

This option can be set to "auto", "always or "never". 
If it is set to "auto" Gmu decides if it is neccessary to
scroll the title or not depending on the title's length
and the available display space. If set to "always" the 
title scrolls no matter if it fits into the display's 
width or not. If it is set to "never" the title never 
scrolls, even if it does not fit into the display's width.

* CPUCLock

This option can be set to either "default" or "reduced".
When set to "reduced" Gmu lowers the cpu frequency to
increase the battery lifetime. You might want to turn
of the display backlight to increase it further. To
do that you can either turn on hold manually or select
a display power off time-out to automatically turn of
the backlight after a given time. Look at the
"SecondsUntilBacklightPowerOff" option for details.
In reduced CPU clock mode some module formats may not
work properly. If you want to play such files and
experience dropouts please use the normal mode (default).
The CPUClock option is not supported on every hardware
supported by Gmu.

* BacklightPowerOnOnTrackChange

This option can be set to either "yes" or "no". When set
to "yes" that display backlight is turned on again each
time a new track starts. If "SecondsUntilBacklightPowerOff"
is set to 0 this option does not do anything.

* FileBrowserFoldersFirst

This option can be set to either "yes" or "no". When set
to "yes" all folder will be shown before the regular files.
When set to "no" all files are shown in alphabetical order.

* RememberSettings

This option can be set to either "yes" or "no". When set
to "yes" Gmu remembers settings such as the time display
setting and the selected play mode.

* VolumeControl

This option can be set to "Software", "Hardware" or
"Software+Hardware". In software volume control mode Gmu
sets its volume solely by scaling the signal in software.
This works on every hardware supported, so it is a safe
way of controlling the volume. Also, very small volume
changes are possible this way. The downside of this method
is, that at lower volumes it can have a audible influence
on the sound quality. Hardware volume control on the other
hand uses the sound devices hardware mixer to control the
volume. The advantage is that there is no quality loss. A
disadvantage of this method is that the volume steps might
be too large. To combine the advantages of both methods,
while trying to avoid the biggest disadvantages of both
methods, there is a third option "Software+Hardware"
available, which uses software volume control only for the
lowest volume steps. For everything above a the minimum
hardware volume level, only hardware volume control is being
used.

* Volume

This option can be set to an positive integer value. The
largest valid value depends on which volume control method
has been selected. For software volume control the maximum
value is 16. For hardware volume control it is 100, while
in Software+Hardware mode the maximum is 116.
Higher values result in higher volumes. You don't need to
set this manually in the config file. Gmu remembers its
volume setting on exit when the "RememberSettings" option
is set to "yes".

* AutoPlayOnProgramStart

This option can be set to either "yes" or "no". When set
to "yes" Gmu starts playback right after the program has 
been started. You don't need to press a button unless the
playlist is empty.

* Shutdown

With the shutdown option it is possible to tell Gmu to
shutdown itself either after a number of minutes or after
the last track in the playlist has been played. To configure
Gmu to shut down after 30 minutes the following line should
be added to the configuration file:
	Shutdown=30
To tell Gmu to shut down when reaching the end of the playlist
the line should be:
	Shutdown=-1
To disable the shut down timer it should be
	Shutdown=0
All of these configurations can be set from within Gmu. With
the default key mapping it would be Meta+DOWN. By pressing
these buttons you can select various power down  timer
configurations (off, 15, 30, 60 minutes, power down after last
track).
After shutting down Gmu can execute a command to power down
the device. This command can be configured through the
ShutdownCommand option.

* ShutdownCommand

With this option you can set the command to be executed when
Gmu shuts itself down (see Shutdown option). By default it is
set to:
	ShutdownCommand=/sbin/poweroff

Powering down the device does not work on the GP2X-F100 and -F200
as these devices have a mechanical power switch.


5.1 LogBot
----------

The logbot allows you to write all played tracks to a log file.
The file format is as follows (CSV). Each line represents one
track and consists of the following things:

Date+Time;"Artist";"Title";"Album";Length

Date+Time looks something like "Sat Dec 26 11:42:23 2009".
Length is stored as "Minutes:Seconds", e.g. 3:42.

The logbot can be configured through some options in the config
file. The following options are available:

* Log.Enable

This option can be either set to "yes" or "no". When set to
"no" the log bot will be disabled. This is the default.
	- Example: Log.Enable = yes

* Log.File

This option should contain the filename of the desired logfile
including its full path. If the path is ommitted, the logfile will
be placed in Gmu's working directory (which is usually the
Gmu installation directory. It defaults to "gmu.log".
	- Example 1: Log.File = /var/log/gmu.log
	- Example 2: Log.File = tracks.log

* Log.MinimumPlaytimeSec

This option can contain a non-negative integer number. It defines
the minimum number of seconds that need to be played for the track
to be written to the logfile. If you want the track to be written
to the logfile even if it is skipped immediately, set this option
to 0. Make sure to also have a look at the following option.
In case a track is shorter than the minimum playtime it will be
written to the log anyway.
	- Example: Log.MinimumPlaytimeSec = 30

* Log.MinimumPlaytimePercent

This option is similar to the previous one, except that you do not
specify an absolute number of seconds, but a percentage. Both, this
option and the previous one, will always be evaluated. So if you
have set Log.MinimumPlaytimeSec = 30 and Log.MinimumPlaytimePercent
= 50 and your current track's length is 4:00, the track needs to be
played for at least two minutes to be written to the logfile. If the
track's length was only 0:50, the track would need to be played for
at least 30 seconds, even though 50 percent of 50 seconds would be
equal to 25 seconds.
	- Example: Log.MinimumPlaytimePercent = 50


6. Libraries used by Gmu
------------------------

See "libs/information" directory for further details.

- SDL >=1.2.9
- SDL_image >=1.2.4
- SDL_gfx >=2.0.13
- tremor >=1.0.0
- libmikmod >=3.1.11
- libmpg123 >=1.8.1
- libmpcdec >=1.2.6
- libFLAC >=1.1.4
- WavPack 4.4.0
- AdPlug >=2.1
- libjpeg and libpng (used by SDL_image)
