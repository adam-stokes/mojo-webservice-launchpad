#!/usr/bin/env perl
#
# for quick tests only, should not be depended upon for
# proper examples of current api.

use Modern::Perl;
use FindBin;
use lib "$FindBin::Bin/../../lib";
use Net::Launchpad::Client;
use Net::Launchpad::Model;
use List::AllUtils qw(first);
use Data::Dumper::Concise;

my $public_bug = $ENV{LP_BUG} || '1388929';

my $client = Net::Launchpad::Client->new(
    consumer_key        => $ENV{LP_CONSUMER_KEY},
    access_token        => $ENV{LP_ACCESS_TOKEN},
    access_token_secret => $ENV{LP_ACCESS_TOKEN_SECRET}
);

my $model = $client->model("Bug");

my $bug = $model->bug($public_bug);
print Dumper($bug)

  # my $tasks = $bug->tasks;

  # my $branch = $model->branch('~adam-stokes', '+junk', 'cloud-installer');
  #print Dumper($branch->dependent_branches);

  # my $project = $model->project('cloud-installer');
  # print Dumper($project->{result});

#p $bug_item;
# p $bug->tasks;
# p $bug->date_created;
# p $bug->watches;
# my $bugtask =
#   first { $_->{bug_target_name} =~ /ubuntu-advantage|(Ubuntu)/ } @{$bug->tasks};
# # p $bugtask;
# my $person = $c->model('Person')->by_name('~adam-stokes');
# p $person;
# p $person->ppas;
