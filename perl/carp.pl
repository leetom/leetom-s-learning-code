package no;
use Carp (cluck);

print "give me a grade: ";

my $grade = <STDIN>;

cluck "Illegal value: $grade" if $grade < 0 || $grade > 100;
