package Net::Launchpad::Model::Base;

# ABSTRACT: base class

use Moose;
use Function::Parameters;
use namespace::autoclean;

=attr stash

stash of query

=cut

has stash => (is => 'rw', isa => 'HashRef');

=attr lpc

L<Net::Launchpad::Client>

=cut

has lpc => (is => 'ro', isa => 'Net::Launchpad::Client');

__PACKAGE__->meta->make_immutable;
1;
