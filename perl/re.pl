#!/usr/bin/perl -w
#
$_ = "abc456";
if(/\w*(\d+)/){
	print $1;
}
