package Dancer::Plugin::Auth::Extensible::Provider::YACT;

use strict;
use parent 'Dancer::Plugin::Auth::Extensible::Provider::Base';

=head1 NAME

Dancer::Plugin::Auth::Extensible::YACT - authentication provider for
YACT


=head1 DESCRIPTION



See L<Dancer::Plugin::Auth::Extensible> for details on how to use the
authentication framework, including how to pick a more useful
authentication provider.

However, if you just want to test the framework, or want an example to
work from to build your own authentication provider class, this may be
of use.

=cut

=head1 Class methods

=over

=item authenticate_user

Given the username and password entered by the user, return true if
they are authenticated, or false if not.

=cut

sub authenticate_user {
    my ( $self, $username, $password ) = @_;

    my $user_details = $self->yact->get_user($username) or return;
    return $user_details->check_passwd($password);
}

=item get_user_details

Given a username, return details about the user.  The details returned
will vary depending on the provider; some providers may be able to
return various data about the user, some may not, depending on the
authentication source.

Details should be returned as a hashref.

=cut

sub get_user_details {
    my ( $self, $username ) = @_;

    return $self->yact->get_user($username);
}

=item get_user_roles

Given a username, return a list of roles that user has.

=cut

sub get_user_roles {
    my ( $self, $username ) = @_;

    my $user = $self->get_user_details($username) or return;
    return $user->rights();
}

1;
