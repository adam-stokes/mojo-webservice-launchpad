package Net::Launchpad::Role::Common;

use Mojo::Base -role;

sub resource  {
    my ($self, $name) = @_;
    my $link = $name . "_link";
    my $ret  = $self->get( $self->result->{$link} );
    return $ret;
}

sub collection {
    my ($self, $name) = @_;
    my $link = $name . "_collection_link";
    my $ret  = $self->get( $self->result->{$link} );
    return $ret->{entries};
}

sub owner {
    my $self = shift;
    return $self->resource('owner');
}

sub project {
    my $self = shift;
    return $self->resource('project');
}

sub recipes {
    my $self = shift;
    return $self->collection('recipes');
}

sub bugs {
    my $self = shift;
    return $self->collection('bugs');
}

sub registrant {
    my $self = shift;
    return $self->resource('registrant');
}

1;
