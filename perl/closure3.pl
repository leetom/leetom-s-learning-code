#!/usr/bin/perl

use 5.010;
use strict;

{
	my $hello = 'world';
	sub say_hello {
		say $hello;
	}

}
sub say_hello2{
	#say $hello;
}

&say_hello();
&say_hello2();
