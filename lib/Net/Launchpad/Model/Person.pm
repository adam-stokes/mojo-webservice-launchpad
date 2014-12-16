package Net::Launchpad::Model::Person;
# ABSTRACT: Person model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $person = $c->person('~adam-stokes');

    print "Name: ". $person->result->{name};

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;
with 'Net::Launchpad::Query';
extends 'Net::Launchpad::Model::Base';

=method get_ppa_by_name

Get PPA for owner

B<Params>

=for :list
* C<Str name>

=cut

method get_ppa_by_name (Str $name) {
    my $params = {
        'ws.op' => 'getPPAByName',
        name    => $name
    };
    return $self->resource($params);
}

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


__PACKAGE__->meta->make_immutable;
1;

