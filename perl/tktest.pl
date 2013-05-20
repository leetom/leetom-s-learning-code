#!/usr/bin/perl -w
#
use 5.010;
use Tk;

my $main = new MainWindow;

$main->Label(-text=>"Hello World!"
)->pack;

$main->Button(-text=>"Quit",
	-command=>sub{exit}
)->pack;
MainLoop;
