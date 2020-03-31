package Net::Launchpad::Resource::Person;

use Mojo::Base 'Net::Launchpad::Client';
use Net::Launchpad::Model::Person;
use Data::Dumper::Concise;

sub by_name {
    my ( $self, $name ) = @_;
    return Net::Launchpad::Model::Person->new(
        person => $self->get( sprintf( "%s/%s", $self->api_url, $name ) ),
        client => $self);
}

sub find {
    my ($self, $search ) = @_;
    my $params = {
        'ws.op' => 'find',
            text => $search
    };
    my @records = ();
    my $uri = $self->build_uri(sprintf("%s/%s", $self->api_url, 'people'));
    my $results = $self->get($uri->query($params)->to_string);
    foreach my $item ($results->{entries}) {
       push @records, Net::Launchpad::Model::Person->new(
            person => $item->[0],
            client => $self
            );
    }
    return \@records;
}

1;
