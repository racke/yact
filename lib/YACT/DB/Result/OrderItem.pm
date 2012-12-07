package YACT::DB::Result::OrderItem;

=head1 NAME

YACT::DB::Result::OrderItem

=cut

use DBIx::Class::Candy -components => [
    'TimeStamp',                 'InflateColumn::DateTime',
    'InflateColumn::Serializer', 'EncodedColumn'
];

=head1 TABLE: C<order_items>

=cut

table("order_items");

=head1 ACCESSORS

=head2 item_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'order_items_item_id_seq'

=head2 order_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 amount

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 registration

  data_type: 'boolean'
  is_nullable: 0

=cut

column "item_id",
    {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "order_items_item_id_seq",
    };

column "order_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

column "amount", { data_type => "integer", is_nullable => 0 };

column "name", { data_type => "text", is_nullable => 1 };

column "registration", { data_type => "boolean", is_nullable => 0 };

=head1 PRIMARY KEY

=over 4

=item * L</item_id>

=back

=cut

primary_key("item_id");

=head1 RELATIONS

=head2 order

Type: belongs_to

Related object: L<YACT::DB::Result::Order>

=cut

belongs_to(
    "order",
    "YACT::DB::Result::Order",
    { order_id => "order_id" },
    {   is_deferrable => 0,
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION"
    },
);

1;
