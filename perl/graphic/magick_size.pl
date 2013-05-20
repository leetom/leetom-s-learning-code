#!/usr/bin/perl

use Image::Magick;

my $img_file = $ARGV[0];
$img = Image::Magick->new;
my ($width, $height, $size, $format) = $img->Ping($img_file) or die "Cannot get info for $img_file: $!";
print "Width: $width, Height: $height, Size: $size, Format: $format \n";


