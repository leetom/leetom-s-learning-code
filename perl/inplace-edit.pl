#!/usr/bin/env perl

use 5.010;

$^I = ".back";

while(<>){
	s/bc/oo/i;
	print;
}
