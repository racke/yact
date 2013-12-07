package YACT::DB::Result::Twostep;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "twostep";

primary_column token => { data_type => "char", is_nullable => 0, size => 32 };
column email    => { data_type => "text",      is_nullable => 0 };
column datetime => { data_type => "timestamp", is_nullable => 1 };
column data     => { data_type => "text",      is_nullable => 1 };

1;
