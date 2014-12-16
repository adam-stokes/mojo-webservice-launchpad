package Net::Launchpad::Role::Query::Person;

# ABSTRACT: Person query role

use Moose::Role;
use Function::Parameters;

with 'Net::Launchpad::Role::Query';

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

1;
