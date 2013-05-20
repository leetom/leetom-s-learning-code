#!/usr/bin/perl
#
use 5.010;
use LWP::UserAgent;
use HTML::TreeBuilder;
use Data::Dumper;
use utf8;

use DBI;
$dbh=DBI->connect("dbi:SQLite:dbname=./renrenwall","","",{RaiseError=>1,AutoCommit=>0});

my $base_url = 'http://www.renren.com/';
my $uaopt = {agent=>"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7", cookie_jar=>{}};
my $ua = LWP::UserAgent->new(%$uaopt);
my $tree_b = HTML::TreeBuilder->new;


sub login{
	$uri = $base_url . 'PLogin.do';
	my $res = $ua->post($uri, {'email'=>'leetom1991@163.com', 'password'=>'1991n0405'});
	if($res->is_success){
		$res->content;
	}else{
		say $res->status_line;
	}
}
sub get_wall{
	$uri = 'http://w.renren.com/wall/4884';
	my $res = $ua->get($uri);
	utf8::decode($res);
	if($res->is_success){
		$tree_b->parse($res->content);
		$tree_b->eof;
		my @message = $tree_b->find_by_attribute('class', 'messagecontent');
		print Dumper(\@message);
	}else{
		say $res->status_line;
	}
}

print &login();

&get_wall();

