package YACT::DB::Result::UserTalk;

=head1 NAME

YACT::DB::Result::UserTalk

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<user_talks>

=cut

table("user_talks");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=head2 talk_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

column
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

column
  "conf_id",
  { data_type => "text", is_nullable => 0 };

column
  "talk_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

=head1 RELATIONS

=head2 talk

Type: belongs_to

Related object: L<YACT::DB::Result::Talk>

=cut

belongs_to(
  "talk",
  "YACT::DB::Result::Talk",
  { talk_id => "talk_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

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
