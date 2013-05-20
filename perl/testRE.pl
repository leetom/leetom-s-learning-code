#!/usr/bin/perl
#
use 5.010;

while(<STDIN>){
	print "matched!\n" if /^[\d- ]{8,11}$/;
}
