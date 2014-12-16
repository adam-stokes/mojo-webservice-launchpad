package Net::Launchpad::Query;

# ABSTRACT: Query class

use Moose::Role;
use Function::Parameters;
use Mojo::Parameters;

=method resource

Returns resource of C<name>

=cut

method resource ($name) {
    my $link = $name . "_link";
    my $ret  = $self->lpc->get($self->result->{$link});
    return $ret;
}

=method collection

Returns entires from collection C<name>

=cut

method collection ($name) {
    my $link = $name . "_collection_link";
    my $ret  = $self->lpc->get($self->result->{$link});
    return $ret->{entries};
}

1;
