package Net::Launchpad::Model;

# ABSTRACT: Model class

use Moose;
use Moose::Util qw(apply_all_roles is_role does_role search_class_by_role);
use Function::Parameters;
use Module::Runtime qw(is_module_name use_package_optimistically);
use Data::Dumper::Concise;
use namespace::autoclean;

has lpc => (is => 'ro', isa => 'Net::Launchpad::Client');

=method _load_model

Merges roles onto model for additional query options

=cut

method _load_model (Str $name, HashRef $params = +{}) {
    my $model_class = "Net::Launchpad::Model::$name";

    # Provide additional routines for accessing class data
    my $model_role  = "Net::Launchpad::Role::$name";

    # Provide query routines
    my $query_role_class = "Net::Launchpad::Role::Common";

    die "Invalid model requested." unless is_module_name($model_class);
    die "Unknown Role module"      unless is_module_name($model_role);
    die "Unknown Role module"      unless is_module_name($query_role_class);

    my $model =
      use_package_optimistically($model_class)
      ->new(lpc => $self->lpc, $params);

    my $role = use_package_optimistically($model_role);

    my $query_role = use_package_optimistically($query_role_class);

    die "$_ is not a role" unless is_role($role);
    die "$_ is not a role" unless is_role($query_role);
    $role->meta->apply($model);
    $query_role->meta->apply($model);
}

method archive (Str $distro, Str $archive_name) {
    return $self->_load_model('Archive',
        {distro => $distro, archive_name => $archive_name});
}

method bug (Int $id) {
    return $self->_load_model('Bug', {id => $id});
}

method bugtracker (Str $name) {
    return $self->_load_model('BugTracker', {name => $name});
}

method builder (Str $name) {
    return $self->_load_model('Builder', {name => $name});
}

method country (Str $country_code) {
    return $self->_load_model('Country', {country_code => $country_code});
}

method branch (Str $name, Str $project_name, Str $branch_name) {
    return $self->_load_model(
        'Branch',
        {   name         => $name,
            project_name => $project_name,
            branch_name  => $branch_name
        }
    );
}

method people {
    return $self->_load_model('People');
}

method person (Str $name) {
    return $self->_load_model('Person', {username => $name});
}

method distribution (Str $name) {
    return $self->_load_model('Distribution', {name => $name});
}

method language (Str $isocode) {
    return $self->_load_model('Language', {isocode => $isocode});
}

method cve (Str $cve) {
    return $self->_load_model('CVE', {cve => $cve});
}

method project (Str $name) {
    return $self->_load_model('Project', {name => $name});
}


__PACKAGE__->meta->make_immutable;
1;
