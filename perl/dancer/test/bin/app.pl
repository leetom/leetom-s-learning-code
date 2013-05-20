#!/usr/bin/env perl
use Dancer;
#use test;
get '/' => sub {
  return "hello world!";
};

dance;
