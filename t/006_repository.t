#!/usr/bin/env perl

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

SKIP: {
    skip "Need YACT_TEST_REMOTE defined", 1
        unless defined $ENV{YACT_TEST_REMOTE};

    my $yactrepo =
        $yacttest->yact->get_repository('git://github.com/perl-act/yact.git');
    my @branches = @{ $yactrepo->_git->branches };

    cmp_ok( @branches, '>', 1,
        "Searching for at least 2 branches i expected" );
}

done_testing;
