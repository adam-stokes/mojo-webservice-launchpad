package Net::Launchpad::Model::BugTracker;

# ABSTRACT: BugTracker Model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has name => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->lpc->get(
        sprintf("%s/bugs/bugtrackers/%s", $self->lpc->api_url, $self->name));
}

__PACKAGE__->meta->make_immutable;
1;

__END__

