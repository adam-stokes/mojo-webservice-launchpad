package Net::Launchpad::Model::Project;
# ABSTRACT: Project Model interface

=head1 DESCRIPTION

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $project = $c->project('sosreport');

    print "Name: ". $project->result->{name};

=cut
use Moose;
use Function::Parameters;
use namespace::autoclean;

with 'Net::Launchpad::Query';
extends 'Net::Launchpad::Model::Base';

=method search

Search through the Registry database for products that match the query
terms. text is a piece of text in the title / summary / description
fields of product.

B<Params>

=for :list
* C<Str text>

=cut

method search (Str $text) {
    my $params = {
        'ws.op' => 'search',
        text    => $text
    };
    return $self->resource($params);
}

=method latest

Return latest registered projects

=cut

method latest {
    my $params = {
        'ws.op' => 'latest'
    };
    return $self->resource($params);
}

__PACKAGE__->meta->make_immutable;
1;
