use Mojolicious::Lite;
use warnings;
use strict;
use feature 'say', 'state', 'switch';
get('/', {'text', 'Hello World!'});
get('/time', 'clock');
get('/list/:offset', sub {
    my $self = shift();
    my $numbers = [0 .. $self->param('offset')];
    $self->respond_to('json', {'json', $numbers}, 'txt', {'text', join(',', @$numbers)});
}
);
post('/title', sub {
    my $self = shift();
    my $url = $self->param('url') || 'http://mojolicio.us';
    $self->render_text($self->ua->get($url)->res->dom->html->head->title->text);
}
);
websocket('/echo', sub {
    my $self = shift();
    $self->on('message', sub {
        my($self, $msg) = @_;
        $self->send("echo: $msg");
    }
    );
}
);
app()->start;
__DATA__

@@ clock.html.ep
% use Time::Piece;
% my $now = localtime;
The time is <%= $now->hms %>.

