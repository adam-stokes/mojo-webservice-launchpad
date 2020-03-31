package Net::Launchpad::Query::Person;

use Mojo::Base 'Net::Launchpad::Client';
use Net::Launchpad::Model::Person;

sub by_name {
    my ( $self, $name ) = @_;
    return Net::Launchpad::Model::Person->new(
        person => $self->get( sprintf( "%s/%s", $self->api_url, $name ) ),
        client => $self);
}

1;
