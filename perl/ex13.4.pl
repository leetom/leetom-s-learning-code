#!/usr/bin/perl

use strict;
use YAML;

my $student = {
	Name => undef,
	SSN => undef,
	Friends => [],
	Grades => {
			Science => [],
			Math => [],
			English => [],
		},
	};

$student->{Name} = "John Smith";
$student->{SSN} = '510-23-1232';
push $student->{Friends}, qw(Tom, Bert, Nick);
push $student->{Grades}->{Science}, (100, 83, 77);
push $student->{Grades}->{Math}, (90, 89, 85);
push $student->{Grades}->{English}, (76, 77, 65);


print Dump(\$student);

print "'''";
