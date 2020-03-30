requires 'Data::Dumper::Concise';
requires 'Role::Tiny';
requires 'Mojolicious';
requires 'List::AllUtils';
requires 'Class::Load';

on build => sub {
    requires 'FindBin';
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'lib';
    requires 'strict';
    requires 'warnings';
};
