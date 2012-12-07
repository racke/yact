package YACT::DB::Result::InvoiceNum;

=head1 NAME

YACT::DB::Result::InvoiceNum

=cut

use DBIx::Class::Candy -components => [
    'TimeStamp',                 'InflateColumn::DateTime',
    'InflateColumn::Serializer', 'EncodedColumn'
];

=head1 TABLE: C<invoice_num>

=cut

table("invoice_num");

=head1 ACCESSORS

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=head2 next_num

  data_type: 'integer'
  is_nullable: 0

=cut

column "conf_id", { data_type => "text", is_nullable => 0 };

column "next_num", { data_type => "integer", is_nullable => 0 };

=head1 PRIMARY KEY

=over 4

=item * L</conf_id>

=back

=cut

primary_key("conf_id");

1;
