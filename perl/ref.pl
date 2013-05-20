#!/usr/bin/perl
#
use 5.010;
my $p = [1, 3, 5];

say $p->[0];
say @$p;
say $$p[0];
say ${$p}[1];
say @{$p}[1];
@p = (2, 4, 6);
say @p[1];
