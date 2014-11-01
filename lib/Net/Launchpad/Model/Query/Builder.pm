package Net::Launchpad::Model::Query::Builder;

# ABSTRACT: Builder query model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    use Net::Launchpad::Query;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $query = Net::Launchpad::Query->new(lpc => $c);
    my $res = $query->builders->all;

    print "Num of Available Builders: ". $res->result->{total_size};


=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has '+ns' => (is => 'ro', default => 'builders');

__PACKAGE__->meta->make_immutable;

1;
