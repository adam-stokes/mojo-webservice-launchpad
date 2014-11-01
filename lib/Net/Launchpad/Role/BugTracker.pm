package Net::Launchpad::Role::BugTracker;

# ABSTRACT: Bug tracker roles

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Role::Common';

=method watches

Returns remote watches collection

=cut

method watches {
    return $self->collection('watches');
}

1;
