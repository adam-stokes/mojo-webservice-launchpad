## Please see file perltidy.ERR
package Mojo::WebService::Launchpad::Resource::Bug;

use Mojo::Base 'Mojo::WebService::Launchpad::Client', -async_await;
use Mojo::WebService::Launchpad::Model::Bug;

async sub by_id {
    my ( $self, $id ) = @_;
    my $result =
        await $self->get( sprintf( "%s/bugs/%s", $self->api_url, $id ) );
    return Mojo::WebService::Launchpad::Model::Bug->new(
        bug    => $result->res->json,
        client => $self
    );
}
1;
