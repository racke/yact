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
    {   'section_test'       => '2',
        'section_other_test' => '1',
        'subsection'         => {
            'subsection_test'       => '2',
            'subsection_other_test' => '1'
        },
    },
    'Checking qh2012eu config (after removing remote)'
);

my @attendee =
    sort { $a->user->login cmp $b->user->login } $qh2012eu->get_attendees;

is( $attendee[0]->user->login, 'test1', 'test1 participate at qh2012eu' );
is( $attendee[1]->user->login, 'test2', 'test2 participate at qh2012eu' );
is( $attendee[2]->user->login, 'test3', 'test3 participate at qh2012eu' );

done_testing;
