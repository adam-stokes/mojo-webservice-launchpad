package Net::Launchpad::Role::Distribution;

use Mojo::Base 'Net::Launchpad::Role::Common';

sub active_milestones {
  return $self->collection('active_milestones');
}

sub all_milestones {
    return $self->collection('all_milestones');
}

sub archive_mirrors {
  return $self->collection('archive_mirrors');
}

sub archive {
  return $self->collection('archives');
}

sub bug_supervisor {
  return $self->resource('bug_supervisor');
}

sub cdimage_mirrors {
  return $self->collection('cdimage_mirrors');
}

sub current_series {
  return $self->collection('current_series');
}

sub derivatives {
  return $self->collection('derivatives');
}

sub driver {
  return $self->resource('driver');
}

sub main_archive {
  return $self->resource('main_archive');
}

sub members {
  return $self->resource('members');
}

sub mirror_admin {
  return $self->resource('mirror_admin');
}

sub series {
  return $self->collection('series');
}

1;
