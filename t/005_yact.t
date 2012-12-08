#!/usr/bin/perl

use strict;
use warnings;
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
is( $yact->usercount, 8, 'Checking for expected test user count' );
is( $yact->get_user('test1')->email,
    'test@act.yapc.eu', 'Checking test1 for right email' );
ok( $yact->get_user('test1')->check_passwd('test1'),
    'Checking test1 password' );

my @conferences = $yact->get_conferences;

use DDP;
p(@conferences);

done_testing;
