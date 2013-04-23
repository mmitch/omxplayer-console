omxplayer-console
=================

console frontend for omxplayer (and others)

dependencies
------------

- Perl
- figlet
- omxplayer (optional)
- mplayer (optional)

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
* seek+ -> seek forward {number of seconds to skip}
* seek- -> seek backward {number of seconds to skip}
* quit -> quit omxplayer-console

frontend-term keybindings
-------------------------

frontend-term is a convenient frontend to omxplayer-curses that
relieves you of typing all the commands.  Run it like this:

```bash
./frontend-term | ./omxplayer-console
```

Default keybindings are as follows:

* cursor keys -> file selector navigation (up/down/left/right)
* enter -> play selected file (play)
* space -> stop playback (stop)
* q -> quit (quit)
* f -> forward 20 seconds (seek+20)
* F -> forward 100 seconds (seek+100)
* r -> rewind 20 seconds (seek-20)
* R -> rewind 100 seconds (seek-100)

web radio mode
--------------

Files ending with .webradio must contain one line with the stream to
play.  The format the line is the same as a station definition from
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
