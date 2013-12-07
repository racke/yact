package YACT::DB::Result::Bio;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "bios";

column user_id => { data_type => "integer", is_nullable => 1 };
column lang    => { data_type => "text",    is_nullable => 1 };
column bio     => { data_type => "text",    is_nullable => 1 };

unique_constraint( "bios_idx", [ "user_id", "lang" ] );

1;
