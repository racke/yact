package YACT;

# ABSTRACT: Yet Another Conference Toolkit

use Moo;
use YACT::Config;
use YACT::DB;

sub BUILD { }

has config => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
    handles => [
        qw(
            root
            )
    ],
);

sub _build_config { YACT::Config->new }

sub init {
    my ($self) = @_;
    unless ( -d $self->config->root ) {
        mkdir $self->config->root;
    }
    else {
        die "YACT_ROOT already exist";
    }
    $self->db->deploy;
}

has db => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build_db {
    my $self = shift;
    YACT::DB->connect($self);
}

sub usercount { shift->db->resultset('User')->search( {} )->count }

sub get_user { shift->db->resultset('User')->find( { login => shift } ) }

1;
