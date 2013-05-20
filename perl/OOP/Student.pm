#!/usr/bin/perl
package Student;

sub new{
	my $class = shift;
	my $data = {};
	our $students;

	my $ref = sub{
		my ($access_type, $key, $value) = @_;
		
		if($access_type eq 'set'){
			$data->{$key} =  $value;
		}elsif($access_type eq 'get'){
			return $data->{$key};
		}elsif($access_type eq 'keys'){
			return (keys %{$data});
		}elsif($access_type eq 'destroy'){
			$students--;
			return $students;
		}else{
			die "Access type should be set or get";
		}
	};

	print "New student created, now we have ", ++$students, " students.\n";
	bless($ref, $class);
}

sub set{
	my ($self, $k, $v) = @_;
	$self->('set',$k, $v);
}

sub get{
	my ($self, $k) = @_;
	return $self->('get', $k);
}

sub display{
	my $self = shift;
	my @keys = $self->("keys");
	print "@keys", "\n";
	@keys = reverse(@keys);

	for(@keys){
		my $value = $self->("get", $_);
		printf "%-25s%-5s:%-20s\n", $self, $_, $value;
	}
	print "\n";
}

sub DESTROY{
	my $self = shift;
	print "Object going out of scope: \n";
	print "Students remain: ", $self->("destroy"), "\n";
}
1;
