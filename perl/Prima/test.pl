#!/usr/bin/perl

use Prima qw(Application Buttons);

new Prima::MainWindow(
        text     => 'Hello world!',
        size     => [ 200, 200],
)-> insert( Button =>
        centered => 1,
        text     => 'Hello world!',
        onClick  => sub { $::application-> close },
);

run Prima;