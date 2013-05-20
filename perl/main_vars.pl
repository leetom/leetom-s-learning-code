#!/usr/bin/perl
#
use strict;

our ( @friends, @dogs, $key, $value);
my ( $name, $money);
@friends = ("lee", "liu", "wu");
local $main::dude = "Sun";
$name = "leetom";

while(($key, $value) = each(%main::)){
	print "$key:\t$value\n";
}
