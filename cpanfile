requires 'Role::Tiny';
requires 'Mojolicious';
requires 'Class::Load';
requires 'IO::Socket::SSL';

on build => sub {
    requires 'FindBin';
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'lib';
    requires 'strict';
    requires 'warnings';
    requires 'Data::Dumper::Concise';
};
