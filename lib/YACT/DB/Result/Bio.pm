package YACT::DB::Result::Bio;

=head1 NAME

YACT::DB::Result::Bio

=cut

use DBIx::Class::Candy -components => [
    'TimeStamp',                 'InflateColumn::DateTime',
    'InflateColumn::Serializer', 'EncodedColumn'
];

=head1 TABLE: C<bios>

=cut

table("bios");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_nullable: 1

=cut

column "user_id", { data_type => "integer", is_nullable => 1 };

=head2 lang

  data_type: 'text'
  is_nullable: 1

=cut

column "lang", { data_type => "text", is_nullable => 1 };

=head2 bio

  data_type: 'text'
  is_nullable: 1

=cut

column "bio", { data_type => "text", is_nullable => 1 };

=head1 UNIQUE CONSTRAINTS

=head2 C<bios_idx>

=over 4

=item * L</user_id>

=item * L</lang>

=back

=cut

unique_constraint( "bios_idx", [ "user_id", "lang" ] );

1;
