package YACT::DB::Result::PmGroup;

=head1 NAME

YACT::DB::Result::PmGroup

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<pm_groups>

=cut

table("pm_groups");

=head1 ACCESSORS

=head2 group_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'pm_groups_group_id_seq'

=head2 xml_group_id

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'text'
  is_nullable: 1

=head2 continent

  data_type: 'text'
  is_nullable: 1

=head2 country

  data_type: 'text'
  is_nullable: 1

=head2 state

  data_type: 'text'
  is_nullable: 1

=cut

column
  "group_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "pm_groups_group_id_seq",
  };

column
  "xml_group_id",
  { data_type => "integer", is_nullable => 1 };

column
  "name",
  { data_type => "text", is_nullable => 1 };

column
  "status",
  { data_type => "text", is_nullable => 1 };

column
  "continent",
  { data_type => "text", is_nullable => 1 };

column
  "country",
  { data_type => "text", is_nullable => 1 };

column
  "state",
  { data_type => "text", is_nullable => 1 };

=head1 PRIMARY KEY

=over 4

=item * L</group_id>

=back

=cut

primary_key("group_id");

1;
