#!/usr/bin/perl

use File::Find;
use feature say;

my $callback = sub{};
{
	my $count = 0;
}

{
	$callback = sub{ print ++$count, ": $File::Find::name\n" };
	say $count;
}
sub print_count{
	say "Count is ",  $count;
}

find ($callback, '.');
&print_count;
