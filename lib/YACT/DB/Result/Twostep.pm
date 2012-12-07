package YACT::DB::Result::Twostep;

=head1 NAME

YACT::DB::Result::Twostep

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<twostep>

=cut

table("twostep");

=head1 ACCESSORS

=head2 token

  data_type: 'char'
  is_nullable: 0
  size: 32

  PRIMARY KEY

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 datetime

  data_type: 'timestamp'
  is_nullable: 1

=head2 data

  data_type: 'text'
  is_nullable: 1

=cut

primary_column
  "token",
  { data_type => "char", is_nullable => 0, size => 32 };

column
  "email",
  { data_type => "text", is_nullable => 0 };

column
  "datetime",
  { data_type => "timestamp", is_nullable => 1 };

column
  "data",
  { data_type => "text", is_nullable => 1 };

1;
