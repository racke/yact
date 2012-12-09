#!/usr/bin/perl

use strict;
use warnings;
use IO::All;
use Test::More;
use Path::Class;
use File::Tempdir;
use Test::Warn;
use FindBin;
use lib "$FindBin::Bin/lib";

use YACTTest;

my $yacttest = YACTTest->new;

$yacttest->init;

my $yact = $yacttest->yact;

ok( -d $yacttest->testdir, 'Checking if dir was successful created' );
is( $yact->root, $yacttest->testdir,
    'Checking root directory be where expected' );
is( $yact->usercount, 12, 'Checking for expected test user count' );
is( $yact->get_user('test1')->email,
    'test@act.yapc.eu', 'Checking test1 for right email' );
ok( $yact->get_user('test1')->check_passwd('test1'),
    'Checking test1 password' );

my @conferences = $yact->get_conferences;

for (@conferences) {
    $_->repository->update;
}

my $qh2012eu = $yact->get_conference('qh2012eu');
isa_ok( $qh2012eu, 'YACT::Conference' );

my $repo = $qh2012eu->repository;
isa_ok( $repo, 'YACT::Repository' );

my $ye2013 = $yact->get_conference('ye2013');
isa_ok( $ye2013, 'YACT::Conference' );

my $ini =
    $ye2013->repository->get_file('yact.ini')
    ->absolute->cleanup->resolve->stringify;
my $ye2013_ini = io($ini)->slurp;
is( $ye2013_ini,
    'stay_simple = 1',
    'Config file is proper read from the test repo of ye2013'
);

my $fetched_config = $qh2012eu->config;
delete $fetched_config->{remote};

is_deeply(
    $fetched_config,
    {   'general' => {
            'default_language' => 'en',
            'default_country'  => 'fr',
            'timezone'         => 'Europe/Paris',
            'languages'        => 'en',
            'full_uri'         => 'http://act.yapc.eu/qh2012eu/',
            'name_en'          => 'Quack and Hack 2012 Europe Sample'
        },
        'levels'  => { 'level1_name_en' => 'Beginner' },
        'payment' => {
            'currency' => 'EUR',
            'open'     => '1',
            'invoices' => '0',
            'type'     => 'YEF',
            'products' => 'registration'
        },
        'section_other_test'   => '1',
        'product_registration' => {
            'name_en' => 'Registration',
            'prices'  => '1'
        },
        'talks' => {
            'levels'                      => '1',
            'submissions_notify_language' => 'en',
            'notify_accept'               => '1',
            'end_date'                    => '2012-12-09 23:00:00',
            'show_schedule'               => '1',
            'durations'                   => '5 40',
            'start_date'                  => '2012-12-06 08:00:00',
            'submissions_open'            => '1',
            'edition_open'                => '0',
            'submissions_notify_address'  => 'getty@duckduckgo.com'
        },
        'registration' => {
            'open'          => '1',
            'max_attendees' => '3',
            'gratis'        => '0'
        },
        'rooms' => {
            'rooms'      => 'r1 r2',
            'r1_name_en' => 'Classe numerique',
            'r2_name_en' => 'Agora'
        },
        'section_test' => '1',
        'subsection'   => {
            'subsection_test'             => '1',
            'subsection_other_test'       => '2',
            'subsection_other_other_test' => '2'
        },
        'product_registration_price1' => {
            'amount'  => '20',
            'name_en' => 'standard'
        },
        'flickr' => { 'tags' => 'qh2012eu' }
    },
    'Checking qh2012eu config (after removing remote)'
);

my @attendee =
    sort { $a->user->login cmp $b->user->login }
    $qh2012eu->get_participations;

is( $attendee[0]->user->login, 'test1', 'test1 participate at qh2012eu' );
is( $attendee[1]->user->login, 'test2', 'test2 participate at qh2012eu' );
is( $attendee[2]->user->login, 'test3', 'test3 participate at qh2012eu' );

ok( $qh2012eu->full, 'qh2012eu is full' );
ok( !$ye2013->full,  'No limit set, so ye2013 is never full' );

my @tracks = sort { $a->title cmp $b->title } $ye2013->get_tracks;

is( $tracks[0]->title, 'Bad Track',  'Checking tracklist of ye2013' );
is( $tracks[1]->title, 'Evil Track', 'Checking tracklist of ye2013' );
is( $tracks[2]->title, 'Good Track', 'Checking tracklist of ye2013' );

is_deeply( [ $qh2012eu->get_user_rights( $attendee[0]->user ) ],
    [qw( admin )], 'Checking test1 is admin at qh2012eu' );
is_deeply( [ $qh2012eu->get_user_rights( $attendee[1]->user ) ],
    [], 'Checking test2 has no rights at qh2012eu' );
is_deeply(
    [ $qh2012eu->get_user_rights( $attendee[2]->user ) ],
    [qw( talks_admin treasurer wiki_admin )],
    'Checking test3 is talks_admin treasurer wiki_admin at qh2012eu'
);

ok( $qh2012eu->has_user_right( $attendee[2]->user, 'wiki_admin' ),
    'Checked attendee is wiki admin' );
ok( !$qh2012eu->has_user_right( $attendee[1]->user, 'wiki_admin' ),
    'Other checked attendee is not wiki admin' );
ok( $qh2012eu->has_user_right( $attendee[0]->user, 'wiki_admin' ),
    'Admin attendee is wiki admin' );

is_deeply(
    $qh2012eu->get_rights,
    {   'test1' => ['admin'],
        'test3' => [ 'treasurer', 'talks_admin', 'wiki_admin' ]
    },
    'Checking user rights table of qh2012eu'
);

done_testing;
