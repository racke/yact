package YACT::DB::Result::NewsItem;

=head1 NAME

YACT::DB::Result::NewsItem

=cut

use DBIx::Class::Candy -components => [ 'TimeStamp', 'InflateColumn::DateTime', 'InflateColumn::Serializer', 'EncodedColumn' ];

=head1 TABLE: C<news_items>

=cut

table("news_items");

=head1 ACCESSORS

=head2 news_item_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'news_items_news_item_id_seq'

=head2 news_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 lang

  data_type: 'text'
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=head2 text

  data_type: 'text'
  is_nullable: 0

=cut

column
  "news_item_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "news_items_news_item_id_seq",
  };

column
  "news_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 };

column
  "lang",
  { data_type => "text", is_nullable => 0 };

column
  "title",
  { data_type => "text", is_nullable => 0 };

column
  "text",
  { data_type => "text", is_nullable => 0 };

=head1 PRIMARY KEY

=over 4

=item * L</news_item_id>

=back

=cut

primary_key("news_item_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<news_items_news_id_key>

=over 4

=item * L</news_id>

=item * L</lang>

=back

=cut

unique_constraint("news_items_news_id_key", ["news_id", "lang"]);

=head1 RELATIONS

=head2 news

Type: belongs_to

Related object: L<YACT::DB::Result::News>

=cut

belongs_to(
  "news",
  "YACT::DB::Result::News",
  { news_id => "news_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

1;
