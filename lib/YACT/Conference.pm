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

sub url_bases {
    my ($self) = @_;
    my %url_bases;
    my $base = $self->config->{general}->{conference_base};
    if ($base) {
        $url_bases{$base} = $self;
    }
    return \%url_bases;
}

sub add_participation {
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

sub get_participations {
    my $self = shift;
    $self->yact->db->resultset('Participation')->search(
        { conf_id => $self->conf_id, @_ },
        { order_by => { -desc => 'datetime' } }
    );
}

sub count_participations {
    my $self = shift;
    $self->yact->db->resultset('Participation')->search(
        { conf_id => $self->conf_id, @_ },
        { order_by => { -desc => 'datetime' } }
    )->count;
}

sub full {
    my $self = shift;
    return unless defined $self->config->{registration}->{max_attendees};
    $self->count_participations
        >= $self->config->{registration}->{max_attendees} ? 1 : 0;
}

sub get_events {
    my $self = shift;
    $self->yact->db->resultset('Event')->search(
        { conf_id => $self->conf_id, @_ },
        { order_by => { -desc => 'datetime' } }
    );
}

#
# News
#
#################

sub add_news {
    my ( $self, $user ) = @_;
    $self->yact->db->resultset('News')->create(
        {   conf_id  => $self->conf_id,
            user_id  => $user->user_id,
            datetime => DateTime->now,
        }
    );
}

sub get_news {
    my $self = shift;
    $self->yact->db->resultset('News')->search(
        { conf_id => $self->conf_id, @_ },
        { order_by => { -desc => 'datetime' } }
    );
}

#
# Tracks
#
##################

sub add_track {
    my ( $self, $title, $description ) = @_;
    $self->yact->db->resultset('Track')->create(
        {   conf_id     => $self->conf_id,
            title       => $title,
            description => $description,
        }
    );
}

sub get_tracks {
    my $self = shift;
    $self->yact->db->resultset('Track')->search(
        { conf_id => $self->conf_id, @_ },
        { order_by => { -asc => 'track_id' } }
    );
}

#
# Talks
#
##################

sub get_talks {
    my $self = shift;
    $self->yact->db->resultset('Talk')->search(
        { conf_id => $self->conf_id, @_ },
        {
            # TODO
        }
    );
}

#
# Tags
#
##################

sub get_tags {
    my $self = shift;
    $self->yact->db->resultset('Tag')
        ->search( { conf_id => $self->conf_id, @_ }, { order_by => 'tag' } );
}

sub get_tags_list {
    my $self = shift;
    my %tags = map { $_->tag, 1 } @{ [ $self->get_tags ] };
    return keys %tags;
}

#
# RIGHTS
#
##################

sub get_rights {
    my $self = shift;
    my %rights;
    for ( $self->yact->db->resultset('Right')
        ->search( { conf_id => $self->conf_id, @_ }, { prefetch => 'user' } )
        )
    {
        $rights{ $_->user->login } = []
            unless defined $rights{ $_->user->login };
        push @{ $rights{ $_->user->login } }, $_->right_id;
    }
    return \%rights;
}

sub get_user_rights {
    my $self = shift;
    return sort { $a cmp $b } map { $_->right_id } @{
        [   $self->yact->db->resultset('Right')->search(
                { user_id => shift->user_id, conf_id => $self->conf_id, @_ }
            )
        ]
    };
}

sub has_user_right {
    my ( $self, $user, $right ) = @_;
    return
        grep { $_ eq $right || $_ eq 'admin' } $self->get_user_rights($user);
}

sub add_user_right {
    my ( $self, $user, $right ) = @_;
    $self->yact->db->resultset('Right')->create(
        {   user_id  => $user->user_id,
            conf_id  => $self->conf_id,
            right_id => $right,
        }
    );
}

1;
