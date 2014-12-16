package Net::Launchpad::Model::Country;

# ABSTRACT: Country model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $country = $c->country('US');

    print "Name: ". $country->result->{name};

=head1 DESCRIPTION

Container for countries

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;
extends 'Net::Launchpad::Model::Base';

has country_code => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->lpc->get(
        sprintf("%s/+countries/%s", $self->lpc->api_url, $self->country_code)
    );
}

__PACKAGE__->meta->make_immutable;
1;

