package Net::Launchpad::Model;

# ABSTRACT: Model class

use Moose;
use Moose::Util qw(apply_all_roles is_role does_role search_class_by_role);
use Function::Parameters;
use Module::Runtime qw(is_module_name use_package_optimistically);
use Data::Dumper::Concise;
use namespace::autoclean;

has lpc => (is => 'ro', isa => 'Net::Launchpad::Client');

method _load_model (Str $name, HashRef $params) {
    my $model_class = "Net::Launchpad::Model::$name";
    my $model_role  = "Net::Launchpad::Role::$name";

    die "Invalid model requested." unless is_module_name($model_class);
    die "Unknown Role module" unless is_module_name($model_role);

    my $model =
      use_package_optimistically($model_class)->new(result => $params, lpc => $self->lpc);

    my $role =
      use_package_optimistically($model_role);

    die "$_ is not a role" unless is_role($role);
    $role->meta->apply($model);
}

method archive (Str $distro, Str $archive_name) {
    my $params = $self->lpc->get(
        sprintf(
            "%s/+archive/%s", $self->lpc->api_url, $distro, $archive_name
        )
    );
    return $self->_load_model('Archive', $params);
}

method bug (Int $id) {
    my $params =
      $self->lpc->get(sprintf("%s/bugs/%s", $self->lpc->api_url, $id));
    return $self->_load_model('Bug', $params);
}

method bugtracker (Str $name) {
    my $params = $self->lpc->get(
        sprintf("%s/bugs/bugtrackers/%s", $self->lpc->api_url, $name));
    return $self->_load_model('BugTracker', $params);
}

method builder (Str $name) {
    my $params =
      $self->lpc->get(sprintf("%s/builders/%s", $self->lpc->api_url, $name));
    return $self->_load_model('Builder', $params);
}

method country (Str $country_code) {
    my $params = $self->lpc->get(
        sprintf("%s/+countries/%s", $self->lpc->api_url, $country_code));
    return $self->_load_model('Country', $params);
}


method branch (Str $name, Str $project_name, Str $branch_name) {
    my $params = $self->lpc->get(
        sprintf("%s/%s/%s/%s",
            $self->lpc->api_url, $name, $project_name, $branch_name)
    );
    return $self->_load_model('Branch', $params);
}

method person (Str $name) {
    my $params =
      $self->lpc->get(sprintf("%s/%s", $self->lpc->api_url, $name));
    return $self->_load_model('Person', $params);
}

method distribution (Str $name) {
    my $params =
      $self->lpc->get(sprintf("%s/%s", $self->lpc->api_url, $name));
    return $self->_load_model('Distribution', $params);
}

method language ($isocode) {
    my $params = $self->lpc->get(
        sprintf("%s/+languages/%s", $self->lpc->api_url, $isocode));
    return $self->_load_model('Language', $params);
}

method cve (Str $cve) {
    my $params =
      $self->lpc->get(sprintf("%s/bugs/cve/%s", $self->lpc->api_url, $cve));
    return $self->_load_model('CVE', $params);
}

method project (Str $name) {
    my $params =
      $self->lpc->get(sprintf("%s/%s", $self->lpc->api_url, $name));
    return $self->_load_model('Project', $params);
}


__PACKAGE__->meta->make_immutable;
1;
