# NAME

Net::Launchpad - Launchpad.net OAuth 1.0

# SYNOPSIS

OAuth 1.0a authorization and client for Launchpad.net

# ATTRIBUTES

[Net::Launchpad](https://metacpan.org/pod/Net::Launchpad) implements the following attributes:

## __staging__

Boolean to interact with staging server or production.

## __ua__

A [Mojo::UserAgent](https://metacpan.org/pod/Mojo::UserAgent).

## __json__

A [Mojo::JSON](https://metacpan.org/pod/Mojo::JSON).

## __consumer\_key__

Holds the string that identifies your application.

    $lp->consumer_key('my-app-name');

## __callback\_uri__

Callback url to redirect use back to once authenticated.

## __nonce__

Nonce

## __params__

OAuth 1.0a parameters used in request, authenticate, and access

# METHODS

## __api\_host__

Hostname used for authentication

## __access\_token\_path__

OAuth Access token url

## __authorize\_token\_path__

OAuth Authorize token url

## __request\_token\_path__

OAuth Request token url

## __request\_token__

Perform the request-token request

## __authenticate\_token__

Perform the authentication request

## __access\_token__

Perform the access token request

# AUTHOR

Adam Stokes, `<adamjs at cpan.org>`

# BUGS

Report bugs to https://github.com/battlemidget/Net-Launchpad/issues.

# DEVELOPMENT

## Repository

    http://github.com/battlemidget/Net-Launchpad

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Launchpad

# SEE ALSO

- [https://launchpad.net/launchpadlib](https://launchpad.net/launchpadlib), "Python implementation"

# COPYRIGHT

Copyright 2013-2014 Adam Stokes

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
