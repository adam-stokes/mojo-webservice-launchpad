#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Exception;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Data::Dumper::Concise;
use Moose::Util qw(does_role);

plan skip_all => 'must export launchpad credentials to enable these tests'
  unless $ENV{LP_CONSUMER_KEY}
  && $ENV{LP_ACCESS_TOKEN}
  && $ENV{LP_ACCESS_TOKEN_SECRET};

diag("testing ppa api");

# replace with the actual test
use_ok('Net::Launchpad::Client');

my $lp = Net::Launchpad::Client->new(
    consumer_key        => $ENV{LP_CONSUMER_KEY},
    access_token        => $ENV{LP_ACCESS_TOKEN},
    access_token_secret => $ENV{LP_ACCESS_TOKEN_SECRET}
);

use_ok('Net::Launchpad::Model');
my $model = Net::Launchpad::Model->new(lpc => $lp);

# person
my $person = $model->person('~cloud-installer');
my $ppa = $person->get_ppa_byname('testing');
ok ($ppa->{name} eq 'testing');
my $archive = $model->archive('~cloud-installer', $ppa->{name});
my $res = $archive->get_published_binaries();
print Dumper($res);


done_testing;
