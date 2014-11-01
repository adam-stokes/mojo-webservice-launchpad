package Net::Launchpad::Role::Query::Project;

# ABSTRACT: Project query role

use Moose::Role;
use Function::Parameters;
use Data::Dumper::Concise;

with 'Net::Launchpad::Role::Query';

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

1;
