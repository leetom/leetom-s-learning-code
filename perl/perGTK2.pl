#!/usr/bin/perl -w
# helloworld.pl --- Test the gtk2-perl whether works
use Gtk2 '-init';
use Glib qw(TRUE FALSE);
use Encode qw(decode);
my $window = Gtk2::Window->new('toplevel');
$window->set_title('Hello World!');
$window->set_position('center_always');
$window->set_size_request(300, 200);
$window->signal_connect('delete_event' => sub { Gtk2->main_quit; });
my $label = Gtk2::Label->new(decode('utf8', '你好！'));
$window->add($label);
$button_win = Gtk2::Window->new;
my $button = Gtk2::Button->new(decode('utf8', 'click!'));
$window->add($button);
$window->show_all();
Gtk2->main;
