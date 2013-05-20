#!/usr/bin/env perl
#
use 5.010;

use DBI;
$dbh=DBI->connect("dbi:SQLite:dbname=./info.db","","",{RaiseError=>1,AutoCommit=>0});
# 在perl中，sqlite建表
my $sql = "create table ip (id int null, name int null)";
$dbh->do( $sql);
# 使用perl来更新sqlite的表内容
my $sql = "alter table ip add column age varchar(1024) null";
$dbh->do( $sql);
# 插入数据
my $sql = "insert into name values( 1, 2, 'myname')";
$dbh->do( $sql );
if ( $dbh->err() ) {
die "$DBI::errstr\n";
}
$dbh->commit();
# 查询数据
$sql = "select * from ip";
my $dbconn = $dbh->prepare($sql);
$dbconn->execute();
while ( my @row_ary = $dbconn->fetchrow_array ){
my ($cc,$bb,$dd) = @row_ary;
}
$dbh->disconnect();
