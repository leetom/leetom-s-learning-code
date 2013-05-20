#!/usr/bin/env perl

use strict;

open FH, "<", "test.txt";



sub log{
	print <FH>;
}


__END__
my $fh;
$fh = 0;

open $fh, "<", "test.txt" or die "Cannot open file: $!";

while(<$fh>){
	print;
}
