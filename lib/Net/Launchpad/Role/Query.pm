package Net::Launchpad::Role::Query;

# ABSTRACT: Common pure query roles

use Moose::Role;
use Function::Parameters;
use Data::Dumper::Concise;
use Mojo::Parameters;

has result => (is => 'rw');

=attr ns

Namespace to query for, ie ('bugs'), is overridden in query roles.

=cut

has ns => (is => 'rw');

=method _build_resource_path

Builds a resource path with params encoded

=cut

method _build_resource_path ($search_name, $params) {
    my $uri = $self->lpc->__path_cons($search_name);
    return $uri->query($params);
}

=method resource

Returns resource of C<name>

=cut

method resource ($params) {
    my $uri = $self->_build_resource_path($self->ns, $params);
    $self->result($self->lpc->get($uri->to_string));
    return $self;
}

1;
