package Net::Launchpad::Model::Query::Country;

# ABSTRACT: Country query model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has '+ns' => (is => 'ro', default => '+countries');

__PACKAGE__->meta->make_immutable;

1;
