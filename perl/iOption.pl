#!/usr/bin/perl -i.bak
#
use 5.010;

while(<>){
	s/sd/OOO/g;
	tr/a-z/A-Z/;
	print;
}

