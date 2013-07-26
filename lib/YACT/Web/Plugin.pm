package YACT::Web::Plugin;
# ABSTRACT: Yeb Plugin for YACT

use Moo;
use YACT;

has app => ( is => 'ro', required => 1 );

has yact => ( is => 'ro', lazy => 1, builder => sub { YACT->new } );

sub BUILD {
  my ( $self ) = @_;
  $self->app->register_function('ya',sub {
    $self->yact;
  });
}

1;