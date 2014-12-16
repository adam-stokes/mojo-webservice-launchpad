package Net::Launchpad::Role::Query::Person;

# ABSTRACT: Person query role

use Moose::Role;
use Function::Parameters;
use Data::Dumper::Concise;

with 'Net::Launchpad::Role::Query';

=method get_ppa_byname

Return all ppa with given name

B<Params>

=for :list
* C<Str name>

=cut

method get_ppa_byname (Str $name) {
    my $params = {
        'ws.op' => 'getPPAByName',
        text    => $name
    };
    return $self->resource($params);
}

=method get_owned_teams

Return teams that this person owns

=cut

method get_owned_teams {
    my $params = {'ws.op' => 'getOwnedTeams'};
    return $self->resource($params);
}

=method get_owned_projects

Return projects that this person owns

=cut

method get_owned_projects {
    my $params = {'ws.op' => 'getOwnedProjects'};
    return $self->resource($params);
}

1;
