#!/usr/bin/perl
#
#
my $scope = "top";
my $f1 =  sub{
  print $scope;
};
&$f1();
my $f2 =  sub{
  my $scope = "f2";
  $f1->();
};

$f2->();
