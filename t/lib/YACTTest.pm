package YACTTest;
use utf8;

use Moo;
use YACT;
use YACT::Web;
use YACT::Config;
use Path::Class;

use FindBin;

use YACTTest::Conferences;

has tempdir => (
    is      => 'ro',
    lazy    => 1,
    default => sub { File::Tempdir->new }
);

has testdir => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build_testdir {
    my $self = shift;
    return dir( $self->tempdir->name, 'yact-test' )->absolute;
}

has yact => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build_yact {
    my ($self) = @_;
    return YACT->new( config => $self->yact_config );
}

has yact_web => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build_yact_web {
    my ($self) = @_;
    return YACT::Web->new( yact => $self->yact );
}

has yact_config => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

sub _build_yact_config {
    my ($self) = @_;
    return YACT::Config->new(
        root   => $self->testdir,
        db_dsn => 'dbi:SQLite::memory:',
    );
}

sub init {
    my ($self) = @_;
    $self->yact->init;
    YACTTest::Conferences::init( $self->yact );
}

1;
