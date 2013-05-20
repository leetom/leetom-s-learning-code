#!/usr/bin/perl
package Mymodule;
#use strict;
require Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($x @y %z);

our $x = 'x in my module';
local @Mymodule::y = qw(y in my module);
local %Mymodule::z = ( 1 => 'helo', '22' => 'world');

