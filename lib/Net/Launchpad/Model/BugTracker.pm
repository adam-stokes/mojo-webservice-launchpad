package Net::Launchpad::Model::BugTracker;

# ABSTRACT: BugTracker Model

use Moose;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

__PACKAGE__->meta->make_immutable;
1;

__END__

