#!/usr/bin/perl

use strict;

my $haha = 'haha';

my $ref_haha = \$haha;

my $glob_ref = \*haha;

print ref($haha);
print ref($ref_haha);

print ref($glob_ref);
