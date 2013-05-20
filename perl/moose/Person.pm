#!/usr/bin/perl
#
package Person;
use Moose;

has name => (
  is => 'rw',
  isa => 'Str',
);

has weight => (
  is => 'ro',
  isa => 'Num',
);

has gender => (
  is => 'rw',
  isa => 'Str',
  default => 'male'
);

sub say{
  print "I am a person! \n";
}

1;
