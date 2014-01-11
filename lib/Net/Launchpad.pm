package Net::Launchpad;

use Mojo::Base -base;
use Mojo::UserAgent;
use Mojo::JSON;
use Mojo::URL;
use Mojo::Parameters;
use DDP;
our $VERSION = '1.0.0';

has 'staging' => 0;
has 'consumer_key';
has 'callback_uri';

has 'json' => sub {
    my $self = shift;
    my $json = Mojo::JSON->new;
    return $json;
};

has 'ua' => sub {
    my $self = shift;
    my $ua = Mojo::UserAgent->new;
    $ua->transactor->name("Net::Salesforce/$VERSION");
    return $ua;
};

has 'nonce' => sub {
    my $self  = shift;
    my @a     = ('A' .. 'Z', 'a' .. 'z', 0 .. 9);
    my $nonce = '';
    for (0 .. 31) {
        $nonce .= $a[rand(scalar(@a))];
    }
    return $nonce;
};

has 'params' => sub {
    my $self = shift;
    return {
        oauth_callback         => $self->callback_uri,
        oauth_consumer_key     => $self->consumer_key,
        oauth_version          => '1.0a',
        oauth_signature_method => 'PLAINTEXT',
        oauth_signature        => '&',
        oauth_token            => undef,
        oauth_token_secret     => undef,
        oauth_timestamp        => time,
        oauth_nonce            => $self->nonce
    };
};

sub api_host {
    my $self = shift;
    if ($self->staging) {
        return Mojo::URL->new('https://staging.launchpad.net');
    }
    return Mojo::URL->new('https://launchpad.net/');
}

sub request_token_path {
    my $self = shift;
    return $self->api_host->path('+request-token');
}

sub access_token_path {
    my $self = shift;
    return $self->api_host->path('+access-token');
}

sub authorize_token_path {
    my $self = shift;
    return $self->api_host->path('+authorize-token');
}

sub request_token {
    my $self = shift;
    my $tx =
      $self->ua->post(
        $self->request_token_path->to_string => form => $self->params);
    die $tx->res->body unless $tx->success;
    my $params = Mojo::Parameters->new($tx->res->body);
    my $token = $params->param('oauth_token');
    my $secret = $params->param('oauth_token_secret');
    return ($token, $secret);
}

sub authorize_token {
    my ($self, $token, $token_secret) = @_;
    $self->params->{oauth_token} = $token;
    $self->params->{oauth_token_secret} = $token_secret;
    my $url = $self->authorize_token_path->query($self->params);
    return $url->to_string;
}

sub access_token {
    my ($self, $token, $secret) = @_;
    $self->params->{oauth_token} = $token;
    $self->params->{oauth_token_secret} = $secret;
    $self->params->{oauth_signature} =
      '&' . $secret;
    my $tx =
      $self->ua->post(
        $self->access_token_path->to_string => form => $self->params);
    die $tx->res->body unless $tx->success;
    my $params = Mojo::Parameters->new($tx->res->body);
    return ($params->param('oauth_token'), $params->param('oauth_token_secret'));
}

1;

=head1 NAME

Net::Launchpad - Launchpad.net OAuth 1.0

=head1 SYNOPSIS

OAuth 1.0a authorization and client for Launchpad.net

=head1 ATTRIBUTES

L<Net::Launchpad> implements the following attributes:

=head2 B<staging>

Boolean to interact with staging server or production.

=head2 B<ua>

A L<Mojo::UserAgent>.

=head2 B<json>

A L<Mojo::JSON>.

=head2 B<consumer_key>

Holds the string that identifies your application.

    $lp->consumer_key('my-app-name');

=head2 B<callback_uri>

Callback url to redirect use back to once authenticated.

=head2 B<nonce>

Nonce

=head2 B<params>

OAuth 1.0a parameters used in request, authenticate, and access

=head1 METHODS

=head2 B<api_host>

Hostname used for authentication

=head2 B<access_token_path>

OAuth Access token url

=head2 B<authorize_token_path>

OAuth Authorize token url

=head2 B<request_token_path>

OAuth Request token url

=head2 B<request_token>

Perform the request-token request

=head2 B<authenticate_token>

Perform the authentication request

=head2 B<access_token>

Perform the access token request

=head1 AUTHOR

Adam Stokes, C<< <adamjs at cpan.org> >>

=head1 BUGS

Report bugs to https://github.com/battlemidget/Net-Launchpad/issues.

=head1 DEVELOPMENT

=head2 Repository

    http://github.com/battlemidget/Net-Launchpad

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Launchpad

=head1 SEE ALSO

=over 4

=item * L<https://launchpad.net/launchpadlib>, "Python implementation"

=back

=head1 COPYRIGHT

Copyright 2013-2014 Adam Stokes

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


