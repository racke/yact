#!/usr/bin/env perl
#####################

use YACT;
use YACT::Config;

use FindBin;
use lib "$FindBin::Bin/../t/lib";
use lib "$FindBin::Bin/../lib";

use YACTTest;

my $yacttest = YACTTest->new(
	yact_config => YACT::Config->new,
);

die "Target directory ".$yacttest->yact->root." already exist" if -d $yacttest->yact->root;

$yacttest->init;
