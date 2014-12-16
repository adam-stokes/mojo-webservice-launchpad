package Net::Launchpad::Model::Country;

# ABSTRACT: Country model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $country = $c->country('US');

    print "Name: ". $country->result->{name};

=head1 DESCRIPTION

Container for countries

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;
extends 'Net::Launchpad::Model::Base';

has country_code => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->stash(
        $self->lpc->get(
            sprintf(
                "%s/+countries/%s",
                $self->lpc->api_url, $self->country_code
            )
        )
    );
}

=method get_by_code

Return a country by its code

B<Params>

=for :list
* C<Str code>

=cut

method get_by_code (Str $code) {
    my $params = {
        'ws.op' => 'getByCode',
        code    => $code
    };
    return $self->resource($params);
}


=method get_by_name

Return country by its name

B<Params>

=for :list
* C<Str name>

=cut

method get_by_name (Str $name) {
    my $params = {
        'ws.op' => 'getByName',
        name    => $name
    };
    return $self->resource($params);
}

__PACKAGE__->meta->make_immutable;
1;

