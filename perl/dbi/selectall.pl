

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

my $articles = $dbh->selectall_arrayref($sth, {Slice => {}});

#my $articles = $dbh->selectall_arrayref("SELECT * FROM article;", {Slice => {}});

print Dumper($articles);

