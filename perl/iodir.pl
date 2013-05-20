
use strict;
use IO::Dir;

my $dh = IO::Dir->new('/etc');

while(defined(my $file = $dh->read)){
	print "i can find $file\n" if $file =~ /\.conf$/;
}

$dh->rewind;

while(defined(my $file = $dh->read)){
	print "Also $file is found!\n" if $file =~ /\.rc/;
}
__END__
=head1	IO::Dir

=head1	SYNOPSIS

	=head2	List
