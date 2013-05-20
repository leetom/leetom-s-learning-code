use Image::Magick;

my $rc;
my $img = Image::Magick->new;

$rc = $img->Read('1.bmp');
warn $rc if $rc;
#$rc = $img->Write('out.png');
warn $rc if $rc;

@$img = ();
$img->Set(size=>'100x600');
#$rc = $img->Read('gradient:#efefef-#3f3f3f');
$rc = $img->Read('NETSCAPE');
warn $rc if $rc;
$img->Rotate(degrees => -90);
$rc = $img->Write('grayGradient.png');
warn $rc if $rc;
