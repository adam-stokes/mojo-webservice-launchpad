requires 'Data::Dumper::Concise';
requires 'Module::Runtime';
requires 'Mojo::JSON';
requires 'Mojo::Parameters';
requires 'Mojo::URL';
requires 'Mojo::UserAgent';
requires 'Role::Tiny';
requires 'Mojolicious';

on build => sub {
    requires 'FindBin';
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'lib';
    requires 'strict';
    requires 'warnings';
};
