package Net::Launchpad::Model::Bug;

# ABSTRACT: Bug Model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $bug = $c->bug(3)

    print "Title: ". $bug->result->{title};
    print "Desc:  ". $bug->result->{description};
    print "Heat:  ". $bug->result->{heat};

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has id => (is => 'ro', isa => 'Int');

method BUILD {
    return $self->lpc->get(
        sprintf("%s/bugs/%s", $self->lpc->api_url, $self->id));
}

__PACKAGE__->meta->make_immutable;
1;

__END__

