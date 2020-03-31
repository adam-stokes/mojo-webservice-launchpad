package Net::Launchpad::Model::Person;

use Mojo::Base -base;

has 'person';
has 'client';

sub display_name {
    my $self = shift;
    return $self->person->{display_name};
}

sub name {
    my $self = shift;
    return $self->person->{name};
}

sub description {
    my $self = shift;
    return $self->person->{description};
}

sub created {
    my $self = shift;
    return $self->person->{date_created};
}

sub karma {
    my $self = shift;
    return $self->person->{karma};
}

sub timezone {
    my $self = shift;
    return $self->person->{time_zone};
}

1;

