requires 'Role::Tiny';
requires 'Mojolicious';
requires 'Class::Load';
requires 'IO::Socket::SSL';
requires 'Future::AsyncAwait';

on build => sub {
    requires 'FindBin';
    requires 'Test::Exception';
    requires 'Test::More';
    requires 'Data::Dumper::Concise';
};
