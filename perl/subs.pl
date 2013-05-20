#!/usr/bin/perl
#
chdir("/stuf") or die "Can not change dir: $!";

sub BEGIN{print "Begin the program\n";}
sub END{print "End of the program\n";}
