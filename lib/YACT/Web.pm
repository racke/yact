package YACT::Web;
use Dancer ':syntax';
use YACT;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

hook 'before' => sub {
    if ( !session('user') && request->path_info !~ m{^/LOGIN} ) {
        session( login_continue => request->path_info );
        request->path_info('/LOGIN');
    }
};

get '/LOGIN' => sub {
    template 'login', { path => session('login_continue'), };
};

post '/LOGIN' => sub {
    my $self      = shift;
    my $y         = YACT->new;
    my $this_user = $y->get_user( params->{user} );

    return redirect '/LOGIN?failed=1' unless defined $this_user;

    if ( $this_user->check_passwd( params->{pass} ) ) {
        session user => $this_user;
        redirect params->{path} || '/';
    }
    else {
        redirect '/LOGIN?failed=1';
    }
};

get '/LOGOUT' => sub {
    session->destroy;
    redirect '/';
};

get '/user' => sub {
    redirect '/user/' . session->{user_id};
};

get '/user/:user_id' => sub {
    my $yact = YACT->new;
    my $user = $yact->get_user_by_id( params->{user_id} );

    template 'user', { user => $user };
};

true;
