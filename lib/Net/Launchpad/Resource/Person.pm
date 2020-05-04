package Net::Launchpad::Resource::Person;

use Mojo::Base 'Net::Launchpad::Client';
use Net::Launchpad::Model::Person;

sub by_name {
    my ( $self, $name ) = @_;
    return $self->get( sprintf( "%s/%s", $self->api_url, $name ) )->then(
        sub {
            my $mojo = shift;
            return Net::Launchpad::Model::Person->new(
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
                  Net::Launchpad::Model::Person->new(
                    person => $item,
                    client => $self
                  );
            }
            return \@records;
        }
    );
}
1;
