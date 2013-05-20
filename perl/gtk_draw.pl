#!/usr/bin/perl 

use  Gtk2 "-init"; 

#$file="$ENV{HOME}/tt.jpg"; 
$file = "./tt.jpg";

Gtk2->init; 
$screen=Gtk2::Gdk::Screen->get_default; 
$window=$screen->get_root_window; 
#$screen->broadcast_client_message(Gtk2::Gdk::Event->new("expose")); 
#$window->signal_connect('expose_event', \&expose, $window); 

$gc = Gtk2::Gdk::GC->new ($window, undef); 
($real_drawable,$x_offset,$y_offset)=$window->get_internal_paint_info; 
expose(); 
#Gtk2->main_iteration while Gtk2->events_pending; 
Gtk2->main(); 
#Gtk2->main_iteration; 

sub expose { 
$pixbuf=Gtk2::Gdk::Pixbuf->new_from_file($file); 
($format,$width,$height)=$pixbuf->get_file_info($file); 
$pixbuf->render_to_drawable($real_drawable,$gc,0,0,100,100,$width,$height,'normal',0,0); 
} 
