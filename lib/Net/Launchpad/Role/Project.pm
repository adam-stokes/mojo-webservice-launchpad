package Net::Launchpad::Role::Project;

use Mojo::Base 'Net::Launchpad::Role::Common';

sub bug_supervisor {
    return $self->resource('bug_supervisor');
}
1;
