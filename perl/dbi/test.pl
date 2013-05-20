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

#my $sth = $dbh->prepare("SELECT SQLITE_VERSION()");
my $sth = $dbh->prepare("SELECT * from article ORDER BY id");

$sth->execute();

while(my $ver = $sth->fetch()){

    for my $row (@$ver){
        print "$row";
    }
    print "\n";
}


#print Dumper($ver);
$sth->finish();
$dbh->disconnect();

