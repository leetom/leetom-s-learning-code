use Mojolicious::Lite;

#/ 

get '/' => sub{
	my $self = shift;
	$self->render;
} => 'index';


# /hello
get '/hello';

get '/hello' => sub{
	my $self = shift;
	$self->render(text => 'hello!');
};

get '/:foo' => sub{
	my $self = shift;
	my $foo = $self->param('foo');

	$self->res->headers->header("X-bender" => 'Suck my dick!');

	$self->render(text => "Hello from $foo\n");
};


app->start;

__DATA__

@@ index.html.ep
<%= link_to Hello => 'hello' %>.
<%= link_to Reload => 'index' %>.

@@ hello.html.ep
Hello world!
