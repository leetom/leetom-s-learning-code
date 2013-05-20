
#!/usr/bin/perl
#
use DBI;

use Data::Dumper;

$dbh = DBI->connect(
    "dbi:SQLite:dbname=testdb.sqlite3",
    "",
    "",
    { RaiseError => 1},
) or die $DBI::errstr;

my $sth = $dbh->prepare("SELECT * from article ORDER BY id");

$sth->execute();

#my $articles = $sth->fetchall_hashref('id');
#my $articles = $sth->fetchall_hashref();

my $articles = $sth->fetchall_arrayref({});

print Dumper($articles);

