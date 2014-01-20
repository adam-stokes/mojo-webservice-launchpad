requires 'Mojo::Base';
requires 'Mojo::JSON';
requires 'Mojo::Parameters';
requires 'Mojo::URL';
requires 'Mojo::UserAgent';

on configure => sub {
    requires 'Module::Build::Tiny', '0.031';
    requires 'perl', '5.008005';
};

on test => sub {
    requires 'Test::More';
};
