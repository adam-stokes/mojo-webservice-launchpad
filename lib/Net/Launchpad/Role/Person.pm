package Net::Launchpad::Role::Person;

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Role::Common';

# ABSTRACT: Person roles

=method gpg_keys

Returns list a gpg keys registered

=cut
method gpg_keys {
    return $self->collection('gpg_keys');
}

=method irc_nicks

Returns list of irc nicks

=cut
method irc_nicks {
    return $self->collection('irc_nicknames');
}

=method ppas

Returns list of ppas associated

=cut
method ppas {
    return $self->collection('ppas');
}

=method ssh_keys

Returns list of public ssh keys

=cut
method ssh_keys {
    return $self->collection('sshkeys');
}

1;
