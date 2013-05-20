use Mojo::Template;
use 5.010;

my $mt = Mojo::Template->new;

# Simple
my $output = $mt->render(<<'EOF');
% use Time::Piece;
<!DOCTYPE html>
<html>
<head><title>Simple</title></head>
% my $now = localtime;
<body>Time: <%= $now->hms %></body>
</html>
EOF
say $output;

# More advanced
my $output = $mt->render(<<'EOF', 23, 'foo bar');
% my ($num, $text) = @_;
%= 5 * 5
<!DOCTYPE html>
<html>
<head><title>More advanced</title></head>
<body>
  test 123
  foo <% my $i = $num + 2; %>
  % for (1 .. 23) {
  * some text <%= $i++ %>
  % }

  % for my $go (2 .. 20){
      for loop:<%= $go %>
  % }
</body>
</html>
EOF
say $output;
