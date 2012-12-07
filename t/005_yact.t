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

ok( -d $yacttest->testdir, 'Checking if dir was successful created' );
is( $yacttest->yact->root, $yacttest->testdir, 'Checking root directory be where expected' );
is( $yacttest->yact->usercount, 8, 'Checking for expected test user count' );
is( $yacttest->yact->get_user('test1')->email, 'test@act.yapc.eu', 'Checking test1 for right email' );
ok( $yacttest->yact->get_user('test1')->check_passwd('test1'), 'Checking test1 password' );

done_testing;
