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

sub assigned_bugs {
    my $self   = shift;
    my $params = {
        'ws.op'    => 'searchTasks',
            'assignee' => $self->person->{self_link}
    };
    my $uri = $self->client->build_uri(sprintf("%s/%s", $self->client->api_url, '~'.$self->name));
    my $results = $self->client->get($uri->query($params)->to_string);
    return $results->{entries};
}

1;

