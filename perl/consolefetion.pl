#!/usr/bin/perl -w

use strict;
use warnings;
use 5.010;
use utf8;
use LWP::UserAgent;
use Data::Dumper;
$Data::Dumper::Indent = 2;
use URI::Escape;
use JSON::XS;
use attributes();
use HTML::TreeBuilder;
use HTML::Entities;
use File::Basename;
use Term::ReadKey;
#use Win32::Console::ANSI;#windows系统需要添加使用此模块，Term::ANSIColor模块才能正常工作	
use Term::ANSIColor;
use POSIX qw(strftime);


#settings
$|++;
my $debug = 1;
my $log = 0;

my $base_url = 'http://f.10086.cn';
my $uris = {
	login => '/im5/login/loginHtml5.action',
	getuid => '/im5/index/searchFriendsByQueryKey.action',
	sendmsg => '/im5/chat/sendNewMsg.action',
	sendtomyself => '/im5/user/sendMsgToMyselfs.action',
	logout => '/im5/index/logoutsubmit.action',
	checkunread => '/im5/chat/queryUnreadMsgTotal.action?fromUrl=unread',
	msglist => '/im5/box/msgList.action',
	newmsg => '/im5/chat/queryNewMsg.action?fromUrl=chat&touserid=',
	recentmsg => '/im5/chat/queryRecentMsg.action?touserid=',
	getfriends => '/im5/index/queryFriends.action?fromUrl=main&from=2',
	setloginstatus => '/im5/index/setLoginStatus.action' # ?loginstatus=0(隐身), 600（忙碌）400（在线）100（离开）
};
my @online_status = (400, 0, 600, 100);

#Global vars 
my $login_flag = 0;

my $contact_list=[];
my $session = []; #对话，hash引用数组
my $search_pattern = {}; #搜索联系人使用的信息，若已经搜索过，则直接从$session中查找
my $session_msg = {};#对话的消息内容 {userid=>[{message},{msg}]}
my $reply_session = 0; #上一条对话，按R回复到此联系人
my $send_success = '消息发送成功';
utf8::encode($send_success);

open FLOG, ">>:encoding(utf-8)", "./feixin.log";
binmode STDIN, ':utf8'; 
binmode STDOUT, ':utf8'; 
#binmode FLOG, ':utf8';

my ($rdfd, $wrfd);
pipe($rdfd, $wrfd);	#管道传送新消息
$rdfd->autoflush(1);
$wrfd->autoflush(1);
my $check_proc;
my $main_proc;

$SIG{"USR1"} = \&show_new_msg;	#自定义signal，子进程通过管道发送过来数据时同时发送信号

#loginstatus: online=>400, 隐身=>0
	
	

my $uaopt = {agent=>"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.75 Safari/535.7", cookie_jar=>{'loginstatusCookie'=>0}};
my $ua = LWP::UserAgent->new(%$uaopt);
$main_proc = $$;

sub logging{
	my ($str) = @_;
	print FLOG localtime() . "\n" . $str if $debug;	
}

sub show_welcome{
	say "ConsoleFetion v0.1 beta";
	say "\tBy leetom. Powered by Perl";
	say "Press h for help!";
}

sub show_about{
	say "ConsoleFetion 使用3G飞信接口收发消息,协议相关版权归中国移动所有,仅供测试娱乐,误用作其他用途";
	say "...";
}

sub show_help{
	say "s to send message";
	say "q to quit";
	say "r to reply the last msg";
	say "t to set the status";
	say "i to see the info of a contact";
	say "a to see about info";
	say "....";
}

#post method, param $uri, $data
sub post{	
	my ($uri, $data) = @_;	#url -> string, data -> hash ref or array ref
	
	my $res = $ua->post($base_url . $uri, $data);
	if($res->is_success){
		return $res->content;
	}else{
		&logging($res->status_line);
		&logging($res->content);
	}
	0;
}

sub get{	
	my ($uri) = @_;	#url -> string
	
	my $res = $ua->get($base_url . $uri);
	if($res->is_success){
		return $res->content;
	}else{
		&logging($res->status_line);
		&logging($res->content);
	}
}

sub login{
	my ($username) = @_;
	die "Usage: $0 phone_number\n" unless defined $username and $username =~ /\d{11}/;
	print "Input fetion password:";
	ReadMode 2;
	my $password = <STDIN>;
	chomp $password;
	ReadMode 4;
	print "\n";
	say scalar localtime() . "正在登录";
	my $res = &post($uris->{login}, {m=>$username, pass=>uri_escape($password)}, loginstatus=>0);#待添加判断条件
	if ($res =~ /<div class="person">/){
		#获取联系人信息
		say scalar localtime() . "登录成功";
		&show_welcome();#show welcome msg
		my $contact = decode_json(&get($uris->{getfriends}));
		$contact_list = $contact->{contacts};
		#子进程poll新消息，查询到之后发送给父进程
		$check_proc = fork();
		if($check_proc < 0){
			warn("fork failed: $!, 不能检测新消息\n");
		}elsif($check_proc ==0){
			#子进程
			close $rdfd; #关闭读
			while(1){
				&get_unread_num();
				sleep 3;
			}
		}else{
			#父进程
			close $wrfd; #关闭写
		}
	
	}else{
		&logging($res);
		die "登录失败，请检查网络或者用户名密码。\n";
	}
}

sub logout{
	my $res = &get($uris->{logout});
	say "已注销";
}

sub get_contact{
	my ($info) = @_;
	my $res = &post($uris->{getuid}, {queryKey => $info});
	return 0 unless $res;
	my $userinfo;
	eval{ $userinfo = decode_json($res);};
	if($@){
		&c_print('red', "error: $res\n$@\n");
		return 0;
	}
	$userinfo;
}
sub get_uid{
	my $userinfo = &get_contact(@_);
	$userinfo->{contacts}[0]{idContact};
}

sub touid{
	my ($to, $content) = @_;
	my $res = &post($uris->{sendmsg}, {touserid => $to, msg=> $content});
	if ($res =~ /$send_success/){
		1;
	}else{
		print $res;
	}
}

#useless
sub sendto{
	my ($to, $content) = @_;
	my $uid = &get_uid($to);
	&touid($uid, $content);
}

#消息是否已经读过
sub msg_exist{
	my ($from, $id) = @_;
	if(exists $session_msg->{$from}){
		for (@{$session_msg->{$from}}){			
			return 1 if($_->{idMessage} == $id);
		}
	}else{
		$session_msg->{$from} = [];
	}
	0;
}
sub get_session_id{
	my ($uid) = @_;
	for (0 .. $#$session){
		return $_ if($$session[$_]->{idContact} == $uid);
	}
	for (@$contact_list){
		if($_->{idContact} == $uid){
			push @$session, $_;
			return $#$session;
		}
	}
}

#带颜色字符输出，并根据配置是否记录聊天记录
sub c_print{
	my($color, $str, $format) = @_;
	if ($format){
		print color $color;
		printf $format, $str;
		print color 'reset';
	}else{
		print color $color;
		print $str;
		print color 'reset';
	}
	#log if $log_to_file;
}

sub m_print{	#msg print 向终端输出消息
	my ($name, $sid, $d, $msg) = @_;	#名称，session_id, 方向，内容
	my @d = ('To: ', 'From: '); #发送还是收到 0, 1
	decode_entities($msg);
	
	my $now_string = strftime "%H:%M:%S ", localtime;
	&c_print('red', $now_string);
	&c_print('green', $d[$d] . $name, "%12s" );
	&c_print('red', "(" . $sid . ") ");
	&c_print('green', $msg . ' ');
}
sub show_contact_info{
	my ($con) = @_;
	#my $format = "%12s";
	&c_print('red', "备注名:\t");
	&c_print('green', $con->{localName} . "\n");
	&c_print('red', "昵称:\t");
	&c_print('green', $con->{nickname} . "\n");
	&c_print('red', "手机号:\t");
	&c_print('green', $con->{mobileNo} . "\n");
	&c_print('red', "飞信号\t");
	&c_print('green', $con->{idFetion} . "\n");
	&c_print('red', "登录设备:\t");
	&c_print('green', $con->{deviceType} . "\n");
	if($con->{impresaLength} > 0){
		&c_print('red', "心情短语:\t");
		&c_print('green', $con->{impresa} . "\n");
	}
}


#子进程执行
sub get_unread_num{
	my $res = &get($uris->{checkunread});
	my $ret;
	eval { $ret = decode_json($res)};
	if($@){ print $res . "\n" .$@; return;}
	unless ($ret->{unreadTotal} == 0){
		&check_new_msg();
	}
}

sub check_new_msg{
	my $tree_b = HTML::TreeBuilder->new;
	my $res = &get($uris->{msglist});
	utf8::decode($res);
	$tree_b->parse($res);
	$tree_b->eof;
	my @p = $tree_b->find_by_attribute('class', 'user_cont');
	for(@p){
		my @a = $_->look_down('_tag', 'a');
		my $a_href = $a[1]->attr('href');
		#say $a_href;
		&get($a_href);
		$a_href =~ /touserid=(\d+)&/;
		my $uid = $1;
		my $msg;
		$msg = &get($uris->{recentmsg} . $uid .  "&_=" . time());
		say $wrfd $msg;
		kill 10, $main_proc;
		sleep 1;
		$msg = &get($uris->{newmsg} . $uid . "&_=" . time());
		say $wrfd $msg;
		kill 10, $main_proc;
	}
}

#父进程从管道中读消息
sub show_new_msg{
	my $msg = <$rdfd>;
	#my $msg;
	#sysread $rdfd, $msg, 10000;
	$msg = decode_json($msg);
	logging Dumper($msg) if $debug;
	my ($fid, $d);
	if(exists $$msg[0]){	#checknewmsg 有时候返回的是空数组
		for (@$msg){
			if($_->{messageType} eq '1'){
				next;
				#$d = 0;
				#$fid = $_->{toIdUser};	#若为1,则为发送的消息
			}else{
				$d = 1;
				$fid = $_->{fromIdUser};
			}
			if ( not &msg_exist($fid, $_->{idMessage})){
				push @{$session_msg->{$fid}}, $_;
				my $sid = &get_session_id($fid);
				my $user = $$session[$sid];
				#print Dumper($_, $sid, $user);
				&m_print($user->{localName}, $sid, $d, $_->{message});
				$_->{sendTime} =~ /(\d{2})(\d{2})/;
				&c_print('red', ' at ' . $1 . ":" . $2);
				print "\n";
			}
		}
		$reply_session = $fid;
	}
}
	

#按键事件监听函数
sub s_pressed{
	print "Input \@id msg or contact_info msg to send\n>>";
	ReadMode 1;
	my $msg = <STDIN>;
	chomp $msg;
	if($msg){
		if($msg =~ /^@/){
			my @content = split /\s/, $msg, 2;
			my $sid = $content[0];
			$sid =~ s/^@//;
			if(defined $session->[$sid] and $content[1]){
				&m_print($session->[$sid]{localName}, $sid, 0, $content[1]);
				
				my $return_info = &touid($session->[$sid]{idContact}, $content[1]);
				if($return_info == 1){
					&c_print('red', 'success');
				}else{
					&c_print('red', 'failed');
				}
				print "\n";
			}else{
				&c_print('red', '不存在此编号会话');
				print "\n";
			}
		}else{
			my @content = split /\s/, $msg, 2;
			my $info = $content[0];
			my $sid;
			
			if(exists $search_pattern->{$info}){
				$sid = $search_pattern->{$info};
			}else{
				my $contact = &get_contact($info);
				if(not $contact){
					&c_print('red', "未找到符合条件的联系人\n");
					ReadMode 4;
					return;
				}elsif($contact->{total} > 1){
					&c_print('red', "联系人信息不合适，找到多个符合条件的联系人\n");
					for (@{$contact->{contacts}}){
						&c_print('green', $_->{localName} . " ");
					}
					print "\n";
					ReadMode 4;
					return;
				}else{
					push @$session, $contact->{contacts}[0];
					$sid = $#$session;
					$search_pattern->{$info} = $sid;
				}
			}
			&m_print($session->[$sid]{localName}, $sid, 0, $content[1]);
			&c_print('red', 'send? [y/n] y ');
			my $choice = <STDIN>;
			chomp $choice;
			if($choice eq 'y' or $choice eq ''){
				my $return_info = &touid($session->[$sid]{idContact}, $content[1]);
				if($return_info == 1){
					&c_print('red', 'success');
				}else{
					&c_print('red', 'failed');
				}
				print "\n";
			}else{
				say "aborted.";
			}
		}#</@id msg else info msg>
	}#</if($msg)>
	ReadMode 4;
} #</s_pressed>
sub h_pressed{
	&show_help();
}

sub r_pressed{
	if($reply_session == 0){
		say "没有联系人可回复";
		return;
	}

	my $uid = $reply_session;
	for(@$session){
		if($_->{idContact} == $uid){
			print "Reply to " . $_->{localName} . ". Input Message:";
			last;
		}
	}
	ReadMode 1;	
	my $content = <STDIN>;
	chomp $content;
	my $return_info = &touid($uid, $content);
	if($return_info == 1){
		&c_print('red', 'success');
	}else{
		&c_print('red', 'failed');
	}
	print "\n";
	ReadMode 4;
}

sub t_pressed{
	ReadMode 1;
	print "状态设置为(0=>在线，1=>隐身,2=>忙碌,3=>离开)：";
	my $status = <STDIN>;
	chomp $status;
	if($status =~ /^[0-3]$/){
		&c_print('red', "设置成功\n") if &get($uris->{setloginstatus} . '?loginstatus=' . $online_status[$status]) =~ /success/;
	}else{
		&c_print('red', "输入错误\n");
	}
	ReadMode 4;
}

sub i_pressed{
	ReadMode 1;
	print "获得联系人信息:\@id<ENTER> or contact_info<ENTER>\n";
	my $contact = <STDIN>;
	chomp $contact;
	if($contact =~ /^@(\d+)$/){
		if($session->[$1]){
			#print Dumper($session->[$1]);
			&show_contact_info($session->[$1]);
		}else{
			&c_print('red', "联系人id不存在\n");
		}
	}else{
		if(exists($search_pattern->{$contact})){
			&show_contact_info($session->[$search_pattern->{$contact}]);
		}else{
			#print Dumper($search_pattern);
			my $con = &get_contact($contact);
			if(not $con){
				&c_print('red', "未找到符合条件的联系人\n");
				ReadMode 4;
				return;
			}elsif($con->{total} > 1){
				&c_print('red', "联系人信息不合适，找到多个符合条件的联系人\n");
				for (@{$con->{contacts}}){
					&c_print('green', $_->{localName} . " ");
				}
				print "\n";
				ReadMode 4;
				return;
			}else{
				push @$session, $con->{contacts}[0];
				my $sid = $#$session;
				$search_pattern->{$contact} = $sid;
				&c_print('red', "联系人\@${sid}加入会话\n");
				&show_contact_info($con->{contacts}[0]);
			}
		}
	}
	ReadMode 4;
}


sub q_pressed{
	ReadMode 1;
	&logout();
	&logging(Dumper($session, $session_msg)) if $debug;
	exit();
}

END{
	ReadMode 1;
	kill 9, $check_proc if defined $check_proc;
	say "Quit.";
}

&login(@ARGV);


#my $count =1; #what's this?
while(1){
	my $key;
	while (not defined ($key = ReadKey(-1))) {
		#&show_new_msg();
		#say "next readkey";
		sleep 1;
	}

	given($key){
		when(/^[aA]$/){ &show_about();}
		when(/^[sS]$/){ &s_pressed();}
		when(/^[rR]$/){ &r_pressed();}
		when(/^[hH]$/){ &h_pressed();}
		when(/^[tT]$/){ &t_pressed();}
		when(/^[iI]$/){ &i_pressed();}
		when(/[qQ]/) {&q_pressed();}
	}
}

