package Net::Launchpad;

# ABSTRACT: Launchpad.net Authentication

use Moose;
use Function::Parameters;
use Mojo::UserAgent;
use Mojo::URL;
use Mojo::Parameters;
use Data::Dumper::Concise;
use namespace::autoclean;


=attr B<staging>

Boolean to interact with staging server or production.

=attr B<ua>

A L<Mojo::UserAgent>.

=attr B<json>

A L<Mojo::JSON>.

=attr B<consumer_key>

Holds the string that identifies your application.

    $lp->consumer_key('my-app-name');

=attr B<callback_uri>

Callback url to redirect use back to once authenticated.

=attr B<nonce>

Nonce

=attr B<params>

OAuth 1.0a parameters used in request, authenticate, and access

=cut
has staging => (is => 'ro', isa => 'Int', default => 0);
has consumer_key => (is => 'ro', isa => 'Str');
has callback_uri => (is => 'ro', isa => 'Str');

has ua => (
    is      => 'ro',
    isa     => 'Mojo::UserAgent',
    default => method {
        my $ua = Mojo::UserAgent->new;
        $ua->transactor->name("Net::Salesforce");
        return $ua;
    }
);


has nonce => (is => 'ro', isa => 'Str', builder => '_build_nonce');

method _build_nonce {
    my @a = ('A' .. 'Z', 'a' .. 'z', 0 .. 9);
    my $nonce = '';
    for (0 .. 31) {
        $nonce .= $a[rand(scalar(@a))];
    }
    return $nonce;
}


has params => (is => 'rw', isa => 'HashRef', builder => '_build_params');

method _build_params {
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
}

=method B<api_host>

Hostname used for authentication

=cut
method api_host {
    return Mojo::URL->new('https://launchpad.net/') unless $self->staging;
    return Mojo::URL->new('https://staging.launchpad.net');
}

=method B<request_token_path>

OAuth Request token url

=cut
method request_token_path {
    return $self->api_host->path('+request-token');
}

=method B<access_token_path>

OAuth Access token url

=cut
method access_token_path {
    return $self->api_host->path('+access-token');
}

=method B<authorize_token_path>

OAuth Authorize token url

=cut
method authorize_token_path {
    return $self->api_host->path('+authorize-token');
}

=method B<request_token>

Perform the request-token request

=cut
method request_token {
    my $tx =
      $self->ua->post(
        $self->request_token_path->to_string => form => $self->params);
    die $tx->res->body unless $tx->success;
    my $params = Mojo::Parameters->new($tx->res->body);
    my $token = $params->param('oauth_token');
    my $secret = $params->param('oauth_token_secret');
    return ($token, $secret);
}

=method B<authenticate_token>

Perform the authentication request

=cut
method authorize_token($token, $token_secret) {
    $self->params->{oauth_token} = $token;
    $self->params->{oauth_token_secret} = $token_secret;
    my $url = $self->authorize_token_path->query($self->params);
    return $url->to_string;
}

=method B<access_token>

Perform the access token request

=cut
method access_token($token, $secret) {
    $self->params->{oauth_token} = $token;
    $self->params->{oauth_token_secret} = $secret;
    $self->params->{oauth_signature} =
      '&' . $secret;
    my $tx =
      $self->ua->post(
        $self->access_token_path->to_string => form => $self->params);
    die $tx->res->body unless $tx->success;
    my $params = Mojo::Parameters->new($tx->res->body);
    print Dumper($params);
    return ($params->param('oauth_token'), $params->param('oauth_token_secret'));
}

__PACKAGE__->meta->make_immutable;
1;

