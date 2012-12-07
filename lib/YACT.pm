package YACT;

use Moo;
use YACT::Config;

has config => (
	is => 'ro',
	lazy => 1,
	builder => 1,
);

sub _build_config { YACT::Config->new }

sub BUILD {
	my ( $self ) = @_;
	unless (-d $self->config->root) {
		warn "YACT_ROOT doesn't exist - creating it";
		mkdir $self->config->root;
	}
}

1;
