#!/usr/bin/perl

use strict;


&print_hash("helloworld", "name"=>'hello', 'foo'=>'bar');

sub print_hash{
	#my $ref = shift;
	my (%argv) = @_;
	for (keys %argv){
		print "Value of $_ is $argv{$_}" . "\n";
	}
}
