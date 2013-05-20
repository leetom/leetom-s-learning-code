#!/usr/bin/perl

use 5.010;

my @text;
chomp(@text = <STDIN>);
say "@text";
@text[@text] = 'EOF'; #@text[0, 0, 0] = ('EOF', undef, undef);
#@text[@text] = ('EOF', 'EOF2', 'eof3');

say "@text";

__END__

