#!/usr/bin/perl

use Student;

use strict;

my $stu = Student->new;
my $stu2 = Student->new;

$stu->set("Name", "leetom");

$stu->("set", "number", "40822053");

$stu->display();

$stu2->set("Name", "Susan");
$stu2->("set", "Name", "Rita");
$stu2->display;
