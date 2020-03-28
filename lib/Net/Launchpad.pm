package Net::Launchpad;

# ABSTRACT: Launchpad.net Authentication

use Mojo::Base -base -signatures;
use Mojo::UserAgent;
use Mojo::URL;
use Mojo::Parameters;
use Data::Dumper::Concise;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:ADAMJS';

has staging => 0;
has consumer_key;
has callback_uri;

has ua => sub {
    my $ua = Mojo::UserAgent->new;
    $ua->transactor->name("perl-net-launchpad");
    return $ua;
};

has nonce => sub {
    my @a     = ( 'A' .. 'Z', 'a' .. 'z', 0 .. 9 );
    my $nonce = '';
    for ( 0 .. 31 ) {
        $nonce .= $a[ rand( scalar(@a) ) ];
    }
    return $nonce;
};

has params => sub {
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
    return Mojo::URL->new('https://launchpad.net/') unless $self->staging;
    return Mojo::URL->new('https://staging.launchpad.net');
}

sub request_token_path {
    return $self->api_host->path('+request-token');
}

sub access_token_path {
    return $self->api_host->path('+access-token');
}

sub authorize_token_path {
    return $self->api_host->path('+authorize-token');
}

sub request_token {
    my $tx =
      $self->ua->post(
        $self->request_token_path->to_string => form => $self->params );
    die $tx->res->body unless $tx->success;
    my $params = Mojo::Parameters->new( $tx->res->body );
    my $token  = $params->param('oauth_token');
    my $secret = $params->param('oauth_token_secret');
    return ( $token, $secret );
}

sub authorize_token ( $token, $token_secret ) {
    $self->params->{oauth_token}        = $token;
    $self->params->{oauth_token_secret} = $token_secret;
    my $url = $self->authorize_token_path->query( $self->params );
    return $url->to_string;
}

sub access_token ( $token, $secret ) {
    $self->params->{oauth_token}        = $token;
    $self->params->{oauth_token_secret} = $secret;
    $self->params->{oauth_signature}    = '&' . $secret;
    my $tx =
      $self->ua->post(
        $self->access_token_path->to_string => form => $self->params );
    die $tx->res->body unless $tx->success;
    my $params = Mojo::Parameters->new( $tx->res->body );
    print Dumper($params);
    return ( $params->param('oauth_token'),
        $params->param('oauth_token_secret') );
}

1;

=head1 AUTHOR

Adam Stokes E<lt>adamjs@cpan.orgE<gt>
