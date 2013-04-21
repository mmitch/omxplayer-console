omxplayer-console
=================

console frontend for omxplayer (and others)

dependencies
------------

- Perl
- mplayer
- figlet

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

