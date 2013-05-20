#!/usr/bin/perl -w
# Display Hello World program

use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("200x100");
$mw->title("Hello World!!!");

$mw->Label(-text => 'Hello World')->pack();

$mw->Button(-text => "Close", -command =>sub{exit})->pack();

MainLoop;
