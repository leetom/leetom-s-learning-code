#!/usr/bin/perl

use 5.010;
use File::Find;
#use strict 'vars';

my @dir = qw(/usr/bin);
{
	my $count = 0;
}

find( sub{
	$count++;
	say "$File::Find::name found!";
	say "The count is $count";
}, @dir);

say $count;
