package Net::Launchpad::Model::Person;
# ABSTRACT: Person model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $person = $c->person('~adam-stokes');

    print "Name: ". $person->result->{name};

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;
extends 'Net::Launchpad::Model::Base';

has username => (is => 'ro', isa => 'Str');

method BUILD {
  return $self->lpc->get(sprintf("%s/%s", $self->lpc->api_url, $self->username));
}

__PACKAGE__->meta->make_immutable;
1;

