package YACT::DB::Result::Invoice;

=head1 NAME

YACT::DB::Result::Invoice

=cut

use DBIx::Class::Candy -components => [
    'TimeStamp',                 'InflateColumn::DateTime',
    'InflateColumn::Serializer', 'EncodedColumn'
];

=head1 TABLE: C<invoices>

=cut

table "invoices";

=head1 ACCESSORS

=head2 invoice_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'invoices_invoice_id_seq'

=cut

column "invoice_id",
    {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "invoices_invoice_id_seq",
    };

=head2 order_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

column "order_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

=head2 datetime

  data_type: 'timestamp'
  is_nullable: 0

=cut

=head2 invoice_no

  data_type: 'integer'
  is_nullable: 0

=cut

=head2 amount

  data_type: 'integer'
  is_nullable: 0

=cut

=head2 means

  data_type: 'text'
  is_nullable: 1

=cut

=head2 currency

  data_type: 'text'
  is_nullable: 1

=cut

=head2 first_name

  data_type: 'text'
  is_nullable: 1

=cut

=head2 last_name

  data_type: 'text'
  is_nullable: 1

=cut

=head2 company

  data_type: 'text'
  is_nullable: 1

=cut

=head2 address

  data_type: 'text'
  is_nullable: 1

=cut

=head2 vat

  data_type: 'text'
  is_nullable: 1

=cut

column "datetime", { data_type => "timestamp", is_nullable => 0 };

column "invoice_no", { data_type => "integer", is_nullable => 0 };

column "amount", { data_type => "integer", is_nullable => 0 };

column "means", { data_type => "text", is_nullable => 1 };

column "currency", { data_type => "text", is_nullable => 1 };

column "first_name", { data_type => "text", is_nullable => 1 };

column "last_name", { data_type => "text", is_nullable => 1 };

column "company", { data_type => "text", is_nullable => 1 };

column "address", { data_type => "text", is_nullable => 1 };

column "vat", { data_type => "text", is_nullable => 1 };

=head1 PRIMARY KEY

=over 4

=item * L</invoice_id>

=back

=cut

primary_key("invoice_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<invoices_idx>

=over 4

=item * L</order_id>

=back

=cut

unique_constraint( "invoices_idx", ["order_id"] );

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
