#!/usr/bin/env perl -w

#use 5.012;
use feature 'say';
#use Data::Dumper;
use YAML;

$hash = {
  'haha' => 'oo',
  'aa'  => 'bb',
};
@arr = map {"$_.goo"} keys %$hash;
print Dump @arr;

__END__
my $a = {
  good => 'hello',
};

print $a->{good};
#my $aa = "good";
#print split '', $aa ;


__END__
$a = 50;
$b = 30;
say $a, $b;
($a, $b) = ($b, $a);

say $a, $b;
