package Net::Launchpad::Model::CVE;

# ABSTRACT: CVE Model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $cve = $c->cve('XXXX-XXXX');

    print "Title: ". $cve->result->{title};
    print "Desc:  ". $cve->result->{description};

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;
extends 'Net::Launchpad::Model::Base';

has cve => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->stash($self->lpc->get(
        sprintf("%s/bugs/cve/%s", $self->lpc->api_url, $self->cve)));
}
__PACKAGE__->meta->make_immutable;
1;

__END__

=method by_sequence

This needs to be called before any of the below methods. Takes a CVE sequence number, e.g. 2011-3188.

=method bugs

Returns a list of entries associated with cve

=cut
