#!/usr/bin/perl -w
use Imager::QRCode;
my $qrcode = Imager::QRCode->new(
        size          => 2,
        margin        => 2,
        version       => 1,
        level         => 'M',
        casesensitive => 1,
        lightcolor    => Imager::Color->new(255, 255, 255),
        darkcolor     => Imager::Color->new(0, 0, 0),
    );
my $img = $qrcode->plot("You infomation here!");
$img->write(file => 'qrcode.bmp', type=>'bmp')  or die  $img->errstr;
