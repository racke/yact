package YACT::DB::Result::Event;

=head1 NAME

YACT::DB::Result::Event

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<events>

=cut

table("events");

=head1 ACCESSORS

=head2 event_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'events_event_id_seq'

=cut

column
  "event_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "events_event_id_seq"
  };

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=cut 

column
  "conf_id",
  { data_type => "text", is_nullable => 0 };

=head2 title

  data_type: 'text'
  is_nullable: 0

=cut

column
  "title",
  { data_type => "text", is_nullable => 0 };

=head2 abstract

  data_type: 'text'
  is_nullable: 1

=cut

column
  "abstract",
  { data_type => "text", is_nullable => 1 };

=head2 url_abstract

  data_type: 'text'
  is_nullable: 1

=cut

column
  "url_abstract",
  { data_type => "text", is_nullable => 1 };

=head2 room

  data_type: 'text'
  is_nullable: 1

=cut

column
  "room",
  { data_type => "text", is_nullable => 1 };

=head2 duration

  data_type: 'integer'
  is_nullable: 1

=cut

column
  "duration",
  { data_type => "integer", is_nullable => 1 };

=head2 datetime

  data_type: 'timestamp'
  is_nullable: 1

=cut

column
  "datetime",
  { data_type => "timestamp", is_nullable => 1 };

=head1 PRIMARY KEY

=over 4

=item * L</event_id>

=back

=cut

primary_key("event_id");

1;
