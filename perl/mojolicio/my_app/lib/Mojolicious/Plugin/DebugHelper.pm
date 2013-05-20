package Mojolicious::Plugin::DebugHelper;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

sub register {
  my ($self, $app) = @_;

  $app->helper(pdebug => sub{
          my ($self, $str) = @_;
          $self->app->log->debug("debug plugin: " . $str . "!");
  });
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::DebugHelper - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('DebugHelper');

  # Mojolicious::Lite
  plugin 'DebugHelper';

=head1 DESCRIPTION

L<Mojolicious::Plugin::DebugHelper> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::DebugHelper> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
