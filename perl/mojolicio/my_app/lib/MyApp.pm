package MyApp;
use Mojo::Base 'Mojolicious';
use lib '../';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Import plugins
  # $self->plugin('DebugHelper');

  # Router
  my $r = $self->routes;

  #helpers
  $self->helper( debug => sub{
          my ($self, $str) = @_;
          $self->app->log->debug($str);
      }
  );


  # Normal route to controller
  
  $r->get('/hello')->to('blog#hello');
  $r->get('/static')->to('blog#static');
  $r->get('/blog/init')->to('blog#init');

  $r->get('/article/add')->to('blog#add');
  $r->post('/article/add')->to('blog#save');

  $r->get('/article/list')->to('blog#list');

  $r->get('/article/:id')->to('blog#article');

 #$r->get('/')->to('example#welcome');
}

1;
