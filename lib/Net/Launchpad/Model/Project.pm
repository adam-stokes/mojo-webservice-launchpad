package Net::Launchpad::Model::Project;
# ABSTRACT: Project Model interface

=head1 DESCRIPTION

=head1 SYNOPSIS

    use Net::Launchpad::Client;
    my $c = Net::Launchpad::Client->new(
        consumer_key        => 'key',
        access_token        => '3243232',
        access_token_secret => '432432432'
    );

    my $project = $c->project('sosreport');

    print "Name: ". $project->result->{name};

=cut
use Moose;
use namespace::autoclean;

extends 'Net::Launchpad::Model::Base';

__PACKAGE__->meta->make_immutable;
1;
