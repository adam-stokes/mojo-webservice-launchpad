package Net::Launchpad::Model::Query::Person;

# ABSTRACT: Person/people query model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    use Net::Launchpad::Query;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $query = Net::Launchpad::Query->new(lpc => $c);
    my $res = $query->people->get_by_email('deez@example.com');

    print "Name: ". $res->result->{name};


=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has '+ns' => (is => 'ro', default => 'people');

__PACKAGE__->meta->make_immutable;

1;
