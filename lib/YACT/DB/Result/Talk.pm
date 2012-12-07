package YACT::DB::Result::Talk;

=head1 NAME

YACT::DB::Result::Talk

=cut

use DBIx::Class::Candy -components => [
    'TimeStamp',                 'InflateColumn::DateTime',
    'InflateColumn::Serializer', 'EncodedColumn'
];

=head1 TABLE: C<talks>

=cut

table("talks");

=head1 ACCESSORS

=head2 talk_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'talks_talk_id_seq'

=head2 conf_id

  data_type: 'text'
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 abstract

  data_type: 'text'
  is_nullable: 1

=head2 url_abstract

  data_type: 'text'
  is_nullable: 1

=head2 url_talk

  data_type: 'text'
  is_nullable: 1

=head2 duration

  data_type: 'integer'
  is_nullable: 1

=head2 lightning

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 accepted

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 confirmed

  data_type: 'boolean'
  default_value: false
  is_nullable: 0

=head2 comment

  data_type: 'text'
  is_nullable: 1

=head2 room

  data_type: 'text'
  is_nullable: 1

=head2 datetime

  data_type: 'timestamp'
  is_nullable: 1

=head2 track_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 level

  data_type: 'integer'
  default_value: 1
  is_nullable: 1

=head2 lang

  data_type: 'text'
  is_nullable: 1

=cut

column "talk_id",
    {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "talks_talk_id_seq",
    };

column "conf_id", { data_type => "text", is_nullable => 0 };

column "user_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

column "title", { data_type => "text", is_nullable => 1 };

column "abstract", { data_type => "text", is_nullable => 1 };

column "url_abstract", { data_type => "text", is_nullable => 1 };

column "url_talk", { data_type => "text", is_nullable => 1 };

column "duration", { data_type => "integer", is_nullable => 1 };

column "lightning",
    { data_type => "boolean", default_value => \"false", is_nullable => 0 };

column "accepted",
    { data_type => "boolean", default_value => \"false", is_nullable => 0 };

column "confirmed",
    { data_type => "boolean", default_value => \"false", is_nullable => 0 };

column "comment", { data_type => "text", is_nullable => 1 };

column "room", { data_type => "text", is_nullable => 1 };

column "datetime", { data_type => "timestamp", is_nullable => 1 };

column "track_id",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 };

column "level",
    { data_type => "integer", default_value => 1, is_nullable => 1 };

column "lang", { data_type => "text", is_nullable => 1 };

=head1 PRIMARY KEY

=over 4

=item * L</talk_id>

=back

=cut

primary_key("talk_id");

=head1 RELATIONS

=head2 track

Type: belongs_to

Related object: L<YACT::DB::Result::Track>

=cut

belongs_to(
    "track",
    "YACT::DB::Result::Track",
    { track_id => "track_id" },
    {   is_deferrable => 0,
        join_type     => "LEFT",
        on_delete     => "SET NULL",
        on_update     => "NO ACTION",
    },
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

=head2 user_talks

Type: has_many

Related object: L<YACT::DB::Result::UserTalk>

=cut

has_many(
    "user_talks", "YACT::DB::Result::UserTalk",
    { "foreign.talk_id" => "self.talk_id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

1;
