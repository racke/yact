package YACT::DB::Result::Schema;

=head1 NAME

YACT::DB::Result::Schema

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<schema>

=cut

table("schema");

=head1 ACCESSORS

=head2 current_version

  data_type: 'integer'
  is_nullable: 0

=cut

column
  "current_version",
  { data_type => "integer", is_nullable => 0 };

1;
