use GD;
$text
$font
$fontsize
$angle
($x, $y)
=
=
=
=
=
'String';
'/usr/share/fonts/ttfonts/arialbd.ttf';
12;
0;
(20, 25);
@bb = GD::Image->stringTTF(0, $font, $fontsize, $angle, $x, $y, $text);
$x += $x - $bb[6];
$y += $y - $bb[7];
$im->stringTTF($black, $font, $fontsize, $angle, $x, $y, $text);
