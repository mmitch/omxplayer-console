omxplayer-console
=================

about
-----

omxplayer-console frontend is a console frontend for the omxplayer
media player.  Some formats that omxplayer can't play will fall
back to playback via mplayer.  Other formats and players can be
configured, too.

omxplayer-console features a text mode file browser for media
selection.  Simple commands like "play" or "pause" will act on
the selected file. omxplayer-console then translates and relays
these commands to the appropriate player (omxplayer/mplayer).

The second script frontend-term relieves you of typing commands
like "up", "up", "play" and allows direct interaction via keyboard,
e.g. cursor key movement.

I use these scripts to remotely control my Raspberry Pi as a video
player using an USB IR remote.  See my blog posts for further details
(German only):
https://www.cgarbs.de/blog/archives/1072-How-to-RasPi-Videos-mit-omxplayer.html
https://www.cgarbs.de/blog/archives/1075-How-to-RasPi-bequem-fernsteuern.html

copyright
---------

omxplayer-console - console frontend for omxplayer (and others)  
Copyright (C) 2013  Christian Garbs <mitch@cgarbs.de>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

dependencies
------------

- Perl
- File::Which
- figlet
- omxplayer (optional)
- mplayer (optional)
- ip (optional)

omxplayer-console usage
-----------------------

```
omxplayer-console [<start_directory>]
```

If `<start_directory>` is not given, `$HOME/media` is used as the initial directory.

omxplayer-console commands
--------------------------

omxplayer-console is controlled via commands on stdin - one command
per line.  Some commands take optional numeric parameters, their
meaning is given in {curly braces}.  These commands are supported:

* up/down -> navigate in file selector {move multiple lines}
* right -> enter selected folder
* left -> enter parent folder
* play -> play selected file
* stop -> stop playback
* quit -> quit omxplayer-console
* pause -> pause/resume
* seek+ -> seek forward {number of seconds to skip}
* seek- -> seek backward {number of seconds to skip}
* volume+ -> raise volume {value}
* volume- -> lower volume {value}
* audio -> switch audio stream
* subtitle -> switch subtitles
* nosub -> remove subtitles
* subdelay+ -> raise subtitle delay {number of milliseconds}
* subdelay- -> lower subtitle delay {number of milliseconds}
* info -> show various information

note: omxplayer can only seek +/-30 and +/-600 seconds :-/

frontend-term usage
-------------------

```
frontend-term
```

Currently, frontend-term uses no arguments.


frontend-term keybindings
-------------------------

frontend-term is a convenient frontend to omxplayer-console that
relieves you of typing all the commands.  Run it like this:

```bash
./frontend-term | ./omxplayer-console
```

Default keybindings are as follows:

* cursor keys -> file selector navigation (up/down/left/right)
* enter -> play selected file (play)
* space -> stop playback (stop)
* q -> quit (quit)
* p -> pause/resume (pause)
* f -> forward 20 seconds (seek+20)
* F -> forward 100 seconds (seek+100)
* r -> rewind 20 seconds (seek-20)
* R -> rewind 100 seconds (seek-100)
* + -> raise volume (volume+10)
* - -> lower volume (volume-10)
* a -> switch audio stream (audio)
* s -> switch subtitles (subtitle)
* S -> remove subtitles (nosub)
* d -> raise subtitle delay (subdelay+250)
* D -> lower subtitle delay (subdelay-250)
* i -> show various informations (info)

web radio mode
--------------

Files ending with .webradio must contain one line with the stream to
play.  The format of a line is the same as a station definition from
[jamirdochegal](https://github.com/mmitch/jamirdochegal/):

    [<shortcut>|]<name> [<flag>]<url>
 
* `<shortcut>` and `<name>` are ignored by omxplayer-console
* `<url>` is the playlist/stream url
* `<flag>` is optional an can be one or more of
  `DIRECT`: when `<url>` is no playlist but a direct stream
  and
  `OGGDEMUX`: work around mplayer/lavf-demuxer problems with OGG streams

So a minimal stream file would look like this (the name being ignored):

    MyWebRadio http://www.example.com/stream.pls

To convert the jamirdochegal station list at the end of the script
into single .webradio files, use this:

```bash
while read LINE;
    do echo "$LINE" > "$(echo "$LINE" | cut -d ' ' -f 1 | cut -d '|' -f 1).webradio"
done
```

to be done
----------

* add copyright notice display command
* add help text to commandline
