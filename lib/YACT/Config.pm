package YACT::Config;

use Moo;
use Path::Class;

has root => ( is => 'ro', lazy => 1, builder => 1, );
sub _build_root { defined $ENV{YACT_ROOT} ? dir($ENV{YACT_ROOT})->absolute : dir($ENV{HOME},'yact') }

has db_dsn => ( is => 'ro', lazy => 1, builder => 1, );
sub _build_db_dsn {
	my ( $self ) = @_;
	if (defined $ENV{'YACT_DB_DSN'}) {
		return $ENV{'YACT_DB_DSN'};
	} else {
		my $root = $self->root;
		my $sqlite = file($root,'yact.db.sqlite');
		return 'dbi:SQLite:'.$sqlite->absolute;
	}
}

has db_user => ( is => 'ro', lazy => 1, builder => 1, );
sub _build_db_user { defined $ENV{'YACT_DB_USER'} ? $ENV{'YACT_DB_USER'} : '' }

has db_password => ( is => 'ro', lazy => 1, builder => 1, );
sub _build_db_password { defined $ENV{'YACT_DB_PASSWORD'} ? $ENV{'YACT_DB_PASSWORD'} : '' }

has db_params => ( is => 'ro', lazy => 1, builder => 1, );
sub _build_db_params {
	my ( $self ) = @_;
	my $dsn = $self->db_dsn;
	my %vars = (
		quote_char		=> '"',
		name_sep		=> '.',
	);
	if ($dsn =~ m/:SQLite:/) {
		$vars{sqlite_unicode} = 1;
	} elsif ($dsn =~ m/:Pg:/) {
		$vars{pg_enable_utf8} = 1;
	}
	return \%vars;
}

1;