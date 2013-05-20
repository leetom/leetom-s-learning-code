#!/usr/bin/env perl
package Stu;
use strict;

my $id; 
local $Stu::sex;
$id = 40822053;
$Stu::sex = "male";

sub get_id{
	my $local_value_my__in_getid = "my";
	return $id;
}

sub get_sex{
	local $Stu::local_value_in_getsex = 'local';
	return $Stu::sex;
}
1;
