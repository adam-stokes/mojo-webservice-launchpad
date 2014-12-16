package Net::Launchpad::Model::Archive;

# ABSTRACT: Archive Model

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has distro       => (is => 'ro', isa => 'Str');
has archive_name => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->stash(
        $self->lpc->get(
            sprintf(
                "%s/%s/+archive/ubuntu/%s",
                $self->lpc->api_url, $self->distro, $self->archive_name
            )
        )
    );
}

=method get_published_binaries

Return published binary history for archive

=cut

method get_published_binaries {
    my $params = {
        'ws.op' => 'getPublishedBinaries',
        status  => 'Published'
    };
    return $self->query($params);
}

=method get_ppa_downloads

Binary package publishing record

=for :list
* C<Str binary_package_path> - self_link of binary package uri

=cut

method get_ppa_downloads ($binary_package_path) {
    my $params = {'ws.op' => 'getDailyDownloadTotals'};
    return $self->query($params, $binary_package_path);

}

__PACKAGE__->meta->make_immutable;
1;

__END__
