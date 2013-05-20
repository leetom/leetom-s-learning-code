use Mojolicious::Lite;

get '/' => {text => 'hello world!'};

app->start;
