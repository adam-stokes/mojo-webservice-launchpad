package Mojo::WebService::Launchpad::Client;

=head1 SYNOPSIS

    use Mojo::WebService::Launchpad::Client;
    my $lp = Mojo::WebService::Launchpad::Client->new(
        access_token        => '32432432432',
        access_token_secret => '32432432423432423432423232',
        consumer_key        => 'a-named-key'
    );

=cut

use Mojo::Base 'Mojo::WebService::Launchpad';
use Mojo::Promise;
use Mojo::URL;
use Mojo::Parameters;
use Class::Load ':all';

has 'access_token';
has 'access_token_secret';

sub authorization_header {
    my $self   = shift;
    my $header = join( ",",
        'OAuth realm="https://api.launchpad.net"',
        'oauth_consumer_key=' . $self->consumer_key,
        'oauth_version=1.0',
        'oauth_signature_method=PLAINTEXT',
        'oauth_signature=' . '&' . $self->access_token_secret,
        'oauth_token=' . $self->access_token,
        'oauth_token_secret=' . $self->access_token_secret,
        'oauth_timestamp=' . time,
        'oauth_nonce=' . $self->nonce );
    return $header;
}

sub api_url {
    my $self = shift;
    return Mojo::URL->new('https://api.launchpad.net/devel')
      unless $self->staging;
    return Mojo::URL->new('https://api.staging.launchpad.net/devel');
}

sub build_uri {
    my ( $self, $path ) = @_;
    if ( $path =~ /^http.*api/ ) {
        return Mojo::URL->new($path);
    }
    return $self->api_url->path($path);
}

sub post {
    my ( $self, $resource, $params ) = @_;
    my $params_hash = Mojo::Parameters->new($params);
    my $uri         = $self->build_uri($resource);
    return $self->ua->post_p( $uri->to_string =>
          { 'Authorization' => $self->authorization_header } => form =>
          $params_hash->to_string );
}

sub get {
    my ( $self, $resource ) = @_;
    my $uri = $self->build_uri($resource);
    return $self->ua->get_p(
        $uri->to_string => { 'Authorization' => $self->authorization_header } );
}

sub resource {
    my ( $self, $class ) = @_;
    my $model = "Mojo::WebService::Launchpad::Resource::$class";
    return load_class($model)->new($self);
}

1;