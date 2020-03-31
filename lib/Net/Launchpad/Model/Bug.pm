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
    my ( $self, $id ) = @_;
    print $self->api_url;
    $self->bug( $self->get( sprintf( "%s/bugs/%s", $self->api_url, $id ) ) );
}

sub id {
    my $self = shift;
    return $self->bug->{id};
}

sub title {
    my $self = shift;
    return $self->bug->{title};
}

sub description {
    my $self = shift;
    return $self->bug->{description};
}

sub heat {
    my $self = shift;
    return $self->bug->{heat};
}

sub created {
    my $self = shift;
    return $self->bug->{date_created};
}

sub last_message {
    my $self = shift;
    return $self->bug->{date_last_message};
}

sub last_updated {
    my $self = shift;
    return $self->bug->{date_last_updated};
}

sub tasks {
    my $self = shift;
    return $self->get( $self->bug->{bug_tasks_collection_link} )->{entries};
}

sub messages {
    my $self = shift;
    return $self->get( $self->bug->{messages_collection_link} )->{entries};
}

sub attachments {
    my $self = shift;
    return $self->get( $self->bug->{attachments_collection_link} )->{entries};
}

sub linked_branches {
    my $self = shift;
    return $self->get( $self->bug->{linked_branches_collection_link} )->{entries};
}

sub linked_merge_proposals {
    my $self = shift;
    return $self->get( $self->bug->{linked_merge_proposals_collection_link} )->{entries};
}

sub activity {
    my $self = shift;
    return $self->get( $self->bug->{activity_collection_link} )->{entries};
}


1;

