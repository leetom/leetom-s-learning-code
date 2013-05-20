#!/usr/bin/perl
#
#
use 5.010;
use strict;

my %myhash;
$myhash{is} = 2;
for (1..10000000){
	$myhash{is} = $_;
}
print $myhash{is};
__END__
my $myhash{"is"} = 2;
for (1..10000){
	$myhash{"is"} = $_;
}
print $myhash{"is"};
