package YACT::Repository;

# ABSTRACT: A local cloned repository

use Moo;
use Path::Class;
use Git::Raw::Repository;

# SO FAR ONLY GIT
has type => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build_type {'git'}

has remote => (
    is       => 'ro',
    required => 1,
);

has yact => (
    is       => 'ro',
    required => 1,
);

has _cachedir => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build__cachedir {
    my ($self) = @_;
    my $cachedir = $self->remote;
    $cachedir =~ s/[^\w]/_/g;
    my $dir =
        dir( $self->yact->root, 'repos', $self->type, $cachedir )->absolute;
    return $dir;
}

sub _git {
    my ($self) = @_;
    return Git::Raw::Repository->clone( $self->remote, $self->_cachedir,
        { "update_missing" => 1 }, 0 );
}

1;
