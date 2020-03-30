package Net::Launchpad::Role::Bug;

use Mojo::Base -role;


sub tasks {
    my $self = shift;
    return $self->collection('bug_tasks');
}

sub watches {
    my $self = shift;
    return $self->collection('bug_watches');
}

sub attachments {
    my $self = shift;
    return $self->collection('attachments');
}

sub activity {
    my $self = shift;
    return $self->collection('activity');
}

sub duplicate_of {
    my $self = shift;
    return $self->resource('duplicate_of');
}

sub messages {
    my $self = shift;
    return $self->collection('messages');
}

1;
