package YACT;

# ABSTRACT: Yet Another Conference Toolkit

use Moo;
use YACT::Config;
use YACT::DB;
use YACT::Repository;
use YACT::Conference;
use Config::INI::Reader;

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

sub get_repository {
    my ( $self, $remote, $type ) = @_;
    return YACT::Repository->new(
        yact   => $self,
        remote => $remote,
        $type ? ( type => $type ) : (),
    );
}

sub _confs_ini {
    my ($self) = @_;
    if ( -f $self->config->confs_ini ) {
        return Config::INI::Reader->read_file( $self->config->confs_ini );
    }
    return {};
}

sub get_conference {
    my ( $self, $conference ) = @_;
    die "Unknown conference " . $conference
        unless defined $self->_confs_ini->{$conference};
    my $config = $self->_confs_ini->{$conference};
    return YACT::Conference->new(
        yact   => $self,
        remote => $config->{remote},
        key    => $conference,
    );
}

sub get_conferences {
    my ($self) = @_;
    my @conferences;
    for ( sort { $a cmp $b } keys %{ $self->_confs_ini } ) {
        push @conferences, $self->get_conference($_);
    }
    return @conferences;
}

1;
