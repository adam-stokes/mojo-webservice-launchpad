#!/usr/bin/env perl
#
# for quick tests only, should not be depended upon for
# proper examples of current api.

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Net::Launchpad::Client;

# use List::AllUtils qw(first);
use Data::Dumper::Concise;

die "Missing envs"
  unless $ENV{LP_CONSUMER_KEY}
  && $ENV{LP_ACCESS_TOKEN}
  && $ENV{LP_ACCESS_TOKEN_SECRET};

my $public_bug = $ENV{LP_BUG} || '1388929';

my $lp = Net::Launchpad::Client->new(
    consumer_key        => $ENV{LP_CONSUMER_KEY},
    access_token        => $ENV{LP_ACCESS_TOKEN},
    access_token_secret => $ENV{LP_ACCESS_TOKEN_SECRET},
);

# my $bug = $lp->resource("Bug")->by_id($public_bug);

# print Dumper( $bug->bug );
# print Dumper( $bug->title );
# print Dumper( $bug->description );
# print Dumper( $bug->tasks );
# print Dumper( $bug->messages );
# print Dumper( $bug->attachments );
# print Dumper( $bug->activity );

my $person = $lp->resource("Person")->by_name("~adam-stokes");
print Dumper($person->name);
print Dumper($person->timezone);

my $person_by_name = $lp->resource("Person")->find("adam-stokes");
print Dumper($person_by_name)

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
