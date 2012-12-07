package YACTTest;
use utf8;

use Moo;
use YACT;
use YACT::Config;
use File::Tempdir;
use Path::Class;

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
    $self->fill_test_database;
}

sub fill_test_database {
    my ($self) = @_;
    my $db = $self->yact->db;
    scalar $db->populate(
        'User',
        [

            [   qw( login passwd salutation first_name last_name nick_name pseudonymous country town web_page email pause_id language timezone )
            ],

            [   'test1',            'test1',
                undef,              'Long Lang',
                'Too Kool',         undef,
                0,                  'de',
                '',                 'http://test.de/',
                'test@act.yapc.eu', 'BLA',
                'de',               'Europe/Berlin'
            ],
            [   'test2',            'test2',
                1,                  'Überzone',
                'Drops the tone',   'Pseudo1',
                1,                  'uk',
                'London',           'http://test.de/',
                'test@act.yapc.eu', '',
                'en',               'Europe/Berlin'
            ],
            [   'test3',            'test3',
                3,                  'Perl',
                'Ganz Lang',        undef,
                0,                  'jp',
                '',                 'http://test.de/',
                'test@act.yapc.eu', '',
                'jp',               'Europe/Berlin'
            ],
            [   'test',             'test',
                undef,              'Peter',
                'Hallo',            'Pseudo2',
                1,                  'at',
                'Wien',             'http://test.de/',
                'test@act.yapc.eu', '',
                'at',               'Europe/Berlin'
            ],
            [   '1test', '1test', 1, 'Paul', 'Overlord', undef, 0, 'ru', '',
                '', 'test@act.yapc.eu', 'BLUB', 'ru', 'Europe/Berlin'
            ],
            [   'tt_tt', 'tt_tt', 3, 'Marry', 'Ho', 'Pseudo3', 1, 'de',
                'Dresden', '', 'test@act.yapc.eu', '', 'de', 'Europe/Berlin'
            ],
            [   '_test',            '_test',
                undef,              'Sèbastian',
                'Frenchman',        'Pseudo4',
                0,                  'fr',
                undef,              undef,
                'test@act.yapc.eu', '',
                'fr',               'Europe/Berlin'
            ],
            [   'test_',            'test_',
                1,                  'Sébastian',
                'Englishman',       'Pseudo5',
                1,                  'us',
                'Philadelphia',     '',
                'test@act.yapc.eu', '',
                'en',               'Europe/Berlin'
            ],

        ]
    );

}

1;
