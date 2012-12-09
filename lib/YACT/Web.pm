package YACT::Web;
use Dancer ':syntax';
use YACT;

our $VERSION = '0.1';
our $YACT    = YACT->new;

get '/' => sub {
    template 'index';
};

hook 'before' => sub {
    if ( !session('user') && request->path_info !~ m{^/login} ) {
        session( login_continue => request->path_info );
        request->path_info('/login');
    }
};

get '/LOGIN' => sub { redirect '/login'; };

get '/login' => sub {
    template 'login', { path => session('login_continue'), };
};

post '/login' => sub {
    my $self      = shift;
    my $this_user = $YACT->get_user( params->{user} );

    return redirect '/login?failed=1' unless defined $this_user;

    if ( $this_user->check_passwd( params->{pass} ) ) {
        session user => $this_user;
        redirect params->{path} || '/';
    }
    else {
        redirect '/login?failed=1';
    }
};

get '/LOGOUT' => sub {
    session->destroy;
    redirect '/';
};

get '/user' => sub {
    my $user    = session('user');
    my $user_id = $user->user_id;

    redirect '/user/' . $user_id;
};

get '/user/:user_id' => sub {
    my $user = $YACT->get_user_by_id( params->{user_id} );

    template 'user', { user => $user };
};

get '/photo' => sub {
    my $user = session('user');

    }

    true;
