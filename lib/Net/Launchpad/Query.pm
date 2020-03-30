package Net::Launchpad::Query;

use Mojo::Base 'Launchpad::Net::Client';

sub builders($self) {
    return $self->load_model('Builder');
}

sub countries($self) {
    return $self->load_model('Country');
}

sub branches($self) {
    return $self->load_model('Branch');
}

sub people($self) {
    return $self->load_model('People');
}

sub person($self) {
    return $self->load_model('Person');
}

sub projects($self) {
    return $self->load_model('Project');
}

1;
