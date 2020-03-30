package Net::Launchpad::Model::Bug;

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

use Mojo::Base 'Net::Launchpad::Client';
use Data::Dumper::Concise;

sub bug {
    my ($self, $id) = @_;
    my $res = $self->get( sprintf( "%s/bugs/%s", $self->api_url, $id ) );
    print Dumper($res);
    return $res;
}

1;

