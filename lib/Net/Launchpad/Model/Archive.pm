package Net::Launchpad::Model::Archive;

# ABSTRACT: Archive Model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has distro       => (is => 'ro', isa => 'Str');
has archive_name => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->lpc->get(
        sprintf("%s/+archive/%s",
            $self->lpc->api_url, $self->distro, $self->archive_name)
    );
}

__PACKAGE__->meta->make_immutable;
1;

__END__
