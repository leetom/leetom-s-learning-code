#!/usr/bin/perl

use 5.010;
use strict;
my $file = $ARGV[0];
open SRCFILE, "<", $file;

while(<SRCFILE>){
	if(/([a-zA-Z])\w*\s(\w+):\spass\s+(\d+)\%/i){
		print "\L$1$2: " . $3 * 0.01 . " ";
	}
}



print "\n";
	
