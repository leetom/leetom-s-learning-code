#!/usr/bin/env	perl
#
use 5.010;
use Math::Complex;
$i = -2;
print sqrt($i), "\n";
$i = -2+3i;
print $i,"\n";

__END__
for my $i (2..1000){
	for my $j (1..$i-1){
		my $avg = ($i + $j)/2.0;
		#say "$i , $j ";
		my $avgln = ($i - $j) / log($i / ($j + 0.0));
		say "$i , $j " , $avg - $avgln;
		die "Negtive: $avg and $avgln" if $avg < $avgln;
	}
}
