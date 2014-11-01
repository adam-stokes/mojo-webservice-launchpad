package Net::Launchpad::Role::Bug;

# ABSTRACT: Bug roles

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Role::Common';

=method tasks

Returns a list of entries in the tasks object.

=cut

method tasks {
    return $self->collection('bug_tasks');
}

=method watches

Returns bug watch collection

=cut

method watches {
    return $self->collection('bug_watches');
}

=method attachments

Returns list of bug attachments

=cut

method attachments {
    return $self->collection('attachments');
}

=method activity

Returns a bug activity collection

=cut

method activity {
    return $self->collection('activity');
}

=method duplicate_of

Returns a bug resource that the specific bug is a duplicate of

=cut

method duplicate_of {
    return $self->resource('duplicate_of');
}

=method messages

Returns bug messages associated with Bug.

=cut

method messages {
    return $self->collection('messages');
}

1;
