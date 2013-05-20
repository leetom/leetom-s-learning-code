#!/usr/bin/perl

use 5.010;
use File::Find;

sub print_file{
	say $_ if -f "/usr/lib/$_ is found"; 
	#say $_ . "\t" . $File::Find::name;
}

find(\&print_file, '/lib');
