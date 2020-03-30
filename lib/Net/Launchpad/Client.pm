package Net::Launchpad::Client;

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $lp = Net::Launchpad::Client->new(
        access_token        => '32432432432',
        access_token_secret => '32432432423432423432423232',
        consumer_key        => 'a-named-key'
    );

=cut

use Mojo::Base 'Net::Launchpad';
use Mojo::UserAgent;
use Mojo::URL;
use Mojo::JSON qw(decode_json);
use Mojo::Parameters;
use Data::Dumper::Concise;
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
    print Dumper($header);
    return $header;
};

sub api_url {
    my $self = shift;
    return Mojo::URL->new('https://api.launchpad.net/devel')
      unless $self->staging;
    return Mojo::URL->new('https://api.staging.launchpad.net/devel');
}

sub __path_cons {
    my ( $self, $path ) = @_;
    if ( $path =~ /^http.*api/ ) {
        return Mojo::URL->new($path);
    }
    return $self->api_url->path($path);
}

sub post {
    my ( $self, $resource, $params ) = @_;
    my $params_hash = Mojo::Parameters->new($params);
    my $uri         = $self->__path_cons($resource);
    my $tx =
      $self->ua->post( $uri->to_string =>
          { 'Authorization' => $self->authorization_header } => form =>
          $params_hash->to_string );
    die $tx->res->message unless $tx->result->is_success;
}

sub get {
    my ( $self, $resource ) = @_;
    my $uri = $self->__path_cons($resource);
    my $tx =
      $self->ua->get(
        $uri->to_string => { 'Authorization' => $self->authorization_header } );
    if ( $tx->result->is_success ) {
        return decode_json( $tx->res->body );
    }
    else {
        my $err = $tx->error;
        die "$err->{code} response: $err->{message}" if $err->{code};
    }
}

sub model {
    my ( $self, $class ) = @_;
    my $model = "Net::Launchpad::Model::$class";
    return load_class($model)->new($self);
}

1;
