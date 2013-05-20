package MyApp::Blog;
use Mojo::Base 'Mojolicious::Controller';

use Data::Dumper;

use DBI;


our $DBH = DBI->connect(
    "dbi:SQLite:dbname=script/testdb.sqlite3",
    '',
    '',
    { RaiseError => 1},
) or die $DBI::errstr;

# This action will render a template
sub hello {
  my $self = shift;

  # return $self->render_not_found;
  # return $self->render_exception;

  # load plugin in controller
  $self->app->plugin('DebugHelper');

  # custom response 
  # $self->res->headers->content_type('text/plain');
  # $self->res->content->asset(Mojo::Asset::File->new(path => '/etc/passwd'));

  $self->respond_to(
      json => {json => {hello => 'world!', array => [qw/a b c/]}},
      xml => {text => '<hello>world!</hello>'},
      text => {text => 'hello world!'},
      html => sub{
          #$self->debug('/hello !');
          $self->pdebug('/hello is visited!');
          $self->render(
              message => 'hello, html!',
          );
      },
  );

}

sub static{
    my $self = shift;
    # $self->res->headers->content_disposition('attachment; filename=test.jpg;');
    $self->render_static('img/test.jpg');
}

sub init {
    my $self = shift;
    $DBH->do("CREATE TABLE article(id INT PRIMARY KEY, title TEXT, author TEXT, content TEXT)");
    $DBH->do("INSERT INTO article VALUES(null, 'First Article', 'leetom', 'This is my first content!<h1>haha</h1>')");
    $DBH->do("INSERT INTO article VALUES(null, 'Second Article', 'leetom', 'This is my second content!<h1>good</h1>')");
    $DBH->do("INSERT INTO article VALUES(null, 'Third Article', 'leetom', 'This is my third content!<h1>well</h1>')");

    $self->render();
}

our %view;

sub count_gen{
    my $self = shift;
    my $id = shift;
    return sub{
        ++$view{$id};
    }
}

sub article{
    my $self = shift;
    my $id = $self->param('id');

    my $sth = $DBH->prepare('SELECT * FROM article WHERE id = ?');
    $sth->execute($id);

    my $ret = $sth->fetchrow_hashref();



    my $count = $self->count_gen($id); 


    $self->render(
         id => $id,
         view => $count->(),
         title => $ret->{title},
         author => $ret->{author},
         content => $ret->{content},
    );

}

sub list{
    my $self = shift;

    my $per_page = 20;
    my $sth = $DBH->prepare('SELECT * FROM article LIMIT ?');
    $sth->execute($per_page);
    my $articles = $sth->fetchall_arrayref({});

    $self->render(
        articles => $articles
    );

}

sub add{
    my $self = shift;
    $self->render();

}


# post to /article/add to save 
sub save{
    my $self = shift;

    my $title = $self->param('title');
    my $author = $self->param('author');
    my $content = $self->param('content');

    my $sth = $DBH->prepare("INSERT INTO article VALUES(null, ?, ?, ?)");

    $sth->execute($title, $author, $content);

    $self->render_text("done!");

}


1;
