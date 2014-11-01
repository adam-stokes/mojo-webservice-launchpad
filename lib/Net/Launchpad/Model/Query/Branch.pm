package Net::Launchpad::Model::Query::Branch;

# ABSTRACT: Branch query model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    use Net::Launchpad::Query;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $query = Net::Launchpad::Query->new(lpc => $c);
    my $res = $query->branches->get_by_unique_name('~adam-stokes/+junk/cloud-installer');

    print "Name: ". $res->result->{unique_name};


=cut


use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has '+ns' => (is => 'ro', default => 'branches');

__PACKAGE__->meta->make_immutable;
1;
