package YACT::Conference;

# ABSTRACT: A conference in YACT

use Moo;
use Path::Class;
use YACT::Conference::INI;
use DateTime;

has yact => (
    is       => 'ro',
    required => 1,
);

has conf_id => (
    is       => 'ro',
    required => 1,
);

has remote => (
    is       => 'ro',
    required => 1,
);

has remote_type => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        'git';
    }
);

has repository => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my ($self) = @_;
        $self->yact->get_repository( $self->remote, $self->remote_type );
    }
);

sub config {
    my ($self) = @_;
    my @master_inis;
    push @master_inis, $self->yact->config->confs_ini;
    my $repo_ini = $self->repository->get_file('yact.ini');
    my @repo_inis;
    push @repo_inis, $repo_ini if -f $repo_ini;
    return YACT::Conference::INI->new( $self->conf_id, [@master_inis],
        [@repo_inis] )->data;
}

sub add_attendee {
    my ( $self, $user, $tshirt, $nb_family ) = @_;
    $self->yact->db->resultset('Participation')->create(
        {   conf_id => $self->conf_id,
            user_id => $user->user_id,
            $tshirt            ? ( tshirt_size => uc($tshirt) ) : (),
            defined $nb_family ? ( nb_family   => $nb_family )  : (),
            datetime => DateTime->now,
        }
    );
}

sub get_attendees {
    my ($self) = @_;
    $self->yact->db->resultset('Participation')
        ->search( { conf_id => $self->conf_id, } );
}

1;
