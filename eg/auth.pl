#!/usr/bin/env perl

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Mojolicious::Lite;
use Net::Launchpad;
use Mojo::URL;
use feature qw[say];

my $callback_uri = "http://localhost:3000/callback";
my $consumer_key = "Net-Launchpad";

app->helper(
    lp => sub {
        my $self = shift;
        Net::Launchpad->new(
            consumer_key => $consumer_key,
            callback_uri => $callback_uri,
            staging      => 1
        );
    }
);


get '/' => sub {
  my ($c) = @_;
} => 'index';

post '/auth' => sub {
    my ($c) = @_;
    return $c->redirect_to(app->lp->authorize_url);
};

get '/callback' => sub {
  my ($c) = @_;
  my $request_token = $c->param('code');
  my $payload = app->lp->authenticate($authorization_code);
  $c->stash(oauth => $payload);
} => 'authenticated';

app->start;

__DATA__

@@ index.html.ep
<html><head><title>index</title></head>
<body>
<form method="post" action="/auth">
<button type="submit">Auth</button>
</form>
</body>
</html>

@@ authenticated.html.ep
% use DDP;
% p $oauth;
<html><head><title>Callback</title></head>
<body>
<h1>Authenticated</h1>
<p>Your consumer_key is: <%= $oauth->{consumer_key} %></p>
<p>Your access_token is: <%= $oauth->{access_token} %></p>
<p>Your access_token_secret is: <%= $oauth->{access_token_secret} %></p>
</body>
</html>
