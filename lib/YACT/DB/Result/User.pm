package YACT::DB::Result::User;

=head1 NAME

YACT::DB::Result::User

=cut

use DBIx::Class::Candy -components => [
    'TimeStamp',                 'InflateColumn::DateTime',
    'InflateColumn::Serializer', 'EncodedColumn'
];

=head1 TABLE: C<users>

=cut

table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_user_id_seq'

  PRIMARY KEY

=head2 login

  data_type: 'text'
  is_nullable: 0

=head2 passwd

  data_type: 'text'
  is_nullable: 0

=head2 session_id

  data_type: 'text'
  is_nullable: 1

=head2 salutation

  data_type: 'integer'
  is_nullable: 1

=head2 first_name

  data_type: 'text'
  is_nullable: 1

=head2 last_name

  data_type: 'text'
  is_nullable: 1

=head2 nick_name

  data_type: 'text'
  is_nullable: 1

=head2 pseudonymous

  data_type: 'boolean'
  default_value: false
  is_nullable: 1

=head2 country

  data_type: 'text'
  is_nullable: 0

=head2 town

  data_type: 'text'
  is_nullable: 1

=head2 web_page

  data_type: 'text'
  is_nullable: 1

=head2 pm_group

  data_type: 'text'
  is_nullable: 1

=head2 pm_group_url

  data_type: 'text'
  is_nullable: 1

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 email_hide

  data_type: 'boolean'
  default_value: true
  is_nullable: 0

=head2 gpg_key_id

  data_type: 'text'
  is_nullable: 1

=head2 pause_id

  data_type: 'text'
  is_nullable: 1

=head2 monk_id

  data_type: 'text'
  is_nullable: 1

=head2 monk_name

  data_type: 'text'
  is_nullable: 1

=head2 im

  data_type: 'text'
  is_nullable: 1

=head2 photo_name

  data_type: 'text'
  is_nullable: 1

=head2 language

  data_type: 'text'
  is_nullable: 1

=head2 timezone

  data_type: 'text'
  is_nullable: 0

=head2 company

  data_type: 'text'
  is_nullable: 1

=head2 company_url

  data_type: 'text'
  is_nullable: 1

=head2 address

  data_type: 'text'
  is_nullable: 1

=head2 vat

  data_type: 'text'
  is_nullable: 1

=cut

primary_column "user_id",
    {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_user_id_seq",
    };

column "login", { data_type => "text", is_nullable => 0 };

column "passwd",
    {
    data_type           => "text",
    is_nullable         => 0,
    encode_column       => 1,
    encode_class        => 'Digest',
    encode_args         => { algorithm => 'MD5', format => 'base64' },
    encode_check_method => 'check_passwd',
    };

column "session_id", { data_type => "text", is_nullable => 1 };

column "salutation", { data_type => "integer", is_nullable => 1 };

column "first_name", { data_type => "text", is_nullable => 1 };

column "last_name", { data_type => "text", is_nullable => 1 };

column "nick_name", { data_type => "text", is_nullable => 1 };

column "pseudonymous",
    { data_type => "boolean", default_value => \"false", is_nullable => 1 };

column "country", { data_type => "text", is_nullable => 0 };

column "town", { data_type => "text", is_nullable => 1 };

column "web_page", { data_type => "text", is_nullable => 1 };

column "pm_group", { data_type => "text", is_nullable => 1 };

column "pm_group_url", { data_type => "text", is_nullable => 1 };

column "email", { data_type => "text", is_nullable => 0 };

column "email_hide",
    { data_type => "boolean", default_value => \"true", is_nullable => 0 };

column "gpg_key_id", { data_type => "text", is_nullable => 1 };

column "pause_id", { data_type => "text", is_nullable => 1 };

column "monk_id", { data_type => "text", is_nullable => 1 };

column "monk_name", { data_type => "text", is_nullable => 1 };

column "im", { data_type => "text", is_nullable => 1 };

column "photo_name", { data_type => "text", is_nullable => 1 };

column "language", { data_type => "text", is_nullable => 1 };

column "timezone", { data_type => "text", is_nullable => 0 };

column "company", { data_type => "text", is_nullable => 1 };

column "company_url", { data_type => "text", is_nullable => 1 };

column "address", { data_type => "text", is_nullable => 1 };

column "vat", { data_type => "text", is_nullable => 1 };

=head1 UNIQUE CONSTRAINTS

=head2 C<users_login>

=over 4

=item * L</login>

=back

=cut

unique_constraint( "users_login", ["login"] );

=head2 C<users_session_id>

=over 4

=item * L</session_id>

=back

=cut

unique_constraint( "users_session_id", ["session_id"] );

=head1 RELATIONS

=head2 orders

Type: has_many

Related object: L<YACT::DB::Result::Order>

=cut

has_many(
    "orders", "YACT::DB::Result::Order",
    { "foreign.user_id" => "self.user_id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 participations

Type: has_many

Related object: L<YACT::DB::Result::Participation>

=cut

has_many(
    "participations",
    "YACT::DB::Result::Participation",
    { "foreign.user_id" => "self.user_id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 rights

Type: has_many

Related object: L<YACT::DB::Result::Right>

=cut

has_many(
    "rights", "YACT::DB::Result::Right",
    { "foreign.user_id" => "self.user_id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 talks

Type: has_many

Related object: L<YACT::DB::Result::Talk>

=cut

has_many(
    "talks", "YACT::DB::Result::Talk",
    { "foreign.user_id" => "self.user_id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

=head2 user_talks

Type: has_many

Related object: L<YACT::DB::Result::UserTalk>

=cut

has_many(
    "user_talks", "YACT::DB::Result::UserTalk",
    { "foreign.user_id" => "self.user_id" },
    { cascade_copy      => 0, cascade_delete => 0 },
);

1;
