package YACT::DB::Result::UserTalk;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "user_talks";

column user_id =>
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };
column conf_id => { data_type => "text", is_nullable => 0 };
column talk_id =>
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

belongs_to
    talk => "YACT::DB::Result::Talk",
    { talk_id => "talk_id" },
    {
    is_deferrable => 0,
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION"
    };

belongs_to
    user => "YACT::DB::Result::User",
    { user_id => "user_id" },
    {
    is_deferrable => 0,
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION"
    };

1;
