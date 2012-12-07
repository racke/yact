package YACT::DB::Result::Right;

=head1 NAME

YACT::DB::Result::Right

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<rights>

=cut

table("rights");

=head1 ACCESSORS

=head2 right_id

  data_type: 'text'
  is_nullable: 0

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

column
  "right_id",
  { data_type => "text", is_nullable => 0 };

column
  "conf_id",
  { data_type => "text", is_nullable => 0 };

column
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<YACT::DB::Result::User>

=cut

belongs_to(
  "user",
  "YACT::DB::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

1;
