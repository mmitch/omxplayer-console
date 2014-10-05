#!/usr/bin/perl -w
use strict;

my $OUTPUTFOLDER='/home/pi/video/Webradio';
my $JAMIRDOCHEGAL='/home/pi/git/jamirdochegal/jamirdochegal';


chdir("$OUTPUTFOLDER");
unlink glob '*.webradio';

open IN, '<', $JAMIRDOCHEGAL or die $!;
while (my $line = <IN>)
{
    last if $line =~ /__DATA__/;
}
while (my $line = <IN>)
{
    $line =~ s/^\s+//;
    $line =~ s/\s+$//;
    next if $line =~ /^#/;
    next if $line =~ /^$/;
    
    my $name = $line;
    $name =~ s/^([^ ]+\|)//;
    $name =~ s/ [^ ]+$/.webradio/;

    open OUT, '>', $name or die $!;
    print OUT $line;
    close OUT;

}
close IN or die $!;
