#!/usr/bin/env perl

use 5.010;

my $a = 'hello world';

sub greet{
    say $a;
    my $b = 'b again';
{{
    &greet2;
	sub greet2{
	    print $b;
	}
}}
}


say $b;
&greet;
