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

=method get_ppa_by_name

Get PPA for owner

B<Params>

=for :list
* C<Str name>

=cut

method get_ppa_by_name (Str $name) {
    my $params = {
        'ws.op' => 'getPPAByName',
        name    => $name
    };
    return $self->resource($params);
}

__PACKAGE__->meta->make_immutable;
1;

