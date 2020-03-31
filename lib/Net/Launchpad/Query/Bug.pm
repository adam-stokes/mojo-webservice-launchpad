package Net::Launchpad::Query::Bug;

use Mojo::Base 'Net::Launchpad::Client';
use Net::Launchpad::Model::Bug;

sub by_id {
    my ( $self, $id ) = @_;
    return Net::Launchpad::Model::Bug->new(
        bug => $self->get( sprintf( "%s/bugs/%s", $self->api_url, $id ) ),
        client => $self);
}

1;
