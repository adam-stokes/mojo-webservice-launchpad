package Net::Launchpad::Model::Branch;
# ABSTRACT: Branch Model

use Moose;
use Function::Parameters;
use namespace::autoclean;

with 'Net::Launchpad::Query';
extends 'Net::Launchpad::Model::Base';

=method get_by_unique_name

Find a branch by its ~owner/product/name unique name.

B<Params>

=for :list
* C<Str name>

=cut

method get_by_unique_name (Str $name) {
    my $params = {
        'ws.op'     => 'getByUniqueName',
        unique_name => $name
    };
    return $self->resource($params);
}

=method get_by_url

Find a branch by URL.

Either from the external specified in Branch.url, from the URL on
http://bazaar.launchpad.net/ or the lp: URL.

B<Params>

=for :list
* C<Str url>

=cut

method get_by_url (Str $url) {
    my $params = {
        'ws.op' => 'getByUrl',
        url     => $url
    };
    return $self->resource($params);
}

=method get_by_urls

Finds branches by URL.

Either from the external specified in Branch.url, from the URL on
http://bazaar.launchpad.net/, or from the lp: URL.

B<Params>

=for :list
* C<ArrayRef urls>

=cut

method get_by_urls (ArrayRef $urls) {
    my $params = {
        'ws.op' => 'getByUrls',
        urls    => join(',', @{$urls})
    };
    return $self->resource($params);
}

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

__PACKAGE__->meta->make_immutable;
1;

__END__
