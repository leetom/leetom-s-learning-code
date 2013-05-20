#!/usr/bin/perl

use Animal;

$animal = Animal->new;
print $animal->get_legs;

$animal->{such} = 'hello world';

print $animal->{such} . "\n";
print $animal->{eyes};
