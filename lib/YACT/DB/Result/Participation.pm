package YACT::DB::Result::Participation;

=head1 NAME

YACT::DB::Result::Participation

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<participations>

=cut

table("participations");

=head1 ACCESSORS

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tshirt_size

  data_type: 'text'
  is_nullable: 1

=head2 nb_family

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 datetime

  data_type: 'timestamp'
  is_nullable: 1

=head2 ip

  data_type: 'text'
  is_nullable: 1

=head2 attended

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=cut

column
  "conf_id",
  { data_type => "text", is_nullable => 0 };

column
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

column
  "tshirt_size",
  { data_type => "text", is_nullable => 1 };

column
  "nb_family",
  { data_type => "integer", default_value => 0, is_nullable => 1 };

column
  "datetime",
  { data_type => "timestamp", is_nullable => 1 };

column
  "ip",
  { data_type => "text", is_nullable => 1 };

column
  "attended",
  { data_type => "boolean", default_value => \"false", is_nullable => 1 };

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
