#!/usr/bin/perl
package Animal;
sub new{
my $ref = {
	"leg" => 6,
	"eyes" => 2,
	};
return bless($ref, Animal);
}

sub get_legs{
	my ($self) = @_;
	return $self->{leg};
}

1;
