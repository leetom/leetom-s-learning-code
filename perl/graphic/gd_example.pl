#!/usr/bin/perl

use 5.010;
use GD;

my $gd = GD::Image->new(400, 300);

my $white = $gd->colorAllocate(255,255,255);
my $black = $gd->colorAllocate(0,0,0);
my $red = $gd->colorAllocate(255,0,0);
my $green = $gd->colorAllocate(0,255,0);
my $blue = $gd->colorAllocate(0,0,255);
my $yellow = $gd->colorAllocate(255,255,0);

$gd->filledRectangle(0, 129, 199, 169, $blue);

my $poly = GD::Polygon->new;
$poly->addPt(199, 149);
$poly->addPt(399, 74);
$poly->addPt(324, 149);
$poly->addPt(399, 224);
$gd->filledPolygon($poly, $yellow);
$gd->polygon($poly, $black);

$gd->arc(199, 149, 250, 250, 0, 360, $red);
$gd->arc(199, 149, 100, 200, 0, 360, $red);
$gd->fillToBorder(99, 149, $red, $green);

$gd->rectangle(0, 0, 399, 299, $red);
$gd->line(199, 0, 199, 299, $red);
$gd->line(0, 149, 399, 149, $red);

binmode STDOUT;

print $gd->png;
