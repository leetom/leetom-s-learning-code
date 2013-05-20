#!/usr/bin/perl
#
use User;
use 5.014;

my $user = User->new();
say ref $user;

say $user->name('test');
say $user->username();

say $user->gender;

$user->say;


