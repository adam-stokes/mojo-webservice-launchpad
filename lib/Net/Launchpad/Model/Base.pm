package Net::Launchpad::Model::Base;

# ABSTRACT: base class

use Moose;
use namespace::autoclean;
use Function::Parameters;

=attr result

Result of query

=cut

has result => (is => 'rw', isa => 'HashRef');

=attr lpc

L<Net::Launchpad::Client>

=cut

has lpc => (is => 'ro', isa => 'Net::Launchpad::Client');

=attr ns

Namespace for search queries against collections

=cut
has ns => (is => 'rw');

__PACKAGE__->meta->make_immutable;
1;
