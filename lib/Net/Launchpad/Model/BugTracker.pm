package Net::Launchpad::Model::BugTracker;

# ABSTRACT: BugTracker Model

use Moose;
use Function::Parameters;
use namespace::autoclean;
with 'Net::Launchpad::Query';
extends 'Net::Launchpad::Model::Base';

=method watches

Returns remote watches collection

=cut

method watches {
    return $self->collection('watches');
}

__PACKAGE__->meta->make_immutable;
1;

__END__

