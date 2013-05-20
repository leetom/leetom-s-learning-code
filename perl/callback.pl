use File::Find;
my $callback;
{
my $count = 0;
$callback = sub { print ++$count, ": $File::Find::name\n" };
}
find($callback, '.');
