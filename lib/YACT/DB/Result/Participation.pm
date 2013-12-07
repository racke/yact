package YACT::DB::Result::Participation;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "participations";

column conf_id => { data_type => "text", is_nullable => 0 };
column user_id =>
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };
column tshirt_size => { data_type => "text", is_nullable => 1 };
column nb_family =>
    { data_type => "integer", default_value => 0, is_nullable => 1 };
column datetime => { data_type => "timestamp", is_nullable => 1 };
column ip       => { data_type => "text",      is_nullable => 1 };
column attended =>
    { data_type => "boolean", default_value => 0, is_nullable => 1 };

belongs_to
    user => "YACT::DB::Result::User",
    { user_id => "user_id" },
    {
    is_deferrable => 0,
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION"
    };

1;
