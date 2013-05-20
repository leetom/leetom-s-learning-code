#!/usr/bin/perl
#
use 5.010;

@file_selected = grep -s $_ > 1000, @ARGV;

print "@file_selected", "\n";

@file_changed = map {"    " . $_} @ARGV;
print "after changed, the names changed to :\n @ARGV", "\n";
