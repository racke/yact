#!/usr/bin/env perl

use strict;
use warnings;

use Path::Class;
use File::Remove 'remove';
use File::Tempdir;
use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove);
use File::chdir;

use FindBin;

my $remote = dir( $FindBin::Bin, '..', 'remotes', 'remote' )->absolute;

remove( \1, $remote->stringify );
mkdir($remote);

my $src = dir( $FindBin::Bin, '..', 'remotes', 'src' )->absolute;

while ( my $file = $src->next ) {
    if ( $file->is_dir ) {
        my @list = $file->dir_list;
        my $last = pop @list;
        next if $last eq '..' or $last eq 'src';

        my $rrd = dir( $remote, $last )->absolute;

        # TODO: Make with perl

        my $temp = File::Tempdir->new;

        system( "git init " . $rrd->stringify . " --bare" );
        system( "git clone file://" . $rrd . " " . $temp->name );

        dircopy( $file, $temp->name );

        {
            local $CWD = $temp->name;
            system("git add .");
            system("git commit -m'YACT Testsetup'");
            system("git push -u origin master");
        }

        ###############################################

    }
    else {
        die "There is a file in t/remotes/src - please remove it";
    }
}
