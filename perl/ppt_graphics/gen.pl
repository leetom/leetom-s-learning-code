#!/usr/bin/perl -w
#
use 5.012;
use GD;



my $gd = GD::Image->new(960, 60);

my $steps = int($ARGV[0]) ||  8;

$steps = 13 if $steps > 13;

mkdir $steps;
chdir $steps;

my @colors = (
	[255, 0, 0], #red
	[255, 165, 0], #orange
	[255, 255, 0], #yellow
	[0, 255, 0], #green
	[0, 0, 255], #blue
	[0, 255, 255], #aqua
	[127, 0, 127], #purple
	[127, 127, 127], #gray
	[127, 255, 0], #chartreuse
	[255, 20, 147], #deeppink
	[30, 144, 255], #dodgeblue
	[128, 128, 0], #olive
	[255, 69, 0], #orangered

);
my $white = $gd->colorAllocate(255, 255, 255);
$gd->transparent($white);
$gd->interlaced('true');

my @palette = map {$gd->colorAllocate(@$_)} @colors;


my $x_pos = 0;
for(1..$steps){
	$gd->filledRectangle($x_pos, 0, $x_pos + 960 / $steps, 45, $palette[$_-1]);
	$x_pos += 960 / $steps;
}
my @file;
open $file[0], '>', '0.png';
binmode $file[0];
print {$file[0]} $gd->png;
close $file[0];
$x_pos = 0;
for(1..$steps){
	$gd->filledRectangle($x_pos, 46, $x_pos + 960 / $steps, 60, $palette[$_-1]);
	open $file[$_], '>', $_ . '.png';
	binmode $file[$_];
	print {$file[$_]} $gd->png;
	close $file[$_];
	$gd->filledRectangle($x_pos, 46, $x_pos + 960 / $steps, 60, $white);
	$x_pos += 960 / $steps;
}


