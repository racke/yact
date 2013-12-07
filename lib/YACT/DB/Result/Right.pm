package YACT::DB::Result::Right;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "rights";

column right_id => { data_type => "text", is_nullable => 0 };
column conf_id  => { data_type => "text", is_nullable => 0 };
column user_id =>
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

belongs_to
    user => "YACT::DB::Result::User",
    { user_id => "user_id" },
    {
    is_deferrable => 0,
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION"
    };

1;
