package YACT::Config;

use Moo;
use Path::Class;

has root => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build_root {
    defined $ENV{YACT_ROOT}
        ? dir( $ENV{YACT_ROOT} )->absolute
        : dir( $ENV{HOME}, 'yact' );
}

1;
