#!/usr/bin/perl -w
#
use utf8;
use strict;
use 5.010;

open FILE, "<", "split.pl" or die "Cannot open file:$!\n";
while(<FILE>){
	last if $. == 5;
	say $.;
}
seek(FILE, -3, 2);
my $line = <FILE>;
print $line;

__END__
flock(FILE, 2);
while(<FILE>){
	sleep 5;
	print;
}
