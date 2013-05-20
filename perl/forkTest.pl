#!/usr/bin/env	perl

use 5.010;
use strict;

say "Parent P before fork..";
defined(my $pid = fork) or die "Cannot fork a child process: $!";
say "Parent P after fork..";
unless($pid){
	say "Child Process before sleep";
	sleep(1);
	say "Child Precess after sleep";
}else{
	say "In else block";
}
say "Parent P after child P..";
wait;
say "End....";
