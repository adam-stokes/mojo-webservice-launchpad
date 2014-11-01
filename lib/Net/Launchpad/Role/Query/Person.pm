package Net::Launchpad::Role::Query::Person;

# ABSTRACT: Person/People query role

use Moose::Role;
use Function::Parameters;
use Data::Dumper::Concise;

with 'Net::Launchpad::Role::Query';

=method find

Return all non-merged Persons and Teams whose name, displayname or email address match C<text>.

Note: C<Text matching is performed only against the beginning of an email address.>

B<Params>

=for :list
* C<Str text>

=cut

method find (Str $text) {
    my $params = {
        'ws.op' => 'find',
        text    => $text
    };
    return $self->resource($params);
}


=method find_person

Return all non-merged Persons with at least one email address whose name, displayname or email address match C<text>.

B<Params>

=for :list
* C<Str text>
* C<Str created_before>
* C<Str created_after>

=cut

method find_person (Str $text, Str $created_after = undef, Str $created_before = undef) {
    my $params = {
        'ws.op' => 'findPerson',
        text    => $text
    };
    return $self->resource($params);
}

=method find_team

Return all Teams whose name, displayname or email address match <text>.

Note: C<Text matching is performed only against the beginning of an email address.>

B<Params>

=for :list
* C<Str text>

=cut

method find_team (Str $text) {
    my $params = {
        'ws.op' => 'findTeam',
        text => $text
    };
    return $self->resource($params);
}


=method get_by_email

Return the person with the given email address.

B<Params>

=for :list
* C<Str email>

=cut

method get_by_email (Str $email) {
    my $params = {
        'ws.op' => 'getByEmail',
        email   => $email
    };
    return $self->resource($params);
}

1;
