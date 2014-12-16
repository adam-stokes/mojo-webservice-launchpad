package Net::Launchpad::Model::Archives;

# ABSTRACT: Top level Archives Model

use Moose;
use Function::Parameters;
use namespace::autoclean;
with 'Net::Launchpad::Query';
extends 'Net::Launchpad::Model::Base';

=method get_by_reference

Return IArchive with given archive reference

B<Params>

=for :list
* C<Str reference_str>

=cut

method get_by_reference (Str $reference_str) {
    my $params = {
        'ws.op'   => 'getByReference',
        reference => $reference_str
    };
    return $self->resource($params);
}

__PACKAGE__->meta->make_immutable;
1;
