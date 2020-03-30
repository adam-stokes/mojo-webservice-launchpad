package Net::Launchpad::Role::Branch;

use Mojo::Base 'Net::Launchpad::Role::Common';

sub dependent_branches {
    return $self->collection('dependent_branches');
}

sub landing_candidates {
    return $self->collection('landing_candidates');
}

sub landing_target {
    return $self->collection('landing_targets');
}

sub reviewer {
    return $self->resource('reviewer');
}

sub sourcepackage {
  return $self->resource('sourcepackage');
}

sub subscribers {
  return $self->collection('subscribers');
}

sub subscriptions {
  return $self->collection('subscriptions');
}

sub spec {
  return $self->collection('spec');
}

1;
