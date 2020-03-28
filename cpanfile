requires 'Data::Dumper::Concise';
requires 'Function::Parameters';
requires 'Module::Runtime';
requires 'Mojo::JSON';
requires 'Mojo::Parameters';
requires 'Mojo::URL';
requires 'Mojo::UserAgent';
requires 'Moose';
requires 'Moose::Role';
requires 'Moose::Util';
requires 'namespace::autoclean';

on build => sub {
    requires 'FindBin';
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'lib';
    requires 'strict';
    requires 'warnings';
};
