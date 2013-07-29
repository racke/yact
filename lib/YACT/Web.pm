package YACT::Web;

use Yeb;

has yact => ( is => 'ro', lazy => 1, builder => sub { YACT->new } );

has conf => ( is => 'rw', clearer => 'reset_conf' );

sub BUILD {
    my ($self) = @_;
    $self->yeb->register_function( 'yact', sub { $self->yact } );
    $self->yeb->register_function( 'conf', $self->can('conf') );
}

r "" => sub {
    for my $base ( sort { length($b) <=> length($a) }
        keys %{ yact()->url_bases } )
    {
        my $req_path = ( req->base ) . ( substr( req->path_info, 1, -1 ) );
        use DDP;
        p($req_path);
        p($base);
        if ( $req_path =~ m/^$base(.*)/ ) {
            print "HAHAHAHHAHAH";
            cc->uri_base( URI->new( $base . '/' ) );
            my $target = yact()->url_bases->{$base};
            if ( $target->isa('YACT::Conference') ) {
                conf($target);
                print "HAHAHAHHAAH";
                use DDP;
                p($target);
                chain "Conference";
                return;
            }
        }
    }
    return;
};

r "" => sub {
    text "Not found";
};

1;
