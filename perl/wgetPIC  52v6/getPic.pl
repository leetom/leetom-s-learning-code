#!/usr/bin/perl

use 5.010;
use File::Basename;


#tag, 其实应该是property的，有些网站(discuz)把img的图片放在其他属性中（如file),等图片加载完之后，通过js将src属性改为原始地址以显示出来

$urltag = "src|file";
$filetype = "";
$removed = 0;
$minsize = 20000;
while($option = shift @ARGV){
	#if ($option =~ /cookies=/){
	#	$cookie = "--load-cookies=$'";
	#}elsif($option =~ /url=/){
	#	$url = "$'";
	#}
	@option = split "=", $option, 2;
	if ($option[0] eq "cookie"){
		if( -f $option[1]){
			$cookie = "--load-cookies='../${option[1]}'";
		}else{
			$cookie = "--load-cookies='../cookies.txt'";
		}
	}elsif($option[0] eq "url"){
		$url = $option[1];
	}elsif($option[0] eq "tag"){
		$urltag = $option[1];
	}elsif($option[0] eq "type"){
		$filetype = $option[1];
	}elsif($option[0] eq "minsize"){
		$minsize = int($option[1]);
	}
}
say "Get files from tag: $urltag";
say "With cookie:$cookie" if defined $cookie;
unless(defined $url){
	say "input url ";
	chomp ($url = <>);
}
mkdir("pic$$") or die "Cannot create dir $url: $!";
chdir("pic$$");
say "Begin wget html:";
my $wget = `wget -q $cookie  $url`;
say "End wget html;";
@files = glob "*";	#get the new page file, html or sth else
foreach $file (@files){
	next if $file eq "." or $file eq "..";
	open URLFILE, $file;
	while(<URLFILE>){
		if(/<img[^>]*(?:$urltag)=["']?((.*?)($filetype))[&"'>]/){
			$picurl = $1;
			if ($picurl !~ /^http/){
				$picurl =~ s/^(\.\/)//;
				$dirnm = $url =~ /^http.*\/$/ ? $url:(dirname($url) . "/");
				#say "Debug: dir:$dirnm, picurl:$picurl, url:$url"; 
				$picurl = $dirnm . $picurl;
			}
			if ($allfiles{"$picurl"}){
				say "Reduplicate: $picurl have been tried";
				next;
			}
			say "Get: $picurl";
			system("wget -q $cookie $picurl");
			$allfiles{"$picurl"} = 1;
			$fnm = basename $picurl;
			say "Success: $picurl" if -f $fnm;
			if (-f _ && -s _ < $minsize){
				say "Delete: $fnm is too small";
				unlink $fnm or warn "Cannot remove $fnm: $!";
				$removed++;
			}
		}
	}
}
chdir("..");
rename "pic$$", "PicturesAt" . localtime;
$filenum = keys %allfiles;
say "Finished: get $filenum files, $removed files are removed for being too small";


