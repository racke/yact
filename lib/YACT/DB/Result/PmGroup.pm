package YACT::DB::Result::PmGroup;

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "pm_groups";

primary_column group_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "pm_groups_group_id_seq",
};

column xml_group_id => { data_type => "integer", is_nullable => 1 };
column name         => { data_type => "text",    is_nullable => 1 };
column status       => { data_type => "text",    is_nullable => 1 };
column continent    => { data_type => "text",    is_nullable => 1 };
column country      => { data_type => "text",    is_nullable => 1 };
column state        => { data_type => "text",    is_nullable => 1 };

1;
