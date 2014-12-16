package Net::Launchpad::Model::Branch;

# ABSTRACT: Branch Model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has name         => (is => 'ro', isa => 'Str');
has project_name => (is => 'ro', isa => 'Str');
has branch_name  => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->lpc->get(
        sprintf("%s/%s/%s/%s",
            $self->lpc->api_url, $self->name,
            $self->project_name, $self->branch_name)
    );
}

__PACKAGE__->meta->make_immutable;
1;

__END__
