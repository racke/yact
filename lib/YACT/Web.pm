package YACT::Web;
use Dancer ':syntax';
use YACT::DB;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

hook 'before' => sub {
    if ( !session('user') ) {
        var requested_path => request->path_info;
        request->path_info('/LOGIN');
    }
};

get '/LOGIN' => sub {

    # Display a login page; the original URL they requested is available as
    # vars->{requested_path}, so could be put in a hidden field in the form
    template 'login', { path => vars->{requested_path} };
};

post '/LOGIN' => sub {

    # Validate the username and password they supplied
    if ( params->{user} eq 'bob' && params->{pass} eq 'letmein' ) {
        session user => params->{user};
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
    my $user_id = params->{user_id};

    template 'user';
};

true;
