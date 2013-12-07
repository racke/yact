package YACT::DB::Result::Track;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "tracks";

primary_column "track_id",
    {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "tracks_track_id_seq",
    };

column conf_id     => { data_type => "text", is_nullable => 0 };
column title       => { data_type => "text", is_nullable => 0 };
column description => { data_type => "text", is_nullable => 1 };

has_many
    talks    => "YACT::DB::Result::Talk",
    track_id => {
    cascade_copy   => 0,
    cascade_delete => 0
    };

1;
