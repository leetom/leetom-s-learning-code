#!/usr/bin/perl
#
use Person;
use YAML;

my $a = Person->new(name => 'test', weight => 55);
#$a->name("good!");
print $a->name;

$a->gender("male");
print $a->gender;

