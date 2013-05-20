#!/usr/bin/env perl

use 5.012;
use LWP::UserAgent;

my $ua = LWP::UserAgent->new;
my ($res);
my $user = {
	email => 'leetom1991@163.com',
	password => '6d5963396fc45e455fc8c41c2bf2072cfd38f075cfa23327a8e6d5e69b10d966',
	rkey => 'd0cf42c2d3d337f9e5d14083f2d52cb2',
	origURL => 'http://www.renren.com/home',
	domain => 'renren.com',
	key_id => 1,
};
my @users_to_view = (
  #252183226,
  268666698, #xiaoguier
);

$ua->cookie_jar({});


sub login{
	$res = $ua->post('http://www.renren.com/ajaxLogin/login', $user);

	if($res->is_success){
		say "Login success!";
		#say $res->content;
		return 1 if  $res->content =~ /true/;
	}
}

sub log{
  my $str = shift;
  my $time = localtime;
  my($logfile);
  open $logfile, '>>', 'renrenlog.log';
  print $logfile $time, "\t", $str, "\n";
  close $logfile;
}

sub view_users{
	my @users = @_;
	for(@users){
		$res = $ua->get('http://www.renren.com/profile.do?portal=homeFootprint&id=' . $_);
		if($res->is_success){
			&log("view $_ success!");
      #say "view $_";
			#say $res->content;
		}else{
			&log("view $_ failed!");
			&log($res->status_line);
		}
	}
}



my @time;
while(1){
  @time = localtime;
  if($time[2] < 23 and $time[2] > 9){

    if(&login){
      &view_users(@users_to_view);
      sleep(1000);
    }
  }

sleep(1000);
}
