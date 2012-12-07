package YACT::DB::Result::Track;

=head1 NAME

YACT::DB::Result::Track

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<tracks>

=cut

table("tracks");

=head1 ACCESSORS

=head2 track_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'tracks_track_id_seq'

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

column
  "track_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "tracks_track_id_seq",
  };

column
  "conf_id",
  { data_type => "text", is_nullable => 0 };

column
  "title",
  { data_type => "text", is_nullable => 0 };

column
  "description",
  { data_type => "text", is_nullable => 1 };

=head1 PRIMARY KEY

=over 4

=item * L</track_id>

=back

=cut

primary_key("track_id");

=head1 RELATIONS

=head2 talks

Type: has_many

Related object: L<YACT::DB::Result::Talk>

=cut

has_many(
  "talks",
  "YACT::DB::Result::Talk",
  { "foreign.track_id" => "self.track_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

1;
