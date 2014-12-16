package Net::Launchpad::Model::BugTracker;

# ABSTRACT: BugTracker Model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has name => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->stash($self->lpc->get(
        sprintf("%s/bugs/bugtrackers/%s", $self->lpc->api_url, $self->name)));
}

=method watches

Returns remote watches collection

=cut

method watches {
    return $self->collection('watches');
}

__PACKAGE__->meta->make_immutable;
1;

__END__

