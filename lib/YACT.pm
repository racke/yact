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
        mkdir $self->config->root
            or die "Can't create the YACT_ROOT dir '"
            . $self->config->root . "': $!";
    }
    else {
        die "YACT_ROOT already exists";
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

sub get_user_by_id {
    shift->db->resultset('User')->find( { user_id => shift } );
}

sub get_repository {
    my ( $self, $remote, $type ) = @_;
    return YACT::Repository->new(
        yact   => $self,
        remote => $remote,
        $type ? ( type => $type ) : (),
    );
}

sub get_confs_ini {
    Config::INI::Reader->read_file( shift->config->confs_ini );
}

sub get_conference {
    my ( $self, $conf_id ) = @_;
    die "Unknown conference " . $conf_id
        unless defined $self->get_confs_ini->{$conf_id};
    my $config = $self->get_confs_ini->{$conf_id};
    return YACT::Conference->new(
        yact   => $self,
        remote => $config->{remote},
        defined $config->{remote_type}
        ? ( remote_type => $config->{remote_type} )
        : (),
        conf_id => $conf_id,
    );
}

sub get_conferences {
    my ($self) = @_;
    my @conferences;
    for (
        sort { $a cmp $b }
        grep { $_ ne '_' and $_ !~ /\// }
        keys %{ $self->get_confs_ini }
        )
    {
        push @conferences, $self->get_conference($_);
    }
    return @conferences;
}

1;
