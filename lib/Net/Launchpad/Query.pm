package Net::Launchpad::Query;

# ABSTRACT: Query class

use Moose;
use Moose::Util qw(apply_all_roles is_role does_role search_class_by_role);
use Function::Parameters;
use Mojo::Parameters;
use Module::Runtime qw(is_module_name use_package_optimistically);
use Data::Dumper::Concise;
use namespace::autoclean;

has lpc    => (is => 'ro', isa => 'Net::Launchpad::Client');

method _load_model (Str $name) {
    my $model_class = sprintf("Net::Launchpad::Model::Query::%s", $name);
    my $model_role  = sprintf("Net::Launchpad::Role::Query::%s",  $name);
    die "Invalid model requested." unless is_module_name($model_class);
    die "Unknown Role module"      unless is_module_name($model_role);

    my $model =
      use_package_optimistically($model_class)->new(lpc => $self->lpc);

    my $role = use_package_optimistically($model_role);

    die "$_ is not a role" unless is_role($role);
    $role->meta->apply($model);
}

# method bugtrackers {
#     return $self->_load_model('BugTracker');
# }

=method builders

Search  builders

=cut
method builders {
    return $self->_load_model('Builder');
}

method countries {
    return $self->_load_model('Country');
}

=method branches

Search utilities for branches

=cut
method branches {
    return $self->_load_model('Branch');
}

=method people

Search people

=cut
method people {
    return $self->_load_model('Person');
}

=method projects

Search projects

=cut
method projects {
    return $self->_load_model('Project');
}


__PACKAGE__->meta->make_immutable;
1;
