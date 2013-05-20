#!/usr/bin/perl
#
use YAML;
open $fh, '</etc/passwd';

Test::show($fh);

print Dump($fh);
package Test;
use YAML;

sub show{
  my $fh = shift;
  print Dump($fh);
  while(<$fh>){
    print;
  }
}
