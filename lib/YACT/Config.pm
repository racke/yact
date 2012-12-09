package YACT::Config;

# ABSTRACT: Configuration class for YACT

use Moo;
use Path::Class;

has root => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        defined $ENV{YACT_ROOT}
            ? dir( $ENV{YACT_ROOT} )->absolute
            : dir( $ENV{HOME}, 'yact' );
    }
);

has db_dsn => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        defined $ENV{'YACT_DB_DSN'}
            ? $ENV{'YACT_DB_DSN'}
            : 'dbi:SQLite:' . file( shift->root, 'yact.db.sqlite' )->absolute;
    }
);

has db_user => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        defined $ENV{'YACT_DB_USER'}
            ? $ENV{'YACT_DB_USER'}
            : '';
    }
);

has db_password => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        defined $ENV{'YACT_DB_PASSWORD'}
            ? $ENV{'YACT_DB_PASSWORD'}
            : '';
    }
);

has db_params => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my $dsn  = shift->db_dsn;
        my %vars = (
            quote_char => '"',
            name_sep   => '.',
        );
        if ( $dsn =~ m/:SQLite:/ ) {
            $vars{sqlite_unicode} = 1;
        }
        elsif ( $dsn =~ m/:Pg:/ ) {
            $vars{pg_enable_utf8} = 1;
        }
        return \%vars;
    }
);

has confs_ini => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        file( shift->root, 'confs.ini' )->absolute;
    }
);

1;
