package Net::Launchpad::Model::Builder;

# ABSTRACT: Builder Model

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $builder = $c->builder('batsu');

    print "Name: ". $builder->result->{name};

=head1 DESCRIPTION

Build-slave information and state.

Builder instance represents a single builder slave machine within the
Launchpad Auto Build System. It should specify a 'processor' on which
the machine is based and is able to build packages for; a URL, by
which the machine is accessed through an XML-RPC interface; name,
title for entity identification and browsing purposes; an LP-like
owner which has unrestricted access to the instance; the build slave
machine status representation, including the field/properties:
virtualized, builderok, status, failnotes and currentjob.

=cut

use Moose;
use Function::Parameters;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

has name => (is => 'ro', isa => 'Str');

method BUILD {
    return $self->stash($self->lpc->get(
        sprintf("%s/builders/%s", $self->lpc->api_url, $self->name)));
}

=method all

Get all builders

=cut
method all {
  return $self->resource({});
}

=method get_by_name

Return a builder by name

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

__END__

