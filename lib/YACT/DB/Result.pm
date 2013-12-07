package YACT::DB::Result;

use Moo;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components(
    qw/
        TimeStamp
        InflateColumn::DateTime
        InflateColumn::Serializer
        EncodedColumn
        Helper::Row::OnColumnChange
        Helper::Row::ProxyResultSetMethod
        +DBICx::Indexing
        /
);

1;
