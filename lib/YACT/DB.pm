package YACT::DB;
# ABSTRACT: Database schema for YACT

use Moo;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;

has _yact => (
	is => 'rw',
);
sub yact { shift->_yact }

sub connect {
	my ( $self, $yact ) = @_;
	$yact = $self->_yact if ref $self;
	my $schema = $self->next::method(
		$yact->config->db_dsn,
		$yact->config->db_user,
		$yact->config->db_password,
		$yact->config->db_params,
	);
	$schema->_yact($yact);
	return $schema;
}

1;
