package YACT::DB::Result::User;

# ABSTRACT: User table result class

use Moo;
extends 'YACT::DB::Result';
use DBIx::Class::Candy;

table "users";

primary_column user_id => {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_user_id_seq",
};

column login => { data_type => "text", is_nullable => 0 };
column passwd => {
    data_type           => "text",
    is_nullable         => 0,
    encode_column       => 1,
    encode_class        => 'Digest',
    encode_args         => { algorithm => 'MD5', format => 'base64' },
    encode_check_method => 'check_passwd',
};

column session_id => { data_type => "text",    is_nullable => 1 };
column salutation => { data_type => "integer", is_nullable => 1 };
column first_name => { data_type => "text",    is_nullable => 1 };
column last_name  => { data_type => "text",    is_nullable => 1 };
column nick_name  => { data_type => "text",    is_nullable => 1 };
column pseudonymous =>
    { data_type => "boolean", default_value => 0, is_nullable => 1 };
column country      => { data_type => "text", is_nullable => 0 };
column town         => { data_type => "text", is_nullable => 1 };
column web_page     => { data_type => "text", is_nullable => 1 };
column pm_group     => { data_type => "text", is_nullable => 1 };
column pm_group_url => { data_type => "text", is_nullable => 1 };
column email        => { data_type => "text", is_nullable => 0 };
column email_hide =>
    { data_type => "boolean", default_value => 1, is_nullable => 0 };
column gpg_key_id  => { data_type => "text", is_nullable => 1 };
column pause_id    => { data_type => "text", is_nullable => 1 };
column monk_id     => { data_type => "text", is_nullable => 1 };
column monk_name   => { data_type => "text", is_nullable => 1 };
column im          => { data_type => "text", is_nullable => 1 };
column photo_name  => { data_type => "text", is_nullable => 1 };
column language    => { data_type => "text", is_nullable => 1 };
column timezone    => { data_type => "text", is_nullable => 0 };
column company     => { data_type => "text", is_nullable => 1 };
column company_url => { data_type => "text", is_nullable => 1 };
column address     => { data_type => "text", is_nullable => 1 };
column vat         => { data_type => "text", is_nullable => 1 };

unique_constraint( "users_login",      ["login"] );
unique_constraint( "users_session_id", ["session_id"] );

has_many
    orders  => "YACT::DB::Result::Order",
    user_id => {
    cascade_copy   => 0,
    cascade_delete => 0
    };

has_many
    participations => "YACT::DB::Result::Participation",
    user_id        => {
    cascade_copy   => 0,
    cascade_delete => 0
    };

has_many
    rights  => "YACT::DB::Result::Right",
    user_id => {
    cascade_copy   => 0,
    cascade_delete => 0
    };

has_many
    talks   => "YACT::DB::Result::Talk",
    user_id => {
    cascade_copy   => 0,
    cascade_delete => 0
    };

has_many
    user_talks => "YACT::DB::Result::UserTalk",
    user_id    => {
    cascade_copy   => 0,
    cascade_delete => 0
    };

1;
