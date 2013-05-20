use GD;
my $gd = GD::Image->newFromPng('GDExample.png');
my $black = $gd->colorAllocate(0,0,0);
my $green = $gd->colorResolve(0,196,0);

$gd->arc (199, 149, 300, 100, 0, 270, $black);
$gd->line(199, 149, 199, 99, $black);
$gd->line(199, 149, 349, 149, $black);
$gd->fillToBorder(149, 149, $black, $green);

binmode STDOUT;
print $gd->png;
__END__
$gd->arc (199, 149, 300, 100, 0, 270, $black);
$gd->line(199, 149, 199, 99, $black);
$gd->line(199, 149, 349, 149, $black);
$gd->colorDeallocate($border);


