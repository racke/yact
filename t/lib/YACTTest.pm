package YACTTest;
use utf8;

use Moo;
use YACT;
use YACT::Web;
use YACT::Config;
use File::Tempdir;
use Path::Class;
use IO::All;

use FindBin;

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
    $self->init_test_inifiles;
    $self->fill_test_database;
}

sub init_test_inifiles {
    my ($self)    = @_;
    my $confs_ini = $self->yact->config->confs_ini;
    my $dir       = file(__FILE__)->dir;
    my $remotes_dir =
        dir( $dir, "..", "remotes", "remote" )->cleanup->resolve->absolute;
    io($confs_ini)->print(<<"___END_OF_CONFS_INI___");
main_test = 1

[qh2012eu]
remote = $remotes_dir/qh2012eu
section_test = 1
section_other_test = 1

[qh2012eu/subsection]
subsection_test = 1
subsection_other_test = 1

[ye2013]
remote = $remotes_dir/ye2013

[yn2013]
remote = $remotes_dir/yn2013 

___END_OF_CONFS_INI___
}

sub fill_test_database {
    my ($self) = @_;
    my $yact   = $self->yact;
    my $db     = $yact->db;
    scalar $db->populate(
        'User',
        [

            [   qw( login passwd salutation first_name last_name nick_name pseudonymous country town web_page email pause_id language timezone photo_name )
            ],

            [   'test1',            'test1',
                undef,              'Long Lang',
                'Too Kool',         undef,
                0,                  'de',
                '',                 'http://test.de/',
                'test@act.yapc.eu', 'BLA',
                'de',               'Europe/Berlin',
                undef
            ],
            [   'test2',            'test2',
                1,                  'Überzone',
                'Drops the tone',   'Pseudo1',
                1,                  'uk',
                'London',           'http://test.de/',
                'test@act.yapc.eu', '',
                'en',               'Europe/Berlin',
                'test2.jpg'
            ],
            [   'test3',            'test3',
                3,                  'Perl',
                'Ganz Lang',        undef,
                0,                  'jp',
                '',                 'http://test.de/',
                'test@act.yapc.eu', '',
                'jp',               'Europe/Berlin',
                'test3-user.jpg'
            ],
            [   'test',             'test',
                undef,              'Peter',
                'Hallo',            'Pseudo2',
                1,                  'at',
                'Wien',             'http://test.de/',
                'test@act.yapc.eu', '',
                'at',               'Europe/Berlin',
                'test.jpg'
            ],
            [   '1test',            '1test',
                1,                  'Paul',
                'Overlord',         undef,
                0,                  'ru',
                '',                 '',
                'test@act.yapc.eu', 'BLUB',
                'ru',               'Europe/Berlin',
                '1test.jpg'
            ],
            [   'tt_tt',            'tt_tt',
                3,                  'Marry',
                'Ho',               'Pseudo3',
                1,                  'de',
                'Dresden',          '',
                'test@act.yapc.eu', '',
                'de',               'Europe/Berlin',
                'tt_tt.jpg'
            ],
            [   '_test',            '_test',
                undef,              'Sèbastian',
                'Frenchman',        'Pseudo4',
                0,                  'fr',
                undef,              undef,
                'test@act.yapc.eu', '',
                'fr',               'Europe/Berlin',
                '_test.jpg'
            ],
            [   'test_',            'test_',
                1,                  'Sébastian',
                'Englishman',       'Pseudo5',
                1,                  'us',
                'Philadelphia',     '',
                'test@act.yapc.eu', '',
                'en',               'Europe/Berlin',
                'test_.jpg'
            ],
            [   'gfuji',             'none',
                undef,               '藤 吾郎',
                '',                  'gfx',
                0,                   'jp',
                'Tōkyō',           'http://d.hatena.ne.jp/gfx/',
                'gfuji(at)cpan.org', 'GFUJI',
                'ja',                'Asia/Tokyo',
                'gfuji.jpg'
            ],
            [   'vti',                    'none',
                undef,                    'Вячеслав',
                'Тихановский', 'vti',
                0,                        'ua',
                'Киев',               'http://showmetheco.de/',
                'vti(at)cpan.org',        'VTI',
                'uk',                     'Europe/Kiev',
                undef
            ],
            [   'azawawi',
                'none',
                undef,
                'أحمد محمد زواوي',
                '',
                'azawawi',
                0,
                'jo',
                'Amman',
                'http://ahmadzawawi.blogspot.com/',
                'ahmad.zawawi(at)gmail.com',
                'AZAWAWI',
                'ar',
                'Asia/Amman',
                undef
            ],
            [   'nuffin',
                'none',
                undef,
                'יובל',
                "קוג'מן",
                'nothingmuch',
                0,
                'il',
                'Tel Aviv',
                'http://nothingmuch.woobling.org/',
                'nothingmuch(at)woobling.org',
                'NUFFIN',
                'he',
                'Asia/Jerusalem',
                'nuffin.jpg'
            ],

            #[
            #    'login', 'passwd',
            #    'salutation', 'first_name', 'last_name',
            #    'nick_name', 'pseudonymous',
            #    'country', 'town',
            #    'web_page', 'email',
            #    'pause_id', 'language', 'timezone', 'photo_name'
            #],

        ]
    );
    scalar $db->populate(
        'Event',
        [

            [   qw( conf_id title abstract url_abstract room duration datetime )
            ],
            [   'qh2012eu',
                'Coffee Break',
                'Are you kidding? Coffee is available all the time. Stop breaking. Go hacking!',
                '',
                'Classe Numérique',
                '10',
                '11:00',
            ],
            [   'ye2013',
                'Coffee/Tee Break',
                'Relax, chat, talk to others while having a hot beverage',
                'http://www.starbucks.com/',
                'Agora',
                '20',
                '16:00',
            ],
            [   'yn2013', 'Welcome',
                'Welcome talk.
                Introduction talk to the event.
                Free breakfast (coffee, tea, juices, pastries, yegg and beacon',
                '',   'Main Hall',
                '30', '09:30',
            ],
            [   'qh2012eu',
                'Coffee Break',
                'Are you kidding? Coffe is available all the time. Stop breaking. Go hacking!',
                undef,
                'Classe Numérique',
                '10',
                '11:00',
            ],
            [   'qh2012eu',
                'コーヒーブレイク',
                'コーヒーブレイク is provided to you by Google translate. I hope it is not rude.',
                '',
                'Agora',
                '20',
                '16:00',
            ],
            [   'qh2012eu',
                'Coffee Break',
                'Are you kidding? Coffe is available all the time. Stop breaking. Go hacking!',
                '',
                'Classe Numérique',
                '10',
                '11:00',
            ],
        ],
    );

    my $qh2012eu = $yact->get_conference('qh2012eu');

    # DO NOT ADD MORE PARTICIPATION - THE CONFERENCE IS FULL!
    $qh2012eu->add_participation( $yact->get_user('test1'), 'XL',  0 );
    $qh2012eu->add_participation( $yact->get_user('test2'), 'XXL', 0 );
    $qh2012eu->add_participation( $yact->get_user('test3'), 'M',   2 );
    #########################################################

    $qh2012eu->add_user_right( $yact->get_user('test1'), 'admin' );
    $qh2012eu->add_user_right( $yact->get_user('test3'), 'treasurer' );
    $qh2012eu->add_user_right( $yact->get_user('test3'), 'talks_admin' );
    $qh2012eu->add_user_right( $yact->get_user('test3'), 'wiki_admin' );

    $qh2012eu->add_track( 'Main Track', 'Inside of a museum!' );

    my $ye2013 = $yact->get_conference('ye2013');

    $ye2013->add_user_right( $yact->get_user('test2'),  'admin' );
    $ye2013->add_user_right( $yact->get_user('_test'),  'talks_admin' );
    $ye2013->add_user_right( $yact->get_user('nuffin'), 'wiki_admin' );
    $ye2013->add_user_right( $yact->get_user('test3'),  'treasurer' );

    $ye2013->add_track( 'Good Track', 'Heaven' );
    $ye2013->add_track( 'Bad Track',  'Hell' );
    $ye2013->add_track( 'Evil Track', 'London' );

    $ye2013->add_participation( $yact->get_user('test1'),   'XL',  0 );
    $ye2013->add_participation( $yact->get_user('test2'),   'XXL', 1 );
    $ye2013->add_participation( $yact->get_user('nuffin'),  'S',   0 );
    $ye2013->add_participation( $yact->get_user('azawawi'), 'L',   0 );
    $ye2013->add_participation( $yact->get_user('gfuji'),   'S',   0 );
    $ye2013->add_participation( $yact->get_user('_test'),   'M',   0 );

}

1;
