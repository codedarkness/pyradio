# PyRadio

Command line internet radio player.

Ben Dowling - [https://github.com/coderholic](https://github.com/coderholic)

## Table of contents

* [Requirements](#requirements)
* [Installation](#installation)
* [Command line options](#command-line-options)
* [Controls](#controls)
* [PyRadio's Modes](#pyradios-modes)
* [Config file](#config-file)
* [About Playlist files](#about-playlist-files)
* [Search function](#search-function)
* [Line editor](#line-editor)
* [Moving stations around](#moving-stations-around)
* [Specifying stations' encoding](#specifying-stations-encoding)
* [Player detection / selection](#player-detection-selection)
* [Player connection protocol](#player-connection-protocol)
* [Player default volume level](#player-default-volume-level)
* [Displaying Station Info](#displaying-station-info)
* [Copying and pasting - Registers](#copying-and-pasting---registers)
* [PyRadio Themes](#pyradio-themes)
* [Session Locking](#session-locking)
* [Update notification](#update-notification)
* [Cleaning up](#cleaning-up)
* [Debug mode](#debug-mode)
* [Reporting bugs](#reporting-bugs)
* [Acknowlegement](#acknowlegement)

## Requirements

* python 2.7+/3.5+
* MPV, MPlayer or VLC installed and in your path.

## Installation

The best way to install **PyRadio** is via a distribution package, if one exists (e.g. *Arch Linux* and derivatives can install [pyradio-git](https://aur.archlinux.org/packages/pyradio-git/) from AUR).

In any other case, and since **PyRadio** is currently not available via pip, you will have to [build it from source](build.md).

## Command line options

```
$ pyradio -h

usage: pyradio [-h] [-s STATIONS] [-p [PLAY]] [-u USE_PLAYER] [-a] [-ls] [-l]
               [-t THEME] [-scd] [-ocd] [-d]

Curses based Internet radio player

optional arguments:
  -h, --help            show this help message and exit
  -s STATIONS, --stations STATIONS
                        Use specified station CSV file.
  -p [PLAY], --play [PLAY]
                        Start and play.The value is num station or empty for
                        random.
  -u USE_PLAYER, --use-player USE_PLAYER
                        Use specified player. A comma-separated list can be
                        used to specify detection order. Supported players:
                        mpv, mplayer, vlc.
  -a, --add             Add station to list.
  -ls, --list-playlists
                        List of available playlists in config dir ([CONFIG DIR]).
  -l, --list            List of available stations in a playlist.
  -t THEME, --theme THEME
                        Use specified theme.
  -scd, --show-config-dir
                        Print config directory  ([CONFIG DIR]) location and exit.
  -ocd, --open-config-dir
                        Open config directory ([CONFIG DIR]) with default file manager.
  --unlock              Remove sessions' lock file.
  -d, --debug           Start pyradio in debug mode.
```

The following options can also be set in **PyRadio**'s [configuration file](#config-file):

* **-s** - parameter **default_playlist** (default value: **stations**)
* **-p** - parameter **default_station** (default value: **-1**)
* **-u** - parameter **player** (default value: **mpv, mplayer, vlc**)
* **-t** - parameter **theme** (default value: **dark**)

## Controls

```
                  Main window                                      Playlists window                   Themes window
-------------------------------------------------------------------------------------------------------------------------------------
Up/Down/j/k/
PgUp/PgDown       Change station selection                         Change station playlist            Change station theme
g                 Jump to first station                            Jump to first playlist             Jump to first theme
<n>G              Jump to n-th / last station                      Jump to n-th / last playlist       Jump to n-th / last theme
H M L             Jump to the top / middle bottom of the list      [Valid]                            -
P                 Jump to playing station                          Jump to playing playlist           -
Enter/Right/l     Play selected station                            Open selected playlist             Apply selected theme
r                 Select and play a random station                 Re-read playlists from disk        -
Space/Left/h      Stop/start playing selected station              -                                  -
Space             -                                                -                                  Apply theme and make it default
-/+ or ,/.        Change volume                                    [Valid]                            [Valid]
m                 Mute / unmute player                             [Valid]                            [Valid]
v                 Save volume (not applicable for vlc)             [Valid]                            [Valid]
o s R             Open / Save / Reload playlist                    -                                  -
a A               Add / append a new station                       -                                  -
e                 Edit current station                             -                                  -
E                 Change station's encoding                        -                                  -
DEL,x             Delete selected station                          -                                  -
t T               Load theme / Toggle transparency                 [Valid]                            [Valid]
c                 Open Configuration window.                       -                                  -
/ n N             Search, go to next / previous result             [Valid]                            [Valid]
J                 Create a jump tag
<n>^U <n>^D       Move station up / down.                          -                                  -
' \ y             Get into Registers, Extra Commands               y (yank) is not applicable         -
                  and Yank modes, respectively
z                 Toggle "Force http connections"                  -                                  -
?                 Show keys help                                   [Valid]                            [Valid]
#                 Redraw window                                    [Valid]                            [Valid]
Esc/q             Quit                                             -                                  -
Esc/q/Left/h      -                                                Cancel / close window              Cancel / close window
```

The same logic applies to all **PyRadio** windows.

**Note:** All windows - except the *Search window* - support changing the volume and muting / unmuting the player (provided that **PyRadio** is actually connected to a station).

**Note:** When inserting numbers (either to jump to a station or to move a station), the number will be displayed at the right bottom corner of the window, suffixed by a "*G*", i.e. pressing *35* will display *[35G]*.

**Note:** When tagging a station position for a move action (by pressing "**J**"), the position will be displayed at the right bottom corner of the window, suffixed by a "*J*", i.e. pressing "*J*" on position *35* will display *[35J]*.


## PyRadio's Modes

**PyRadio** has the following primary modes:

1. The **Main** mode, which is the one you get when you open the program, showing you a list of stations (a playlist), that you can play and edit; this is why it is also called the **editing mode**. All other modes derive from this one, and it's the mode you have to get to in order to terminate the program.

2. The **Playlist** mode, which you can open by pressing "**o**". Then you can open, create, paste a station, etc.

3. The **Registers** mode. This is identical to the "*Playlist*" mode, but instead of displaying playlists, it displays register. You can enter this mode by pressing "**''**" (two single quotes) and exit from it by pressing "**Esc**" or "**q**". You can also press "**'**" (single quote) to get to the **Playlist** mode and back.

4. The **Register Main** mode, which is identical to the "*Main*" mode, except it displays the content of a **named** register.

A set of **secondary modes** is also available (a secondary mode works within a primary one):

1. The **Extra Commands** mode, which gives you access to extra commands. You can enter this mode by pressing "**\\**" (backslash). Then a backslash is displayed at the bottom right corner of the window.

2. The **Yank (Copy)** mode, which is used to copy stations to **registers**. You can enter this mode by pressing "**y**". Then a "*y*" is displayed at the bottom right corner of the window.

3. The **Open Register** mode, which is used to open a register or get into the *Registers* mode. You can enter this mode by pressing "**'**" (single quote). Then a single quote is displayed at the bottom right corner of the window.

4. The **Paste** mode, which is available in the *Station editor* window only. It is designed to help the user paste a URL (and optionally a station's name). Why you might ask... Well, the *Station editor* normally treats the "*?*" and "*\\*" characters as special characters (actually commands). So, if a URL which contains these characters (more frequently the "*?*" character) is pasted it will be corrupted unless the **Paste** mode is enabled.

The functions available through the *secondary modes* are content dependent, so you can see what command is available by pressing "**?**" while within a secondary mode. Pressing any other key will exit the secondary mode.

## Config file

**PyRadio** upon its execution tries to read its configuration file (i.e. *~/.config/pyradio/config*). If this file is not found, it will be created. If an error occurs while parsing it, an error message will be displayed and **PyRadio** will terminate.

The file contains parameters such as the player to use, the playlist to load etc. It is heavily commented (as you can see [here](pyradio/config)), so that manual editing is really easy. The best practice to manually edit this file is executing **PyRadio** with the **-ocd** command line option, which will open the configuration directory in your file manager, and then edit it using your preferable text editor.

The file can also be altered while **PyRadio** is running by pressing "**c**", which will open the "**Configuration window**". This window presents all **PyRadio** options and provide the way to change them and finally save them by pressing "**s**".

In any case, **PyRadio** will save the file before exiting (or in case Ctrl-C is pressed) if needed (e.g. if a config parameter has been changed during its execution).

If saving the configuration file fails, **PyRadio** will create a back up file and terminate. When restarted, **PyRadio** will try to restore previously used settings from the said back up file.

## About Playlist files

**PyRadio** reads the stations to use from a CSV file, where each line contains two columns, the first being the station name and the second being the stream URL.

Optionally, a third column can be inserted, stating the encoding used by the station (more on this at [Specifying stations' encoding](#specifying-stations-encoding)).

**PyRadio** will by default load the user's stations file (e.g. *~/.config/pyradio/stations.csv*) to read the stations from. If this file is not found, it will be created and populated with a default set of stations.

**Tip:** If you already have a custom *stations.csv* file, but want to update it with **PyRadio**'s default one, you just rename it, run **PyRadio** (so that the default one get created) and then merge the two files.


**Note:** Older versions used to use **~/.pyradio** as default stations file. If this file is found, it will be copied to use's config directory (e.g. **~/.config/pyradio**) and renamed to **stations.csv** or if this file exists, to **pyradio.csv**. In this case, this file will be the default one.

### Specifying a playlist to load (command line)

**PyRadio** will normally load its default playlist file, as described above, upon its execution. A different file can be loaded when the **-s** command line option is used.

The **-s** option will accept:

* a relative or absolute file name.
* the name of a playlist file which is already in its configuration directory.
* the number of a playlist file, as provided by the **-ls** command line option.

Examples:

To load a playlist called "**blues.csv**", one would use the command:

```
pyradio -s /path/to/blues.csv
```

If this file was saved inside **PyRadio**'s configuration directory, one could use the following command:

```
pyradio -s blues
```

To use the playlist number, one would execute the commands:

```
$ pyradio -ls
Playlists found in "/home/user/.config/pyradio"
  1. hip-hop
  2. party
  3. stations
  4. huge
  5. blues
  6. rock
  7. pop
$ pyradio -s 5
```

**Note:** The default playlist to load can also be set in **PyRadio**'s [configuration file](#config-file), parameter **default_playlist** (default value is **stations**).

### Managing playlists (within PyRadio)

Once **PyRadio** has been loaded, one can perform a series of actions on the current playlist and set of playlists saved in its configuration directory.

Currently, the following actions are available:

Pressing "**a**" or "**A**" will enable you to add a new station (either below the currently selected station or at the end of the list), while "**e**" will edit the currently selected station. All of these actions will open the "*Station editor*".

If you just want to change the encoding of the selected station, just press "**E**". If the station is currently playing, playback will be restarted so that the encoding's change takes effect (hopefully correctly displaying the station/song title).

Then, when this is done, you can either save the modified playlist, by pressing "**s**", or reload the playlist from disk, by pressing "**R**". A modified playlist will automatically be saved when **PyRadio** exits (or Ctrl-C is pressed).

One thing you may also want to do is remove a station from a playlist, e.g. when found that it not longer works. You can do that by pressing "**DEL**" or "**x**". The deleted station is copied to the **unnamed register** (refer to section [Copying and pasting - Registers](#copying-and-pasting---registers) for more information).

Finally, opening another playlist is also possible. Just press "**o**" and you will be presented with a list of saved playlists to choose from. These playlists must be saved beforehand in **PyRadio**'s configuration directory.

While executing any of the previous actions, you may get confirmation messages (when opening a playlist while the current one is modified but not saved, for example) or error messages (when an action fails). Just follow the on screen information, keeping in mind that a capital letter as an answer will save this answer in **PyRadio**'s configuration file for future reference.

### Managing "foreign" playlists

A playlist that does not reside within the program's configuration directory is considered a "**foreign**" playlist. This playlist can only be opened by the "**-s**" command line option.

When this happens, **PyRadio** will offer you the choice to copy the playlist in its configuration directory, thus making it available for manipulation within the program.

If a playlist of the same name already exists in the configuration directory, the "**foreign**" playlist will be time-stamped. For example, if a "**foreign**" playlist is named "*stations.csv*", it will be named "*2019-01-11_13-35-47_stations.csv*" (provided that the action was taken on January 11, 2019 at 13:35:47).

### Playlist history

**PyRadio** will keep a history of all the playlists opened (within a given session), so that navigating between them is made easy.

In order to go back to the previous playlist, the user just has to press "**\\\\**" (double backslash). To get to the first playlist "**\\]**" (backslash - closing square bracket) can be used.

Going forward in history is not supported.

## Search function

On any window presenting a list of items (stations, playlists, themes) a **search function** is available by pressing "**/**".

The *Search Window* supports normal and extend editing and in session history.

One can always get help by pressing the "**?**" key.

After a search term has been successfully found (search is case insensitive), next occurrence can be obtained using the "**n**" key and previous occurrence can be obtained using the "**N**" key.

## Line editor

**PyRadio** "*Search function*" and "*Station editor*" use a *Line editor* to permit typing and editing stations' data.

The *Line editor* works both on **Python 2** and **Python 3**, but does not provide the same functionality for both versions:


* In **Python 2**, only ASCII characters can be inserted.
* In **Python 3**, no such restriction exists. Furthermore, using CJK characters is also supported.

One can always display help by pressing "**?**", but that pauses a drawback; one cannot actually have a "**?**" withing the string.

To do that, one would have to use the backslash key "**\\**" and then press "**?**".

To sum it all up:

1. Press "**?**" to get help.
2. Press "**\\?**" to get a "**?**".
3. Press "**\\\\**" to get a "**\\**".

When in *Station editor*, the **Line editor** recognizes an extra mode: **Paste mode**.

This mode is enabled by pressing "**\\p**" and gets automatically disabled when the focus moves off the line editors.

This mode is designed to directly accept the "*?*" and "*\\*" characters (which are normally used as commands indicators). This makes it possible to easily paste a station's name and URL, especially when the "*?*" and "*\\*" characters exist in them; it is very common to have them in URLs.

### CJK characters support

The *Line editor* supports the insertion of [CJK Unified Ideographs](https://en.wikipedia.org/wiki/CJK_Unified_Ideographs), as described on [CJK Unified Ideographs (Unicode block)](https://en.wikipedia.org/wiki/CJK_Unified_Ideographs_(Unicode_block)) also known as URO, abbreviation of Unified Repertoire and Ordering. These characters, although encoded as a single code-point (character), actually take up a 2-character space, when rendered on the terminal.

A depiction of the editor's behavior can be seen at this image: [pyradio-editor.jpg](https://members.hellug.gr/sng/pyradio/pyradio-editor.jpg).

## Moving stations around

Rearranging the order of the stations in the playlist is another feature **PyRadio** offers.

All you have to do is specify the *source* station (the station to be moved) and the position it will be moved to (*target*).

There are three way to do that:

1. Press **Ctrl-U** or **Ctrl-D** to move the current station up or down.
2. Type a station number and press **Ctrl-U** or **Ctrl-D** to move the current station there.
3. Go to the position you want to move a station to, and press "**J**". This will *tag* this position (making it the *target* of the move). Then go to the station you want to move and press **Ctrl-U** or **Ctrl-D** to move it there.

## Specifying stations' encoding

Normally, stations provide information about their status (including the title of the song playing, which **PyRadio** displays) in Unicode (**utf-8** encoded). Therefore, **PyRadio** will use **utf-8** to decode such data, by default.

In an ideal world that would be the case for all stations and everything would be ok and as far as **PyRadio** is concerned, songs' titles would be correctly displayed. Unfortunately, this is not the case.

A lot of stations encode and transmit data in a different encoding (typically the encoding used at the region the come from). The result in **PyRadio** would be that a song title would be incorrectly displayed, not displayed at all, or trying to displaying it might even break **PyRadio**'s layout.

**Note:** **vlc** will not work in this case; it presumably tries to decode the said data beforehand, probably using **utf-8** by default, and when it fails, it provides a "**(null)**" string, instead of the actual data. So, you'd better not use **vlc** if such stations are in your playlists.

**PyRadio** addresses this issue by allowing the user to declare the encoding to use either in a station by station mode or globally.

### Station by station encoding declaration

As previously stated, a **PyRadio**'s playlist can optionally contain a third column (in addition to the station name and station URL columns), which declares the station's encoding.

So, when a **non-utf-8** encoded station is inserted in a playlist, its encoding can also be declared along with its other data. The drawback of this feature is that an encoding must be declared for **all stations** (so that the **CSV** file structure remains valid). To put it simple, since one station comprises the third column, all stations must do so as well.

This may seem intimidating (and difficult to achieve), but it's actually really simple; just add a "**,**" character at the end of the line of each station that uses the default encoding. In this way, all stations comprise the third column (either by declaring an actual encoding or leaving it empty).

Example:

Suppose we have a playlist with one **utf-8** encoded station:

```
Station1,Station1_URL
```

Now we want to add "**Station2**" which is **iso-8859-7** (Greek) encoded.

Since we know **all stations** must comprise the third (encoding) column, we add it to the existing station:


```
Station1,Station1_URL,
```

Finally, we insert the new station to the playlist:


```
Station1,Station1_URL,
Station2,Station2_URL,iso-8859-7
```

**Note:**
Using the **-a** command line option will save you all this trouble, as it will automatically take care of creating a valid **CSV** file. Alternatively, you can change the selected station's encoding by pressing "**E**" while in **PyRadio**.

### Global encoding declaration

**PyRadio**'s configuration file contains the parameter **default_encoding**, which by default is set to **utf-8**.

Setting this parameter to a different encoding, will permit **PyRadio** to successfully decode such stations.

This would be useful in the case where most of your stations do not use **utf-8**. Instead of editing the playlist and add the encoding to each and every affected station, you just set it globally.

### Finding the right encoding

A valid encoding list can be found at:

[https://docs.python.org/2.7/library/codecs.html#standard-encodings](https://docs.python.org/2.7/library/codecs.html#standard-encodings)

replacing **2.7** with specific version: **3.0** up to current python version.


## Player detection / selection

**PyRadio** is basically built around the existence of a valid media player it can use. Thus, it will auto detect the existence of its supported players upon its execution.

Currently, it supports MPV, MPlayer and VLC, and it will look for them in that order. If none of them is found, the program will terminate with an error.

Users can alter this default behavior by using the **-u** command line option. This option will permit the user either to specify the player to use, or change the detection order.

Example:

```
pyradio -u vlc
```
will instruct **PyRadio** to use VLC; if it is not found, the program will terminate with an error.

```
pyradio -u vlc,mplayer,mpv
```
will instruct **PyRadio** to look for VLC, then MPlayer and finaly for MPV and use whichever it finds first; if none is found, the program will terminate with an error.

**Note:** The default player to use can also be set in **PyRadio**'s [configuration file](#config-file), parameter **player** (default value is **mpv, mplayer, vlc**).


## Player connection protocol

Most radio stations use plain old http protocol to broadcast, but some of them use https.

Experience has shown that playing a **https** radio station depends on the combination of the station's configuration and the player used.

If such a station fails to play, one might as well try to use **http** protocol to connect to it.

**PyRadio** provides a way to instruct the player used to do so; the "*Force http connections*" configuration parameter. If it is *False* (the default), the player will use whatever protocol the station proposes (either **http** or **https**). When changed to **True**, all connections will use the **http** protocol.

When the selected player is initialized (at program startup), it reads this configuration parameter and acts accordingly.

If the parameter has to be changed mid-session (without restarting the program), one would press "*z*" to display the "*Connection Type*" window, where the parameter's value can be set as desired.

**Note:** Changes made using the "*Connection Type*" window are not stored; next time the program is executed, it will use whatever value the configuration parameter holds.

## Player default volume level

MPV and MPlayer, when started, use their saved (or default) volume level to play any multimedia content. Fortunately, this is not the case with VLC.

This introduces a problem to **PyRadio**: every time a user plays a station (i.e restarts playback), even though he may have already set the volume to a desired level, the playback starts at the player's default level.

The way to come around it, is to save the desired volume level in a way that it will be used by the player whenever it is restarted.

This is done by typing "**v**" right after setting a desired volume level.

### MPV

MPV uses profiles to customize its behavior.

**PyRadio** defines a profile called "**[pyradio]**" in MPV's configuration file (e.g. *~/.config/mpv/mpv.conf*). This profile will be used every time playback is started.

Example:

    volume=100

    [pyradio]
    volume=50

### MPlayer

MPlayer uses profiles to customize its behavior as well.

**PyRadio** defines a profile called "**[pyradio]**" in MPV's configuration file (e.g. *~/.mplayer/config*). This profile will be used every time playback is started.


Example:

    volume=100

    [pyradio]
    volstep=1
    volume=28

## Displaying Station Info

When a connection to a radio station has been established, the station starts sending audio data for the user to listen to.

Well, that's obvious, right?

Yes, but this is just half of the story.

The station actually also sends identification data, audio format data, notifications, etc. Part of this non-audio data transmitted by a station is the title of the song currently playing; this is why we can have this data displayed at the bottom of the screen.

Now, not all stations send the whole set of data; most send their name, website, genre and bit rate, for example, but some may omit the website or the genre.

**PyRadio** can receive, decode and display this data, and even help the user to identify an unknown station. This is the way to do it:

After a connection to a station has been established (after playback has started), just press "**i**" to display the station's info.

The window that appears includes the "*Playlist Name*" (the station name we have in the playlist) and the "*Reported Name*" (the name the station transmitted to us) among other fields (an example can bee seen here: [pyradio-station-info.jpg](https://members.hellug.gr/sng/pyradio/pyradio-station-info.jpg)). If these two names are not identical, the user can press "**r**" to rename the station in the playlist using the "*Reported Name*". This way an unknown station (when only the URL is known) can be correctly identified (after being inserted in a playlist with a dummy station name).

## Copying and pasting - Registers

**PyRadio** takes the concept of **registers** from [vim](https://www.vim.org), and adapts their function to its own needs. So this is how it all works.

There are 36 named registers (name is **a-z**, **0-9**) and one unnamed register.

* **Named registers** are actually files that contain stations and can be opened and edited as regular playlist files. There are some differences in handling them: they are accessible either individually or using a special window, they are automatically saved, and writing errors are ignored. The later means that registers should not be regarded as normal playlist files that can be safely saved and used forever; this is true as long as there's no problem with writing to them; if a writing error occurs they may get overwritten or emptied. To permanently save a register, on would **rename** it to a normal playlist file.

* The **unnamed register** holds just one station (the one that has been copied or added to a register or deleted from a playlist), and it is the one used when pasting to a register or a playlist. One can see its contents by pressing "**\u**".

To **copy** a station to a register one would press "**y**" and:

* one of "**a-z**", "**0-9**" to add it to the corresponding *named* register. The *unnamed* register is also populated.

* **ENTER** to add it to the *unnamed* register.

To **open** a *named* register, one would press "**'**" (single quote) and:

* one of "**a-z**", "**0-9**" to open the corresponding register.

* "**'**" (single quote) to open the "*Registers window*", so that a register can be selected.

To **rename** a *named* register, one would press "**\\r**" either in the "*Registers window*" or while editing the register.

To **clear a named register**, one would press "**\\c**" either in the "*Registers window*" or while editing the register.

To **clear all registers**, one would press "**\\C**" either in the "*Registers window*" or while editing a playlist or a register.

To **paste** the *unnamed* register to a playlist or register, one would press:

* "**p**" while editing a playlist or register.

* "**\\p**" while editing a playlist or register. This would open the "*Paste selection*" window.

* "**\\p**" in the "*Playlist Selection* or the "*Registers*" window.

## PyRadio Themes

**PyRadio** comes with 6 preconfigured (hard coded) themes:

1. **dark** (8 color theme). This is the appearance **PyRadio** has always had. Enabled by default.
2. **light** (8 color theme). A theme for light terminal background settings.
3. **dark_16_colors** (16 color theme). "**dark**" theme alternative.
4. **light_16_colors** (16 color theme). "**light**" them alternative.
5. **white_on_black** or **wob** (256 color b&w theme). A theme for dark terminal background settings.
6. **black_on_white** or **bow** (256 color b&w theme). A theme for light terminal background settings.

Furthermore, three 256-color system themes (these are actual files saved in the **themes** installation directory) are also available:

1. **brown_by_sng**
2. **pink_by_sng**
3. **purple_by_sng**

The visual result of an applied theme greatly depends on the terminal settings (e.g. foreground and background color settings, palette used, number of colors supported, real or pseudo-transparency support, etc.)

Pressing "**t**" will bring up the *Theme selection window*, which can be used to activate a theme and set the default one.

**Note:** Themes that use more colors than those supported by the terminal in use, will not be present in the *Theme selection window*. Furthermore, if a such at theme is set as default (or requested using the "**-t**" command line option), **PyRadio** will fall-back to the "**dark**" theme (or the "**light**" theme, if the terminal supports 8 colors and default theme is set to "*light_16_colors*"), and will display a relevant message at program startup.

The  *Theme selection window* will remain open after activating a theme, so that the user can inspect the visual result and easily change it, if desired. Then, when he is satisfied with the activated theme, the window will have to be manually closed (by pressing "**q**" or any other relevant key - pressing "**?**" will bring up its help).

The use of custom themes and theme editing is not implemented yet; these are features for future releases.

### Using transparency

**PyRadio** themes are able to be used with a transparent background.

Pressing "**T**"  will toggle the transparency setting and save this state in **PyRadio**'s configuration file (transparency is off by default).

Setting transparency on, will actually force **PyRadio** to not use its own background color, effectively making it to display whatever is on the terminal (color/picture/transparency).  The visual result depends on terminal settings and whether a compositor is running.

When the *Theme selection window* is visible, a "**[T]**" string displayed  at  its  bottom right corner will indicate that transparency is *on*.

## Session Locking

**PyRadio** uses session locking, which actually means that only the first instance executed within a given session will be able to write to the configuration file.

Subsequent instances will be "*locked*". This means that the user can still play stations, load and edit playlists, load and test themes, but any changes will **not** be recorded in the configuration file.

### Session unlocking

If for any reason **PyRadio** always starts in "*locked mode*", one can **unlock** the session, using the "*--unlock*" command line parameter.

## Update notification

**PyRadio** will periodically (once every 10 days) check whether a new version has been released.

If so, a notification message will be displayed, informing the user about it.

## Cleaning up

Since version 0.8.7.3 (0.8.8-beta2), it is not necessary to follow the previous procedure any more; **PyRadio** will search and remove any previously installed files when the "**-u**" (uninstall) parameter is used.

This procedure will remove any **Pyradio** files installed in your system, but will leave instact **PyRadio** configuration files. 

Windows users notice: This procedure **will not** uninstall python, mplayer, or git from your system.

Example:

    $ devel/build_install_pyradio -u
    Uninstalling PyRadio
    ** Removing executable ... done
    ** Removing help files ... done
    Looking for python installed files
    ** Removing "pyradio-0.8.8-py3.8.egg" ... done
    ** Removing "pyradio-0.8.6-py2.7.egg" ... done
    ** Removing "pyradio-0.8.8-py3.8.egg" ... done
    PyRadio successfully uninstalled

In this example, running *devel/build_install_pyradio -u* has removed **PyRadio** python 3.8 system wide installation files, **PyRadio** python 2.7 system wide installation files,  and **PyRadio** python 3.8 user installation files, found in the system.

I would recommend to execute *devel/build_install_pyradio -u* from time to time, and reinstall **Pyradio** right after its completion.

### Previous cleaning up procedure

As **PyRadio** versions accumulate, when building from source, one may have to *clean up* old installation files.

To do that, one has to observe the installation process in order to find out where the package is installed. The installation would complete printing the following messages (on *python 3.7*):

    Installed /usr/lib/python3.7/site-packages/pyradio-0.7.8-py3.7.egg
    Processing dependencies for pyradio==0.7.8
    Finished processing dependencies for pyradio==0.7.8

From this we get that the installation directory is **/usr/lib/python3.7/site-packages**. This may be different though, depending on the distribution and python version used.

Let's see what **PyRadio** files exist there:


    $ ls -d /usr/lib/python3.7/site-packages/pyradio*

    /usr/lib/python3.7/site-packages/pyradio-0.7.6.2-py3.7.egg
    /usr/lib/python3.7/site-packages/pyradio-0.7.7-py3.7.egg
    /usr/lib/python3.7/site-packages/pyradio-0.7.8-py3.7.egg

As we see, previous versions still exist in this system: **0.7.6.2** and **0.7.7**. These files (actually directories) can safely be removed:

    $ sudo rm -rf /usr/lib/python3.7/site-packages/pyradio-.7.6.2-py3.7.egg
    $ sudo rm -rf /usr/lib/python3.7/site-packages/pyradio-0.7.7-py3.7.egg

## Debug mode

Adding the "**-d**" option to the command line will instruct **PyRadio** to enter *Debug mode*, which means that it will print debug messages to a file. This file will always reside in the user's home directory and will be named *pyradio.log*.

In case of a bug or a glitch, please include this file to the issue you will [open at github](https://github.com/coderholic/pyradio/issues).

## Reporting bugs

When a bug is found, please do report it by [opening an issue at github](https://github.com/coderholic/pyradio/issues), as already stated above.

In you report you should, at the very least, state your **pyradio version**, **python version** and **method** of installation (built from source, AUR, snap, whatever).

It would be really useful to include **~/pyradio.log** in your report.

To create it, enter the following commands in a terminal:

    $ rm ~/pyradio.log
    $ pyradio -d

Then try to reproduce the bug and exit **pyradio**.

Finally, include the file produced in your report.

## Acknowledgment

**PyRadio** uses code from the following projects:

1. [CJKwrap](https://gitlab.com/fgallaire/cjkwrap) by Florent Gallaire - A library for wrapping and filling UTF-8 CJK text.
