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
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

__PACKAGE__->meta->make_immutable;
1;

__END__

