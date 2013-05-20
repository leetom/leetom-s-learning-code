#!/usr/bin/perl

use strict;

sub png_size{
	my $file = shift or return;
	my ($buf, $fh);
	open($fh, $file);
	binmode($fh);
	read($fh, $buf, 24);
	my ($hdr, $l, $ihdr, $w, $h) = unpack("a8 N a4 N N", $buf);
	#print $w, $h, "\n";
	return unless $hdr eq "\x89PNG\x0d\x0a\x1a\x0a" &&
		$ihdr eq "IHDR";
	return ($w, $h, "PNG");
}

sub xcf_size{
	my $file = shift or return;
	my ($buf, $fh);
	open($fh, $file) or return;
	binmode($fh);
	read($fh, $buf, 22);
	my ($hdr, $v, $w, $h) = unpack("a9 Z5 N N", $buf);

	return unless (hdr eq 'gimp xcf ');
	SWIRCH: {
		$v eq 'file' and $v = 'XCF0', last SWITCH;
		$v eq 'v001' and $v = 'XCF1', last SWITCH;
		# Unknow version, just return
		return;
	}

	return ($w, $h, $v);
}

my @size = &png_size($ARGV[0]);
print "@size\n";
