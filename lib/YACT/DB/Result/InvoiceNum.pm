package YACT::DB::Result::InvoiceNum;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "invoice_num";

primary_column conf_id => { data_type => "text",    is_nullable => 0 };
column next_num        => { data_type => "integer", is_nullable => 0 };

1;
