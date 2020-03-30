package Net::Launchpad::Role::Person;

use Mojo::Base 'Net::Launchpad::Role::Common';

sub gpg_keys {
    return $self->collection('gpg_keys');
}

sub irc_nicks {
    return $self->collection('irc_nicknames');
}

sub ppas {
    return $self->collection('ppas');
}

sub ssh_keys {
    return $self->collection('sshkeys');
}

1;
