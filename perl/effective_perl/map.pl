#!perl
use 5.012;

my $str = "This is:good:for : him";

my @mat = $str =~ /\w+\:\w+/;
print @mat,"\t", $#mat;
