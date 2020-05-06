package Mojo::WebService::Launchpad::Resource::Person;

use Mojo::Base 'Mojo::WebService::Launchpad::Client';
use Mojo::WebService::Launchpad::Model::Person;

sub by_name {
    my ( $self, $name ) = @_;
    return $self->get( sprintf( "%s/%s", $self->api_url, $name ) )->then(
        sub {
            my $mojo = shift;
            return Mojo::WebService::Launchpad::Model::Person->new(
                person => $mojo->res->json,
                client => $self
            );
        }
    );
}

sub find {
    my ( $self, $search ) = @_;
    my $params = {
        'ws.op' => 'find',
        text    => $search
    };
    my @records = ();
    my $uri = $self->build_uri( sprintf( "%s/%s", $self->api_url, 'people' ) );
    return $self->get( $uri->query($params)->to_string )->then(
        sub {
            my $mojo = shift;
            foreach my $item ( $mojo->res->json->{entries} ) {
                push @records,
                  Mojo::WebService::Launchpad::Model::Person->new(
                    person => $item,
                    client => $self
                  );
            }
            return \@records;
        }
    );
}
1;
