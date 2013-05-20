#!/usr/bin/env perl
#
use 5.012;
use Stu;
for( keys %Stu::){
	say "name: ", $_, " value: " , $Stu::{$_};
}
say "Stu::id: " . $Stu::id;
say "Stu::sex: " . $Stu::sex;
say "call get_id: " . Stu::get_id;
say "call get_sex: " . Stu::get_sex;

BEGIN { say "begain of test file."};
