## Please see file perltidy.ERR
package Mojo::WebService::Launchpad::Resource::Bug;

use Mojo::Base 'Mojo::WebService::Launchpad::Client';
use Mojo::WebService::Launchpad::Model::Bug;

sub by_id {
    my ( $self, $id ) = @_;
    return $self->get( sprintf( "%s/bugs/%s", $self->api_url, $id ) )->then(
        sub {
            my $mojo = shift;
            return Mojo::WebService::Launchpad::Model::Bug->new(
                bug    => $mojo->res->json,
                client => $self
            );
        }
    );
}
1;
