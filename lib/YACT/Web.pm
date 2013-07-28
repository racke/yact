package YACT::Web;

use Yeb;

has yact => ( is => 'ro', lazy => 1, builder => sub { YACT->new } );

sub BUILD {
    my ($self) = @_;
    $self->yeb->register_function(
        'ya',
        sub {
            $self->yact;
        }
    );
}

r "" => sub {
    my $base = req->base;
    my $urls = ya()->url_bases;
    use DDP;
    p($urls);
    return;
};

r "" => sub {
    text "Not found";
};

1;
