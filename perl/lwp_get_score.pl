#!/usr/bin/perl 
#
use 5.010;
use utf8;
use LWP::UserAgent;
use Encode;
use HTTP::Cookies;

$| = 1;

#binmode(STDIN, ':encoding(utf8)');
#binmode(STDOUT, ':encoding(utf8)');
#binmode(STDERR, ':encoding(utf8)');

open LOG, ">>", "log.log";
my $cookie = HTTP::Cookies->new(
		file=>"./lwp_cookie.txt",
		autosave=>1
	);
my $ua = LWP::UserAgent->new(
	agent=>"Mozilla/1.0",
	cookie_jar=>$cookie,
	timeout=>300);


my $res = $ua->post("http://teach.ustb.edu.cn/tmpser/jwgl/Login",
	Content=>{
		username=>40822053,
		password=>408220531991,
		usertype=>student
	});
if($res->code == 302){
	while(1){
		$score = $ua->post("http://teach.ustb.edu.cn/tmpser/jwgl/score.jsp",
			Content=>{
				XNXQ=>"all"
			});
		if($score->is_success){
			my $content = Encode::decode("GBK", $score->content);
			#print $content;
			#Encode::_utf8_on($content);
			my @word = ($content =~ /(实习)/g);
			if($#word + 1 > 1){
				open SCORE, ">", "./score.log";
				print SCORE @word;
				`zenity --info --text "实习分数出来了"`;
				close SCORE;
			}else{
				print LOG scalar localtime, "try once, $#word \n";
			}
		}else{
			print LOG "An error occured: $score->status_line";
		}
		sleep 60;
	}

}else{
	die "An error occured: $res->content\n";
}
