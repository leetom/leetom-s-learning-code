#!/usr/bin/perl

#

my $var = "this is a string";

my @var = ("this", "is", "an", "array");
&func(*var);
print $var;

print "array:@var";

sub func{
	(*new_var) = @_;
	print $new_var, "in sub rountines";
	print "@var", "in sub rountines";
	print "off func\n";
}
