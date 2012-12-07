package YACT::DB::Result::Tag;

=head1 NAME

YACT::DB::Result::Tag

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<tags>

=cut

table("tags");

=head1 ACCESSORS

=head2 tag_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'tags_tag_id_seq'

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=head2 tag

  data_type: 'text'
  is_nullable: 0

=head2 type

  data_type: 'text'
  is_nullable: 0

=head2 tagged_id

  data_type: 'text'
  is_nullable: 0

=cut

column
  "tag_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "tags_tag_id_seq",
  };

column
  "conf_id",
  { data_type => "text", is_nullable => 0 };

column
  "tag",
  { data_type => "text", is_nullable => 0 };

column
  "type",
  { data_type => "text", is_nullable => 0 };

column
  "tagged_id",
  { data_type => "text", is_nullable => 0 };

=head1 PRIMARY KEY

=over 4

=item * L</tag_id>

=back

=cut

primary_key("tag_id");

1;
