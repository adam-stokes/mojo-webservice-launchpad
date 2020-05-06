package Mojo::WebService::Launchpad::Model::Bug;

=head1 SYNOPSIS

    use Mojo::WebService::Launchpad::Client;
    my $c = Mojo::WebService::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $bug = $c->bug(3)

    print "Title: ". $bug->result->{title};
    print "Desc:  ". $bug->result->{description};
    print "Heat:  ". $bug->result->{heat};

=cut

use Mojo::Base -base;

has 'bug';
has 'client';

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
    return $self->client->get( $self->bug->{bug_tasks_collection_link} )
      ->then( sub { my $mojo = shift; return $mojo->res->json->{entries} } );
}

sub messages {
    my $self = shift;
    return $self->client->get( $self->bug->{messages_collection_link} )
        ->then( sub { my $mojo = shift; return $mojo->res->json->{entries} } );
}

sub attachments {
    my $self = shift;
    return $self->client->get( $self->bug->{attachments_collection_link} )
        ->then( sub { my $mojo = shift; return $mojo->res->json->{entries} } );
}

sub linked_branches {
    my $self = shift;
    return $self->client->get( $self->bug->{linked_branches_collection_link} )
        ->then( sub { my $mojo = shift; return $mojo->res->json->{entries} } );
}

sub linked_merge_proposals {
    my $self = shift;
    return $self->client->get(
        $self->bug->{linked_merge_proposals_collection_link} )
        ->then( sub { my $mojo = shift; return $mojo->res->json->{entries} } );
}

sub activity {
    my $self = shift;
    return $self->client->get( $self->bug->{activity_collection_link} )
        ->then( sub { my $mojo = shift; return $mojo->res->json->{entries} } );
}

1;

