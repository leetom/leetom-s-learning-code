#!/usr/bin/perl
#
use 5.010;

while(1){
	$re = <STDIN>;
	chomp $re;
	last unless $re;
	@files = `ls /etc/`;
	@selected = grep {
		$result = eval {$_ =~ /$re/};
		if($@){
			print "RE error:$@";
			next;
		}
		$result;
	} @files;
	print "@selected";
}
