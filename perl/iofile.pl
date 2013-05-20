#!/usr/bin/perl

use IO::File;

my $fh = IO::File->new('test.txt', 'r+');

if(defined $fh){
	while(<$fh>){
		print;
	}
}

undef $fh;
