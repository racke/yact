#!/usr/bin/env perl
#####################
# PODNAME: yact_test_deploy.pl

use FindBin;
use lib "$FindBin::Bin/../t/lib";
use lib "$FindBin::Bin/../lib";

use YACT;
use YACT::Config;

use YACTTest;

my $yacttest = YACTTest->new( yact_config => YACT::Config->new, );

die "Target directory " . $yacttest->yact->root . " already exist"
    if -d $yacttest->yact->root;

$yacttest->init;
