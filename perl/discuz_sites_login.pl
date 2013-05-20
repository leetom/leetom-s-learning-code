#!/usr/bin/env perl

use 5.012;

use LWP::UserAgent;
use Net::INET6Glue::INET_is_INET6;
use Encode;

my $sites_login_url = {
	'52v6'	=> 'http://www.52v6.com/ptflicker/logging.php?action=login&loginsubmit=yes&floatlogin=yes&inajax=1',
  '6v'    => 'http://bt.neu6.edu.cn/logging.php?action=login&loginsubmit=yes&inajax=1',
	'52v6_2'	=> 'http://www.52v6.com/ptflicker/logging.php?action=login&loginsubmit=yes&floatlogin=yes&inajax=1',
};

my $sites_login_form = {
	'52v6' => {
		loginfield => 'username',
		username => 'leetom',
		password => 'f47524e9bb09c30fefeb0714450f1343',
		loginsubmit => 'true',
	},
  '6v' => {
		loginfield => 'username',
		username => 'leetom',
		password => 'qwerty123',
		loginsubmit => 'true',
	},
  '52v6_2' => {
		loginfield => 'username',
		username => 'leetom1991',
		password => 'f47524e9bb09c30fefeb0714450f1343',
		loginsubmit => 'true',
	},
};
my $sites_view_page={
	'52v6'	=> 'http://www.52v6.com/ptflicker',
  '6v'    => 'http://bt.neu6.edu.cn/',
	'52v6_2'	=> 'http://www.52v6.com/ptflicker',
};

my $ua = LWP::UserAgent->new;
my $res;

sub gbk_to_utf8{
  my $str = shift;
  encode('utf8', decode('gbk', $str));
}

sub hold_on{
  for(keys %$sites_view_page){
    say "reviewing page of $_ "; 
    $ua->cookie_jar({file => "./$_.cookie.txt",});
    $res = $ua->get($sites_view_page->{$_});
    if($res->is_success){
      say "$_ is updated!";
    }else{
      say $res->status_line;
    }

  }
}


for(keys %$sites_login_url){
  say "login to $_";
  $ua->cookie_jar({file => "./$_.cookie.txt",});
  my $username = $sites_login_form->{$_}{username};
  $res = $ua->post($sites_login_url->{$_}, $sites_login_form->{$_});
  if($res->is_success){
    say "login to $_ as $username success!" if $res->content =~ /$username/;
  }else{
    say $res->status_line;
  }
}

#auto view page to stay logged in.
while(1){
  &hold_on;
  sleep 10;
}

sub clear_cookie{
    unlink map "$_.cookie.txt", keys %$sites_view_page;
}

$SIG{INT} = \&clear_cookie;

