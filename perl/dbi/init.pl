
#!/usr/bin/perl
#
use DBI;

$dbh = DBI->connect(
    "dbi:SQLite:dbname=testdb.sqlite3",
    "",
    "",
    { RaiseError => 1},
) or die $DBI::errstr;

$dbh->do("INSERT INTO article VALUES(1, 'First Article', 'leetom', 'This is my first content!<h1>haha</h1>')");
$dbh->do("INSERT INTO article VALUES(2, 'Second Article', 'leetom', 'This is my second content!<h1>good</h1>')");
$dbh->do("INSERT INTO article VALUES(3, 'Third Article', 'leetom', 'This is my third content!<h1>well</h1>')");


