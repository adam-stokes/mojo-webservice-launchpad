package Net::Launchpad::Role::BugTracker;

use Mojo::Base 'Net::Launchpad::Role::Common';

sub watches {
    return $self->collection('watches');
}

1;
