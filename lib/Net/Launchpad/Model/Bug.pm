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
with 'Net::Launchpad::Query';
extends 'Net::Launchpad::Model::Base';

=method tasks

Returns a list of entries in the tasks object.

=cut

method tasks {
    return $self->collection('bug_tasks');
}

=method watches

Returns bug watch collection

=cut

method watches {
    return $self->collection('bug_watches');
}

=method attachments

Returns list of bug attachments

=cut

method attachments {
    return $self->collection('attachments');
}

=method activity

Returns a bug activity collection

=cut

method activity {
    return $self->collection('activity');
}

=method duplicate_of

Returns a bug resource that the specific bug is a duplicate of

=cut

method duplicate_of {
    return $self->resource('duplicate_of');
}

=method messages

Returns bug messages associated with Bug.

=cut

method messages {
    return $self->collection('messages');
}

__PACKAGE__->meta->make_immutable;
1;

__END__

