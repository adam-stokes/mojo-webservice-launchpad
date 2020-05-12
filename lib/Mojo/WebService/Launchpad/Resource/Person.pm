package Mojo::WebService::Launchpad::Resource::Person;

# ABSTRACT: Person Resource

use Mojo::Base 'Mojo::WebService::Launchpad::Client', -async_await;
use Mojo::WebService::Launchpad::Model::Person;

async sub by_name {
    my ( $self, $name ) = @_;
    my $result = await $self->get( sprintf( "%s/%s", $self->api_url, $name ) );
    return Mojo::WebService::Launchpad::Model::Person->new(
        person => $result->res->json,
        client => $self
    );
}

async sub find {
      my ( $self, $search ) = @_;
      my $params = {
          'ws.op' => 'find',
          text    => $search
      };
      my @records = ();
      my $uri =
        $self->build_uri( sprintf( "%s/%s", $self->api_url, 'people' ) );
      my $result = await $self->get( $uri->query($params)->to_string );
      foreach my $item ( $result->res->json->{entries} ) {
          push @records,
            Mojo::WebService::Launchpad::Model::Person->new(
              person => $item,
              client => $self
            );
      }
      return \@records;
}
1;
