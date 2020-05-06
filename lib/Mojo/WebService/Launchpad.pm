package Mojo::WebService::Launchpad;

use Mojo::Base -base;
use Mojo::UserAgent;
use Mojo::URL;
use Mojo::Parameters;

our $VERSION = '0.01';

has 'staging';
has 'consumer_key' => 'perl-net-launchpad';
has 'callback_uri';

has ua => sub {
    my $self = shift;
    my $ua   = Mojo::UserAgent->new;
    $ua->transactor->name("perl-net-launchpad");
    return $ua;
};

has params => sub {
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
            oauth_nonce            => $self->nonce()
        };
};

sub nonce {
    my @a     = ( 'A' .. 'Z', 'a' .. 'z', 0 .. 9 );
    my $nonce = '';
    for ( 0 .. 31 ) {
        $nonce .= $a[ rand( scalar(@a) ) ];
    }
    return $nonce;
}

sub api_host {
    my $self = shift;
    return Mojo::URL->new('https://launchpad.net/') unless $self->staging;
    return Mojo::URL->new('https://staging.launchpad.net');
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
        $self->request_token_path->to_string => form => $self->params );
    die $tx->res->body unless $tx->result->is_success;
    my $params = Mojo::Parameters->new( $tx->res->body );
    my $token  = $params->param('oauth_token');
    my $secret = $params->param('oauth_token_secret');
    return ( $token, $secret );
}

sub authorize_token {
    my ( $self, $token, $token_secret ) = @_;
    $self->params->{oauth_token}        = $token;
    $self->params->{oauth_token_secret} = $token_secret;
    my $url = $self->authorize_token_path->query( $self->params );
    return $url->to_string;
}

sub access_token {
    my ( $self, $token, $secret ) = @_;
    $self->params->{oauth_token}        = $token;
    $self->params->{oauth_token_secret} = $secret;
    $self->params->{oauth_signature}    = '&' . $secret;
    my $tx =
      $self->ua->post(
        $self->access_token_path->to_string => form => $self->params );
    # die $tx->res->body unless $tx->result->is_error;
    my $params = Mojo::Parameters->new( $tx->res->body );
    return ( $params->param('oauth_token'),
        $params->param('oauth_token_secret') );
}

1;

=head1 NAME

Net-Launchpad - API Client to launchpad.net

=head1 AUTHOR

Adam Stokes E<lt>adamjs@cpan.orgE<gt>
