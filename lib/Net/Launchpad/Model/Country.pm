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
use namespace::autoclean;
extends 'Net::Launchpad::Model::Base';

__PACKAGE__->meta->make_immutable;
1;

