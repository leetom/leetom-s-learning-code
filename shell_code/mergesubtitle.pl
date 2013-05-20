#!/usr/bin/perl
#
use strict;

my $dir  = '.';
opendir DIR, $dir or die "Can not open $dir: $!";
foreach my $filename (readdir DIR){
	next unless $filename =~ /(.*)\.en\.srt$/;
	my $name = $1;
	print LOG $1."\n";
	open ENSUB, "<", $filename or die "Can not open $filename: $!";
	open NEWSUB, ">","$name.srt";
	while (<ENSUB>){
		print NEWSUB $_;
	}
	open CNSUB, "<", "$name.gb.srt" or open CNSUB, "<", "$name.ch.srt" or die "Can not open $name.gb.srt: $!";
	while (<CNSUB>){
		print NEWSUB $_;
	}
	open LOG, ">", "LOG.LOG";
}
	
