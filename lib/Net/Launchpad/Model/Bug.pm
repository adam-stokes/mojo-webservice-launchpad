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

has 'bug';

sub by_id {
    my ($self, $id) = @_;
    print $self->api_url;
    $self->bug(
        $self->get( sprintf( "%s/bugs/%s", $self->api_url, $id ) ));
}

sub title {
    my $self = shift;
    return $self->bug->{title};
}

sub description {
    my $self = shift;
    return $self->bug->{description};
}

sub tasks {
    my $self = shift;
    return $self->get($self->bug->{bug_tasks_collection_link})->{entries};
}

sub messages {
    my $self = shift;
    return $self->get($self->bug->{messages_collection_link})->{entries};
}


1;

