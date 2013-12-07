package YACT::DB::ResultSet;

use Moo;

extends qw(
    DBIx::Class::ResultSet
    DBIx::Class::Helper::ResultSet::Me
    DBIx::Class::Helper::ResultSet::Shortcut::Limit
    DBIx::Class::Helper::ResultSet::Shortcut::OrderBy
    DBIx::Class::Helper::ResultSet::Shortcut::Prefetch
    DBIx::Class::Helper::ResultSet::CorrelateRelationship
);

1;
