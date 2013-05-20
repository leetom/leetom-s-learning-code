#!/usr/bin/env	perl
#
use 5.010;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1");

my $req = HTTP::Request->new(GET =>
	'http://www.52v6.com/ptflicker/attachment.php?aid=372803&k=c65ced9ced239a4143487ec8856ec3dd&t=1308127883&noupdate=yes&sid=aff6PKYgKvFyBrypjygAI24n6kwidDkzijwVMJCwAvQBDaM');

my $res = $ua->request($req);

if($res->is_success){
	say "Get file success";
	open PIC, ">newfile";
	print PIC $res->content;
	say "Save file sucess";
}else{
	say $res->status_line;
}
