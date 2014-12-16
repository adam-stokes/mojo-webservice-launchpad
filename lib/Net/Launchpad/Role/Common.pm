package Net::Launchpad::Role::Common;

# ABSTRACT: Common query roles usually associated with most API results

use Moose::Role;
use Function::Parameters;
use Mojo::URL;
use Data::Dumper::Concise;

=method resource

Returns resource of C<name>

=cut

method resource ($name) {
    my $link = $name . "_link";
    my $ret  = $self->lpc->get($self->stash->{$link});
    return $ret;
}

=method collection

Returns entires from collection C<name>

=cut

method collection ($name) {
    my $link = $name . "_collection_link";
    my $ret  = $self->lpc->get($self->stash->{$link});
    return $ret->{entries};
}

=method query

Returns results of C<name>

=cut

method query ($params, $path = undef) {
    $path = $self->stash->{self_link} unless $path;
    my $uri = Mojo::URL->new($path);
    $uri->query($params);
    return $self->lpc->get($uri->to_string);
}


=method owner

Owner of collection

=cut

method owner {
    return $self->resource('owner');
}

=method project

Project this collection belongs too

=cut

method project {
    return $self->resource('project');
}


=method recipes

Recipes associated with collection

=cut

method recipes {
    return $self->collection('recipes');
}


=method bugs

Bugs associated with object

=cut

method bugs {
    return $self->collection('bugs');
}


=method registrant

User that registered this branch

=cut

method registrant {
    return $self->resource('registrant');
}

1;
