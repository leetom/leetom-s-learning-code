#!/usr/bin/perl -w
#
use strict;
use DBI;
use Data::Dumper;

my $driver = 'DBI:mysql';
my $db = 'test';
my $user = 'root';
my $pswd = '';
my $host = 'localhost';
#insert mysql_socket option
my $dbi =
DBI->connect("$driver:database=$db;host=$host;user=$user;mysql_socket=/opt/lampp/var/mysql/mysql.sock")
		or die "Cannot connect to mysql: " . DBI->errstr;

print $dbi->do("insert into `test`.`test` values('', 'hello', 'pswd')");

my $res = $dbi->prepare("select * from test where 1 limit 30");

$res->execute();
Dumper($res);


