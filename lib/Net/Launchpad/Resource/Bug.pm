## Please see file perltidy.ERR
package Net::Launchpad::Resource::Bug;

use Mojo::Base 'Net::Launchpad::Client';
use Net::Launchpad::Model::Bug;
use Data::Dumper::Concise;

sub by_id {
    my ( $self, $id ) = @_;
    return $self->get( sprintf( "%s/bugs/%s", $self->api_url, $id ) )->then(
        sub {
            my $mojo = shift;
            return Net::Launchpad::Model::Bug->new(
                bug    => $mojo->res->json,
                client => $self
            );
        }
    );
}
1;
