package YACT::DB::Result::Event;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "events";

primary_column event_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "events_event_id_seq"
};

column conf_id      => { data_type => "text",      is_nullable => 0 };
column title        => { data_type => "text",      is_nullable => 0 };
column abstract     => { data_type => "text",      is_nullable => 1 };
column url_abstract => { data_type => "text",      is_nullable => 1 };
column room         => { data_type => "text",      is_nullable => 1 };
column duration     => { data_type => "integer",   is_nullable => 1 };
column datetime     => { data_type => "timestamp", is_nullable => 1 };

1;
