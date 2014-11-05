package Net::Launchpad::Role::Project;

# ABSTRACT: Project roles

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Role::Common';

=method bug_supervisor_link

Bug supervisor

=cut

method bug_supervisor {
    return $self->resource('bug_supervisor');
}
1;
