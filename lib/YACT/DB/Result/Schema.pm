package YACT::DB::Result::Schema;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "schema";

column current_version => { data_type => "integer", is_nullable => 0 };

1;
