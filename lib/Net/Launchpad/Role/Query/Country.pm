package Net::Launchpad::Role::Query::Country;

# ABSTRACT: Person/People query role

use Moose::Role;
use Function::Parameters;
use Data::Dumper::Concise;

with 'Net::Launchpad::Role::Query';

=method get_by_code

Return a country by its code

B<Params>

=for :list
* C<Str code>

=cut

method get_by_code (Str $code) {
    my $params = {
        'ws.op' => 'getByCode',
        code    => $code
    };
    return $self->resource($params);
}


=method get_by_name

Return country by its name

B<Params>

=for :list
* C<Str name>

=cut

method get_by_name (Str $name) {
    my $params = {
        'ws.op' => 'getByName',
        name    => $name
    };
    return $self->resource($params);
}

1;
