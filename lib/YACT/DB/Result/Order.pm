package YACT::DB::Result::Order;

=head1 NAME

YACT::DB::Result::Order

=cut

use DBIx::Class::Candy -components => [
    'TimeStamp',                 'InflateColumn::DateTime',
    'InflateColumn::Serializer', 'EncodedColumn'
];

=head1 TABLE: C<orders>

=cut

table("orders");

=head1 ACCESSORS

=head2 order_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'orders_order_id_seq'

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 datetime

  data_type: 'timestamp'
  is_nullable: 0

=head2 means

  data_type: 'text'
  is_nullable: 1

=head2 currency

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'text'
  is_nullable: 0

=head2 type

  data_type: 'text'
  is_nullable: 1

=cut

column "order_id",
    {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "orders_order_id_seq",
    };

column "conf_id", { data_type => "text", is_nullable => 0 };

column "user_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

column "datetime", { data_type => "timestamp", is_nullable => 0 };

column "means", { data_type => "text", is_nullable => 1 };

column "currency", { data_type => "text", is_nullable => 1 };

column "status", { data_type => "text", is_nullable => 0 };

column "type", { data_type => "text", is_nullable => 1 };

=head1 PRIMARY KEY

=over 4

=item * L</order_id>

=back

=cut

primary_key("order_id");

=head1 RELATIONS

=head2 invoice

Type: might_have

Related object: L<YACT::DB::Result::Invoice>

=cut

might_have(
    "invoice", "YACT::DB::Result::Invoice",
    { "foreign.order_id" => "self.order_id" },
    { cascade_copy       => 0, cascade_delete => 0 },
);

=head2 order_items

Type: has_many

Related object: L<YACT::DB::Result::OrderItem>

=cut

has_many(
    "order_items", "YACT::DB::Result::OrderItem",
    { "foreign.order_id" => "self.order_id" },
    { cascade_copy       => 0, cascade_delete => 0 },
);

=head2 user

Type: belongs_to

Related object: L<YACT::DB::Result::User>

=cut

belongs_to(
    "user",
    "YACT::DB::Result::User",
    { user_id => "user_id" },
    {   is_deferrable => 0,
        on_delete     => "NO ACTION",
        on_update     => "NO ACTION"
    },
);

1;
