package YACT::Repository;

# ABSTRACT: A local cloned repository

use Moo;
use Path::Class;
use Git::Repository;

has remote => ( is => 'ro', required => 1, );
has yact   => ( is => 'ro', required => 1, );

# SO FAR ONLY GIT
has type => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        'git';
    }
);

has _cachedir => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my ($self) = @_;
        my $cachedir = $self->remote;
        $cachedir =~ s/[^\w]/_/g;
        my $dir =
            dir( $self->yact->root, 'repos', $self->type, $cachedir )
            ->absolute;
        return $dir;
    }
);

sub _git {
    my ($self) = @_;
    Git::Repository->run( 'clone', $self->remote,
        $self->_cachedir->stringify )
        unless -d $self->_cachedir;
    Git::Repository->new( work_tree => $self->_cachedir );
}

sub get_file {
    my ($self) = @_;
    $self->_git;
    return file( shift->_cachedir, @_ );
}

sub BUILD {
    my ($self) = @_;
}

sub update {
    my ($self) = @_;
    $self->_git->run( pull => "origin", "master", { quiet => 1 } )
        if $self->type eq 'git';
}

1;
