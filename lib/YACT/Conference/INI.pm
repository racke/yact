package YACT::Conference::INI;

use Moo;
use Config::INI::Reader;

has conf_id      => ( is => 'ro', required => 1, );
has master_files => ( is => 'ro', required => 1, );
has ini_files    => ( is => 'ro', required => 1, );

sub BUILDARGS {
    my ( $class, @args ) = @_;
    return $args[0] if ref $args[0] eq 'HASH';
    die __PACKAGE__ . "->new Requires conf_id and 2 arrays with ini files"
        unless scalar @args == 3;
    die __PACKAGE__ . "->new 2nd and 3rd argument must be an array"
        unless ref $args[1] eq 'ARRAY' and ref $args[2] eq 'ARRAY';
    return {
        conf_id      => shift @args,
        master_files => shift @args,
        ini_files    => shift @args,
    };
}

has data => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my ($self) = @_;
        my %data;
        for ( @{ $self->master_files } ) {
            my $master_data = Config::INI::Reader->read_file($_);
            if ( defined $master_data->{ $self->conf_id } ) {
                for ( keys %{ $master_data->{ $self->conf_id } } ) {
                    $data{$_} = $master_data->{ $self->conf_id }->{$_};
                }
            }
            for ( keys %{$master_data} ) {
                my $cid = $self->conf_id;
                if ( $_ =~ /^$cid\/(.*)$/ ) {
                    $data{$1} = {} unless defined $data{$1};
                    for my $k ( keys %{ $master_data->{$_} } ) {
                        $data{$1}->{$k} = $master_data->{$_}->{$k};
                    }
                }
            }
        }
        for ( @{ $self->ini_files } ) {
            my $ini_data = Config::INI::Reader->read_file($_);
            for ( keys %{ $ini_data->{_} } ) {
                $data{$_} = $ini_data->{_}->{$_};
            }
            for ( keys %{$ini_data} ) {
                next if $_ eq '_';
                $data{$_} = {} unless defined $data{$_};
                for my $k ( keys %{ $ini_data->{$_} } ) {
                    $data{$_}->{$k} = $ini_data->{$_}->{$k};
                }
            }
        }
        return \%data;
    }
);

1;
