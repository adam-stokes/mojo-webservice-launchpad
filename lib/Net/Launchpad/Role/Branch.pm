package Net::Launchpad::Role::Branch;

# ABSTRACT: Branch Roles

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Role::Common';

=method dependent_branches

Collection of merge proposals that are dependent on this branch

=cut

method dependent_branches {
    return $self->collection('dependent_branches');
}

=method landing_candidates

Collection of merge proposals where this branch is target branch

=cut

method landing_candidates {
    return $self->collection('landing_candidates');
}

=method landing_targets

Collection of merge proposals where this branch is source branch

=cut

method landing_target {
    return $self->collection('landing_targets');
}

=method reviewer

Reviewer team associated with this branch

=cut
method reviewer {
    return $self->resource('reviewer');
}


=method sourcepackage

Source package that this branch belongs too

=cut
method sourcepackage {
  return $self->resource('sourcepackage');
}

=method subscribers

Persons subscribed to this branch

=cut
method subscribers {
  return $self->collection('subscribers');
}

=method subscriptions

Branch subscriptions related to this branch

=cut
method subscriptions {
  return $self->collection('subscriptions');
}

=method spec

Specification linked to this branch

=cut
method spec {
  return $self->collection('spec');
}
1;
