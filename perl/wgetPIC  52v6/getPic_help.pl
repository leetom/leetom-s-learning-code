#!/usr/bin/perl

use 5.010;
use File::Basename;

$urlproperty = "src";
$filetype = "";
$minsize = 20000;
while($option = shift @ARGV){
	#if ($option =~ /cookies=/){
	#	$cookie = "--load-cookies=$'";
	#}elsif($option =~ /url=/){
	#	$url = "$'";
	#}
	@option = split "=", $option, 2;
	if ($option[0] eq "cookie"){
		$cookie = "--load-cookies='../${option[1]}'";
	}elsif($option[0] eq "url"){
		$url = $option[1];
	}elsif($option[0] eq "property"){
		$urlproperty = $option[1];
	}elsif($option[0] eq "type"){
		$filetype = $option[1];
	}elsif($option[0] eq "minsize"){
		$minsize = int($option[1]);
	}elsif($option[0] eq "help"){
		print <<"EOT";
Get pictures in one page (always html file)
\tUsage:\n
\t\t	cookie=relative/path/to/cookiefile	To specify a cookie file to login with\n
\t\t	url="http://thepage.com/"		The page to get pictures from (Don't foget the slash if there isn't a filename)\n
\t\t	property="src|file"			The property of url, which an img tag contains. Some sites put the url in other properties, then change to src using javascript when the image is ready.\n
\t\t	minsize=10000		The files whose size is s
EOT
exit;
}
}
say "Get file from tag: $urlproperty";

unless(defined $url){
	say "Please input url: ";
	chomp ($url = <>);
}
mkdir("pic$$") or die "Cannot create dir $url: $!";
chdir("pic$$");
say "Begin wget html:";
say "With cookie:$cookie" if defined $cookie;
my $wget = `wget $cookie  $url`;
say "End wget html;";
@files = glob "*";	#get the new page file, html or sth else
foreach $file (@files){
	next if $file eq "." or $file eq "..";
	open URLFILE, $file;
	while(<URLFILE>){
		if(/<img[^>]*(?:$urlproperty)=["']?((.*?)\.($filetype))[&"'>]/){
			$picurl = $1;
			if ($picurl !~ /^http/){
				$picurl =~ s/^(\.\/)//;
				$dirnm = $url =~ /^http.*\/$/ ? $url:(dirname($url) . "/");
				#say "Debug: dir:$dirnm, picurl:$picurl, url:$url"; 
				$picurl = $dirnm . $picurl;
			}
			next if $allfiles{"$picurl"};
			say "Start getting $picurl";
			system("wget $cookie $picurl" . '>/dev/null') or warn "Fail: $!";
			$allfiles{"$picurl"} = 1;
			$fnm = basename $picurl;
			say "Get $picurl success" if -f $fnm;
			if (-f _ && -s _ < $minsize){
				say "Delete: $fnm is too small";
				unlink $fnm or warn "Cannot remove $fnm: $!";
			}
		}
	}
}
chdir("..");
rename "pic$$", "PicturesAt" . localtime;


