#!/usr/bin/perl
#
# Open Fetion Perl Version
#modify huangzhibin(jabincn@hotmail.com) 2010-01-12
#QQ 184990379

print  "USAGE: <this_script> <your_mobile_number> <password> <target_number> <message to send> \n";
print "<target_number> eg:13800138000,123456,1382362200(mobile-no or fetion-number) \n";
#
#
use Digest::MD5 qw(md5 md5_hex);
use Socket;
use Time::HiRes qw(usleep time);
use LWP::UserAgent;
use HTTP::Request::Common;
use IO::Socket::SSL;
use LWP::Simple;
use URI::Escape;
use Net::SSLeay;

# Global Config
my $FETION_USER_AGENT    = "IIC2.0/PC 2.3.0230";
my $FETION_DOMAIN_URL    = "fetion.com.cn";
my $FETION_CONFIG_URL    = "https://nav.fetion.com.cn/nav/getsystemconfig.aspx";
my $FETION_CONF_REQUEST  = "<config><user mobile-no=\"%s\" /><client type=\"PC\" version=\"2.3.0230\" platform=\"W5.1\" /><servers version=\"0\" /><service-no version=\"12\" /><parameters version=\"15\" /><hints version=\"13\" /><http-applications version=\"14\" /><client-config version=\"17\" /></config>";
my $FETION_SSIAPP_POST   = "?mobileno=%s&pwd=%s";
my $FETION_SIPC_LOGIN_P1 = "<args><device type=\"PC\" version=\"6\" client-version=\"2.3.0230\" /><caps value=\"simple-im;im-session;temp-group\" /><events value=\"contact;permission;system-message\" /><user-info attributes=\"all\" /><presence><basic value=\"400\" desc=\"\" /></presence></args>";
my $FETION_SIPC_LOGIN_R1 = "R %s SIP-C/2.0\r\nF: %s\r\nI: 1\r\nQ: 1 R\r\nL: %s\r\n\r\n";
my $FETION_SIPC_LOGIN_P2 = "<args><device type=\"PC\" version=\"6\" client-version=\"2.3.0230\" /><caps value=\"simple-im;im-session;temp-group\" /><events value=\"contact;permission;system-message\" /><user-info attributes=\"all\" /><presence><basic value=\"400\" desc=\"\" /></presence></args>";
my $FETION_SIPC_LOGIN_R2 = "R %s SIP-C/2.0\r\nF: %s\r\nI: 1\r\nQ: 2 R\r\nA: Digest response=\"%s\",cnonce=\"%s\"\r\nL: %s\r\n\r\n";

my $FETION_SIPC_SENDSMS  = "M %s SIP-C/2.0\r\nF: %s\r\nI: 2\r\nQ: 1 M\r\nT: %s\r\nN: SendCatSMS\r\nL: %s\r\n\r\n";

my $FETION_SIPC_LOGOUT   = "R %s SIP-C/2.0\r\nF: %s\r\nI: 1 \r\nQ: 3 R\r\nX: 0\r\n\r\n";

#设置心情
my $_SET_STATUS_args = "<args><personal impresa=\"\"/></args>";
my  $_SET_STATUS_L=length($_SET_STATUS_args);
my $SET_STATUS = "S %s SIP-C/2.0\r\nF: %s\r\nI: 47 \r\nQ: 1 S\r\nN: SetPersonalInfo\r\nL: $_SET_STATUS_L\r\n\r\n$_SET_STATUS_args";

my $SET_Presence ="S %s SIP-C/2.0\r\nF: %s \r\nI: 22 \r\nQ: 1 S\r\nN: SetPresence\r\nL: 55\r\n\r\n<args><presence><basic value=\"%s\" /></presence></args>";
#Value:300 离开，600忙碌，隐身0，400在线

#获取可通讯所有好友
my $GET_ALL_USER ="S %s SIP-C/2.0\r\nF: %s \r\nI: 7 \r\nQ: 1 S\r\nN: GetContactPermission\r\nL: 50\r\n\r\n<args><permissions all=\"1\" objects=\"all\" /></args>";

#获取所有好友列表
#my $str="<args><contacts><buddy-lists /><buddies attributes=\"all\" /><mobile-buddies attributes=\"all\" /><chat-friends /><blacklist /></contacts></args>";
#my $_length = length($str);
#my $GET_ALL_USER ="S %s SIP-C/2.0\r\nF: %s \r\nI: 7 \r\nQ: 1 S\r\nN: GetContactList\r\nL: $_length\r\n\r\n$str";

#获取好友的信息
my $GET_USER_INFO_STR ="<args><contacts attributes=\"provisioning;impresa;mobile-no;nickname;name;portrait-crc;ivr-enabled\"><contact uri=\"%s\" /></contacts></args>";
my $GET_USER_INFO ="S %s SIP-C/2.0\r\nF: %s \r\nI: 13 \r\nQ: 1 S\r\nN: GetContactsInfo\r\nL: %s\r\n\r\n$GET_USER_INFO_STR";

# Global Data
my $FETION_SSI_URL       = "https://uid.fetion.com.cn/ssiportal/SSIAppSignIn.aspx";
my $FETION_SIPC_ADDRESS  = "221.176.31.33:8080";

my $g_isverbose  = 0;
my $g_fetion_num = "";
my $g_mobile_num = "";
my $g_passwd     = "";
my $g_cnonce     = "";
my $g_nonce      = "";

#TODO: proxy support not included
#
# Functions
# UNUSED
# Generate GUID String
sub guid
{
  local($randomseed);
  local($hashed_id);

  $randomseed = rand(1000);
  $hashed_id = uc(md5_hex time()."$randomseed");

  $hashed_id = '{'.substr($hashed_id,0,8).'-'
                  .substr($hashed_id,8,4).'-'
                  .substr($hashed_id,12,4).'-'
                  .substr($hashed_id,16,4).'-'
                  .substr($hashed_id,20,12).'}';
}

# Debug Output
sub debug_print
{
  if ( $g_isverbose == 1)
  {
    print @_[0]."\r\n";
  }
}

#############################################################
## HELP FUNCTIONS

# ~~~~~~~~~~~~~~~~~
# SIPC Socket
# ~~~~~~~~~~~~~~~~~

# Init the sipc socket and connect to the target
#
# sipc_connect( addr, port )
sub sipc_connect
{
  local $dest;
  local $exec_ans = -1;
  $dest = sockaddr_in( @_[1], inet_aton( @_[0] ) );
  if ( socket( SIPC_CLIENT, AF_INET, SOCK_STREAM, SOL_TCP))
  {
    setsockopt( SIPC_CLIENT, SOL_SOCKET, SO_SNDTIMEO, pack('LL', 15,0) );
    setsockopt( SIPC_CLIENT, SOL_SOCKET, SO_RCVTIMEO, pack('LL', 15,0) );
    if ( connect( SIPC_CLIENT, $dest ) )
    { 

      $exec_ans = 0;
    }
    else
    {
      close SIPC_CLIENT;

    }
  }
  return $exec_ans;
}

#Close the sipc socket connection
sub sipc_close
{
  close SIPC_CLIENT;
}

#Read data from the sipc socket
#
# RETURN: the data
sub sipc_read
{
  local $read_buffer;
  local $recv_data;
  local $recv_len;
  do 
  {
    $recv_len = sysread(SIPC_CLIENT, $recv_data, 4);

   #print "\n";
	usleep 0.1;
    $read_buffer .= $recv_data;
  }while( index($read_buffer, "\r\n\r\n")== -1 );

  if ( $read_buffer =~ /L: ([0-9]+)/i )
  {
    local $data_len = $1;
    $recv_len = sysread(SIPC_CLIENT, $recv_data, $data_len);
    #TODO: the actually received data length is not verified.
    $read_buffer .= $recv_data;
  }
  return $read_buffer;
}

#Write data to the spic socket
#
#spic_write( data )
# RETURN: length of the data been sent
sub sipc_write
{
  local $sent_size;
  $sent_size = syswrite(SIPC_CLIENT, @_[0], length(@_[0]));

}

#Send sipc request and receive the response
#sipc_request(request_data)
# RETURN: response data
sub sipc_request
{
  &sipc_write( @_[0] );
  #TODO: check whether the write operation works
  
  return &sipc_read();
}

###########################################################
# Fetion Procotol handled here
#Retrieve the config XML of the given fetion account
#
#fetion_get_config(mobile_num)
#RETURN: config xml
sub fetion_get_config
{
  local $request_string;
  local $returndata;

        $request_string = sprintf($FETION_CONF_REQUEST, @_[0]);
        debug_print  "$request_string \n";

        my $userAgent = LWP::UserAgent->new(agent => 'perl post');
        my $response = $userAgent->request(POST $FETION_CONFIG_URL,
                                Content_Type => 'text/xml',
                                Content => $request_string);
        $response->error_as_HTML unless $response->is_success;
        $returndata = $response->as_string;
        return $returndata;
}
#----------------------------------------------------------

#Retrieve the URL to query SIP
#
#fetion_ssiapp_addr( conf_xml )
sub fetion_ssiapp_addr
{
  local $matched_string;
  
  if (  @_[0] =~ /<ssi-app-sign-in>([^<]*)<\/ssi-app-sign-in>/i)
  {
    $matched_string = $1;
  }else
  {
    $matched_string = "";
  }
  return $matched_string;
}

#Retrieve the SIPC login address
#
#fetion_sipc_address( conf_xml )
sub fetion_sipc_address
{
  local $matched_string;
  if (  @_[0] =~ /<sipc-proxy>([^<]*)<\/sipc-proxy>/i)
  {
    $matched_string = $1;
  }else
  {
    $matched_string = "";
  }
  return $matched_string;

}

#Pefrom SSIAPP login action
#fetion_ssiapp_login(  ssi_url, mobile_num, passwd )
# RETURN: login return xml
sub fetion_ssiapp_login
{
  local $request_string;
  local $returndata;

  $request_string = sprintf($FETION_SSIAPP_POST, @_[1], @_[2]);
  my $url = "@_[0]$request_string";
  debug_print "$url \n";
  $returndata = get $url;
  return $returndata;
}
#----------------------------------------------------------

#Get the fetion account number
#fetion_get_account_num ( ssiapp_login_return_xml)
#
sub fetion_get_account_num
{
  local $matched_string =  "";
  if ( @_[0] =~ /<user uri=\"sip:([0-9]+)\@fetion.com.cn;p=[0-9]+\"/i )
  {
    $matched_string = $1;
  }
  return $matched_string;
}

#Generate the disgest info for the secondary SIPC login
sub fetion_sipc_gen_digest
{
  $g_cnonce = uc(md5_hex rand(1000));
  
  local $key = md5("$g_fetion_num:$FETION_DOMAIN_URL:$g_passwd");
  local $h1  = uc(md5_hex( "$key:$g_nonce:$g_cnonce" ));
  local $h2  = uc(md5_hex( "REGISTER:$g_fetion_num"  ));
  local $finalans = uc(md5_hex( "$h1:$g_nonce:$h2" ));
  return $finalans;
}

#Pefrom SIPC login
#fetion_sip_login() 
sub fetion_sipc_login
{
  local $login_request;
  local $login_response;

  if ($g_fetion_num eq "") 
  {
    return -1;
  }

  $login_request = sprintf($FETION_SIPC_LOGIN_R1, $FETION_DOMAIN_URL, $g_fetion_num, length($FETION_SIPC_LOGIN_P1));
  $login_request .= $FETION_SIPC_LOGIN_P1;

  debug_print "Request#1\n".$login_request."\n";

  $login_response = &sipc_request( $login_request );

  debug_print "Response#1\n".$login_response."\n";

  if ( $login_response eq "" )
  {
    return -1;
  }

  if ( $login_response =~ /nonce=\"([^\"]{32})\"/i )
  {
    $g_nonce = $1;  
    debug_print "g_nonce:".$g_nonce."\n";
  }else
  {
    return -2;
  }

  $login_request = sprintf($FETION_SIPC_LOGIN_R2, $FETION_DOMAIN_URL, $g_fetion_num, &fetion_sipc_gen_digest(), $g_cnonce ,length($FETION_SIPC_LOGIN_P2));
  $login_request .= $FETION_SIPC_LOGIN_P2;

  debug_print "Request#2:\n".$login_request."\n";

  $login_response = &sipc_request( $login_request );

  debug_print "Response#2:\n".$login_response."\n";
  if ( $login_response =~ /200 OK/ )
  {
    print "Login OK\n";
    return 0;
  }

  return -1;
}


my %all_uri_hash;
sub Getalluser {

$get_alluser .= sprintf ($GET_ALL_USER,$FETION_DOMAIN_URL,$g_fetion_num);
debug_print "Get ALLuser Request#2:\n".$get_alluser."\r\n";
$getuser_response = &sipc_request( $get_alluser );
debug_print "Get ALLuser Response:\n".$getuser_response."";

my @result = split( 'permission' , $getuser_response ) ;
       foreach my $no4( @result ) {
               #print "---------$no4 \n";
               if ($no4 =~ /(.*)uri=\"(.*)\" values=/sig) {
               my $uri =$2;
	       #print "$uri \n";
		
	       if ( $uri =~ /(.*):([0-9]+)(.*)/i ) {
    	       my $urinumber = $2;
	       debug_print " $urinumber $uri \n";
	       $all_uri_hash{$urinumber} =$uri; 
 	       	 }

		my $user_infodata = &get_user_info($uri);
		if ($user_infodata =~ /<results>(.*)mobile-no=\"([0-9]+)\"(.*)<\/results>/i){
		my $mobile = $2;
		debug_print "$mobile $uri \n";
		$all_uri_hash{$mobile} =$uri;
		}


               }
               }
return 0;
}

sub get_user_info(){
#获取用户信息(手机号......)
if (@_[0] =~ /sip:/sig){
usleep (0.5);
$L = length($GET_USER_INFO_STR) + length(@_[0]) - 2; 
my $get_user_request .= sprintf ($GET_USER_INFO,$FETION_DOMAIN_URL,$g_fetion_num,$L,@_[0]);
debug_print "get_user_request $uri Request#2:\n".$get_user_request."\r\n";
my $get_userinfo_response = &sipc_request( $get_user_request );
debug_print "get_userinfo_response $uri Response:\n".$get_userinfo_response."\r\n";
return $get_userinfo_response;
}
}


sub SET_Presence {
#设置在线
$set_me .=      sprintf($SET_Presence,$FETION_DOMAIN_URL,$g_fetion_num,@_[0]);
debug_print "SET_Presence Request#2:\n".$set_me."\r\n";
$setme_response = &sipc_request( $set_me );
debug_print "SET_Presence Response:\n".$setme_response."\r\n";

return 0;
}


#Send the required text to the specified mobile
#fetion_sendSMS( target_num, text )
#NOTE: always assumes the text is encoded using UTF-8.
sub fetion_sendSMS
{

my $uri_temp = $all_uri_hash{@_[0]};

if (($uri_temp eq "") &&  (@ARGV[0] != @_[0]) ){
        print "Error number @_[0] uri not EXISTS\n";
	print "-" x 50, "\n";
	return 0;
}elsif (@ARGV[0] == @_[0]){
	$uri_temp = "tel:@_[0]";
}

print "@_[0]  $uri_temp \n";

$sms_request =sprintf($FETION_SIPC_SENDSMS,$FETION_DOMAIN_URL, $g_fetion_num, $uri_temp, length(@_[1])); 
$sms_request .= @_[1];
  
  debug_print "SendSMS Request:\n".$sms_request."\n";
  local $sipc_response = &sipc_request($sms_request);
  debug_print "SendSMS Response:\n".$sipc_response."\n";
  
  if ( $sipc_response =~ /Send SMS OK/ )
  {
    print "Send SMS succeed\n";
    print "-" x 50,"\n";
    return 0;
  }
  return -1;

}

#Logout Fetion
#
sub fetion_sipc_logout
{
  
  local $logout_request = sprintf($FETION_SIPC_LOGOUT,$FETION_DOMAIN_URL, $g_fetion_num);
  debug_print "Send Logout Request:\n".$logout_request."\n";
  local $sipc_response = &sipc_request($logout_request);
  debug_print "Logout Response:\n".$sipc_response."\n"; 
}




##################################################
#

sub fetion_verbose
{
  $g_isverbose = 1;

}

# INIT the Fetion Lib
# fetion_init( mobile_num, passwd)
sub fetion_init
{
 $g_mobile_num = @_[0];
 $g_passwd = @_[1];

print "Retrieving the config xml...\n";
$config_xml =&fetion_get_config( $g_mobile_num );
debug_print ("The XML:\n".$config_xml."\n");
  if ($config_xml eq "")
  {
    print "cannot retrieve the config xml... exit\n";
    return -1;
  }


print "Retrieving the SSIAPP URL...\n";
$FETION_SSI_URL = &fetion_ssiapp_addr($config_xml);
debug_print ("The URL: ".$FETION_SSI_URL."\n");
if ($FETION_SSI_URL eq "")
{
    print "cannot get the ssiapp url... exit\n";
    return -1;
}


print "Retrieving the SIPC Address...\n";
$FETION_SIPC_ADDRESS = &fetion_sipc_address($config_xml);
debug_print ("The Address: ".$FETION_SIPC_ADDRESS."\n");
if ($FETION_SIPC_ADDRESS eq "")
{
    print "cannot get the address... exit\n";
    return -1;
}


print "Trying to get the fetion number of the current account...\n";
my $fetion_numdata = &fetion_ssiapp_login($FETION_SSI_URL, $g_mobile_num, $g_passwd);
debug_print "fetion_numdata $fetion_numdata \n";
$g_fetion_num = &fetion_get_account_num($fetion_numdata);
debug_print ("The Fetion Number: ".$g_fetion_num."\n");
if ($g_fetion_num eq "")
{
    print "cannot get the fetion number... exit\n";
    return -1;
}


print "Connecting to the SIPC via TCP socket...\n";
local @addr_info = split(":", $FETION_SIPC_ADDRESS);
if ( &sipc_connect( @addr_info[0], @addr_info[1] ) != 0)
{
    print "Cannot connect to the address:".$FETION_SIPC_ADDRESS."\n";
    &debug_print ("Reason: ".$!."\n");
}
 return 0; 
}


# Release the Fetion Lib
# 
sub fetion_close
{
  &sipc_close;
}
#############################################################################


sub main
{
  if (&fetion_init( @ARGV[0], @ARGV[1] ) != 0)
  {
    return -1;
  }

  if (&fetion_sipc_login() != 0 )
  {
    return -1;
  }

if ( &Getalluser()  != 0 )
        {
        exit
        }

my @result = split( '\,', @ARGV[2] ) ;
foreach my $no4( @result ) {
  usleep(0.5);
  if (&fetion_sendSMS( $no4, @ARGV[3]) != 0)
  	{
    return -1;
  }
}

#if ( &SET_Presence(400) != 0)
#	{
#	exit
#	}

  &fetion_sipc_logout();
  &fetion_close();
  return 0;
}

#fetion_verbose();
&main;
