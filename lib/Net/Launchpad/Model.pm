package Net::Launchpad::Model;

use Mojo::Base 'Net::Launchpad::Client', -signatures;

# sub archive ($self, $distro, $archive_name ) {
#     my $params = $self->get(
#         sprintf( "%s/+archive/%s", $self->api_url, $distro, $archive_name ) );
#     return $self->load_model( 'Archive', $params );
# }

# sub bugtracker ($self, $name) {
#     my $params =
#       $self->get( sprintf( "%s/bugs/bugtrackers/%s", $self->api_url, $name ) );
#     return $self->load_model( 'BugTracker', $params );
# }

# sub builder ($self, $name) {
#     my $params =
#       $self->get( sprintf( "%s/builders/%s", $self->api_url, $name ) );
#     return $self->load_model( 'Builder', $params );
# }

# sub country ($self, $country_code) {
#     my $params = $self->get(
#         sprintf( "%s/+countries/%s", $self->api_url, $country_code ) );
#     return $self->load_model( 'Country', $params );
# }

# sub branch ( $self, $name, $project_name, $branch_name ) {
#     my $params = $self->get(
#         sprintf( "%s/%s/%s/%s",
#             $self->api_url, $name, $project_name, $branch_name )
#     );
#     return $self->load_model( 'Branch', $params );
# }

# sub people($self) {
#     my $params = $self->get( sprintf( "%s/people", $self->api_url ) );
#     return $self->load_model( 'People', $params );
# }

# sub person ($self, $name) {
#     my $params = $self->get( sprintf( "%s/%s", $self->api_url, $name ) );
#     return $self->load_model( 'Person', $params );
# }

# sub distribution ($self, $name) {
#     my $params = $self->get( sprintf( "%s/%s", $self->api_url, $name ) );
#     return $self->load_model( 'Distribution', $params );
# }

# sub language ($self, $isocode) {
#     my $params =
#       $self->get( sprintf( "%s/+languages/%s", $self->api_url, $isocode ) );
#     return $self->load_model( 'Language', $params );
# }

# sub cve ($self, $cve) {
#     my $params =
#       $self->get( sprintf( "%s/bugs/cve/%s", $self->api_url, $cve ) );
#     return $self->load_model( 'CVE', $params );
# }

# sub project ($self, $name) {
#     my $params = $self->get( sprintf( "%s/%s", $self->api_url, $name ) );
#     return $self->load_model( 'Project', $params );
# }

1;
