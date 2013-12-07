package YACT::DB::Result::OrderItem;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "order_items";

primary_column item_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "order_items_item_id_seq",
};

column order_id =>
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };
column amount       => { data_type => "integer", is_nullable => 0 };
column name         => { data_type => "text",    is_nullable => 1 };
column registration => { data_type => "boolean", is_nullable => 0 };

belongs_to
    order => "YACT::DB::Result::Order",
    { order_id => "order_id" },
    {
    is_deferrable => 0,
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION"
    };

1;
