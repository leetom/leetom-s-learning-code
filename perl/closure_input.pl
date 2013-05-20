#!/usr/bin/perl -w
use 5.012;
use strict;

use File::Find;

sub print_bigger_than{
	my $minimum_size = shift;
	return sub { print "$File::Find::name\n" if -f and -s > $minimum_size};
}

my $bigger_than_1024 = print_bigger_than(1024);
find($bigger_than_1024, '/bin');
