#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use Path::Class;
use File::Tempdir;
use Test::Warn;

use YACT;

my $tempdir = File::Tempdir->new;
my $abs_tempdir = dir($tempdir)->absolute;

$ENV{YACT_ROOT} = $abs_tempdir;

my $yact;

warning_is {
	$yact = YACT->new;
} "YACT_ROOT doesn't exist - creating it";

is($yact->root,$abs_tempdir,'Checking root directory');

done_testing;