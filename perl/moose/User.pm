#!/usr/bin/perl
#
package User;
use Person;
use Moose;

extends "Person";

has 'username', is => 'rw', isa => 'Str', default => 'test';

has 'password', is => 'rw', isa => 'Str';

override 'say' => sub{
  print "I am a User! this is a overriden method\n";
  super();
};


1;
