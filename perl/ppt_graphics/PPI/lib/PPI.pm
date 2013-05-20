package PPI;

use 5.014002;
use strict;
use warnings;
use GD;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.



our $VERSION = '0.01';

my $default_opt = {
	number => 7,
	colors => [
		[255, 0, 0], #red
		[255, 165, 0], #orange
		[255, 255, 0], #yellow
		[0, 255, 0], #green
		[0, 0, 255], #blue
		[0, 255, 255], #cyan
		[128, 0, 128], #purple
		[128, 128, 128], #gray
	],

};
# Preloaded methods go here.
sub new{
	my ($class, $width, $height) = @_;
	my $gd = GD::Image->new($width, $height);
	bless $gd, $class;
}

sub set_color{
	my ($self, $color, $idx) = @_;
	


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

PPI - Perl extension for blah blah blah

=head1 SYNOPSIS

  use PPI;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for PPI, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

leetom, E<lt>leetom@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by leetom

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
