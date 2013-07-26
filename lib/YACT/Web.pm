package YACT::Web;

use Yeb;

plugin '+YACT::Web::Plugin';

r "" => sub {
  my $base = req->base;
  text($base, "=>", ya()->config->root);
};

r "" => sub {
  text "Not found";
};

1;