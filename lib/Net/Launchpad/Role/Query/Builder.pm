package Net::Launchpad::Role::Query::Builder;

# ABSTRACT: Builder query role

use Moose::Role;
use Function::Parameters;
use Data::Dumper::Concise;

with 'Net::Launchpad::Role::Query';

=method all

Get all builders

=cut
method all {
  return $self->resource({});
}

=method get_by_name

Return a builder by name

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
