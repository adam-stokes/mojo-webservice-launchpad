package Net::Launchpad::Role::Distribution;

# ABSTRACT: Distribution roles

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Role::Common';


=method active_milestones

Active milestones associated with object

=cut
method active_milestones {
  return $self->collection('active_milestones');
}


=method all_milestones

All milestones associated with object

=cut

method all_milestones {
    return $self->collection('all_milestones');
}

=method archive_mirrors

All enabled archive mirrors for distribution

=cut
method archive_mirrors {
  return $self->collection('archive_mirrors');
}

=method archives

primary, partner, debug archives

=cut
method archive {
  return $self->collection('archives');
}

=method bug_supervisor

bug manager for distribution

=cut
method bug_supervisor {
  return $self->resource('bug_supervisor');
}

=method cdimage_mirrors

mirrors for this distribution

=cut
method cdimage_mirrors {
  return $self->collection('cdimage_mirrors');
}

=method current_series

current development series of distribution

=cut
method current_series {
  return $self->collection('current_series');
}

=method derivatives

distribution derivatives

=cut
method derivatives {
  return $self->collection('derivatives');
}

=method driver

person/team responsible for distribution

=cut
method driver {
  return $self->resource('driver');
}

=method main_archive

distribution main archive

=cut
method main_archive {
  return $self->resource('main_archive');
}

=method members

distro members

=cut
method members {
  return $self->resource('members');
}

=method mirror_admin

person/team that has rights to mark this distro official

=cut
method mirror_admin {
  return $self->resource('mirror_admin');
}

=method series

distroseries inside distribution

=cut
method series {
  return $self->collection('series');
}

1;
