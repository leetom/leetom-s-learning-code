#!/usr/bin/perl
#
use GD;

# create a new image
$im = new GD::Image(100,100);

# allocate some colors
$white = $im->colorAllocate(255,255,255);
$black = $im->colorAllocate(0,0,0);
$red = $im->colorAllocate(255,0,0);
$blue = $im->colorAllocate(0,0,255);
$green = $im->colorAllocate(0,255,0);

# make the background transparent and interlaced
$im->transparent($red);
$im->interlaced('true');

# Put a black frame around the picture
$im->rectangle(0,0,99,99,$green);

# Draw a blue oval
$im->arc(50,50,95,75,0,360,$blue);

$im->filledRectangle(60,60,85,85,$green);

# And fill it with red
$im->fill(50,50,$red);

# make sure we are writing to a binary stream
binmode STDOUT;

# Convert the image to PNG and print it on standard output
print $im->png;
