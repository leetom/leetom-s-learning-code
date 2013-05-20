while(<>){
  chomp;
  print $_, ' matched!', "\n" if /#/;
}
