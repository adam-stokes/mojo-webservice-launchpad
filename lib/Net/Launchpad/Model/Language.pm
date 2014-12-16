package Net::Launchpad::Model::Language;

# ABSTRACT: Language Model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has isocode => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->stash(
        $self->lpc->get(
            sprintf("%s/+languages/%s", $self->lpc->api_url, $self->isocode)
        )
    );
}

__PACKAGE__->meta->make_immutable;
1;

__END__
