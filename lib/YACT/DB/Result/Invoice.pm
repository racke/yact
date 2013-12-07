package YACT::DB::Result::Invoice;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "invoices";

primary_column invoice_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "invoices_invoice_id_seq",
};

column order_id =>
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };
column datetime   => { data_type => "timestamp", is_nullable => 0 };
column invoice_no => { data_type => "integer",   is_nullable => 0 };
column amount     => { data_type => "integer",   is_nullable => 0 };
column means      => { data_type => "text",      is_nullable => 1 };
column currency   => { data_type => "text",      is_nullable => 1 };
column first_name => { data_type => "text",      is_nullable => 1 };
column last_name  => { data_type => "text",      is_nullable => 1 };
column company    => { data_type => "text",      is_nullable => 1 };
column address    => { data_type => "text",      is_nullable => 1 };
column vat        => { data_type => "text",      is_nullable => 1 };

unique_constraint( "invoices_idx", ["order_id"] );

belongs_to
    order => "YACT::DB::Result::Order",
    { order_id => "order_id" },
    {
    is_deferrable => 0,
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION"
    };

1;
