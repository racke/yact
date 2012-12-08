package YACT::Conference;

# ABSTRACT: A conference in YACT

use Moo;
use Path::Class;

has yact => (
    is       => 'ro',
    required => 1,
);

has key => (
    is       => 'ro',
    required => 1,
);

has remote => (
    is       => 'ro',
    required => 1,
);

has repository => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

has remote_type => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build_remote_type {'git'}

sub _build_repository {
    my ($self) = @_;
    $self->yact->get_repository( $self->remote, $self->remote_type );
}

1;
