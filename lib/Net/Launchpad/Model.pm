package Net::Launchpad::Model;

# ABSTRACT: Model class

use Mojo::Base 'Net::Launchpad::Client';
use Moose::Util qw(apply_all_roles is_role does_role search_class_by_role);
use Module::Runtime qw(is_module_name use_package_optimistically);
use Data::Dumper::Concise;

sub _load_model ($name, $params) {
    my $model_class = "Net::Launchpad::Model::$name";
    my $model_role  = "Net::Launchpad::Role::$name";

    die "Invalid model requested." unless is_module_name($model_class);
    die "Unknown Role module" unless is_module_name($model_role);

    my $model = use_package_optimistically($model_class)
        my $model = $model->with_roles($model_role)
        return $model->new(result => $params);
}

sub archive ($distro, $archive_name) {
    my $params = $self->get(
        sprintf(
            "%s/+archive/%s", $self->api_url, $distro, $archive_name
        )
    );
    return $self->_load_model('Archive', $params);
}

sub bug (Int $id) {
    my $params =
      $self->get(sprintf("%s/bugs/%s", $self->api_url, $id));
    return $self->_load_model('Bug', $params);
}

sub bugtracker ($name) {
    my $params = $self->get(
        sprintf("%s/bugs/bugtrackers/%s", $self->api_url, $name));
    return $self->_load_model('BugTracker', $params);
}

sub builder ($name) {
    my $params =
      $self->get(sprintf("%s/builders/%s", $self->api_url, $name));
    return $self->_load_model('Builder', $params);
}

sub country ($country_code) {
    my $params = $self->get(
        sprintf("%s/+countries/%s", $self->api_url, $country_code));
    return $self->_load_model('Country', $params);
}


sub branch ($name, $project_name, $branch_name) {
    my $params = $self->get(
        sprintf("%s/%s/%s/%s",
            $self->api_url, $name, $project_name, $branch_name)
    );
    return $self->_load_model('Branch', $params);
}

sub people {
    my $params =
      $self->get(sprintf("%s/people", $self->api_url));
    return $self->_load_model('People', $params);
}

sub person ($name) {
    my $params =
      $self->get(sprintf("%s/%s", $self->api_url, $name));
    return $self->_load_model('Person', $params);
}

sub distribution ($name) {
    my $params =
      $self->get(sprintf("%s/%s", $self->api_url, $name));
    return $self->_load_model('Distribution', $params);
}

sub language ($isocode) {
    my $params = $self->get(
        sprintf("%s/+languages/%s", $self->api_url, $isocode));
    return $self->_load_model('Language', $params);
}

sub cve ($cve) {
    my $params =
      $self->get(sprintf("%s/bugs/cve/%s", $self->api_url, $cve));
    return $self->_load_model('CVE', $params);
}

sub project ($name) {
    my $params =
      $self->get(sprintf("%s/%s", $self->api_url, $name));
    return $self->_load_model('Project', $params);
}

1;
