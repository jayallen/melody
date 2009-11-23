use ExtUtils::MakeMaker;
use strict;

WriteMakefile(
    'NAME'             => 'Amazon::EC2',
    'VERSION_FROM'     => 'lib/Amazon/EC2.pm',
    'ABSTRACT_FROM'    => 'lib/Amazon/EC2.pm',
    'MIN_PERL_VERSION' => '5.6.1',
    'LICENSE'          => 'perl',
    'AUTHOR'           => 'Timothy Appnel <tima@cpan.org>',
    'PREREQ_PM'        => {'Test::More' => 0,},
    'META_MERGE'       => {
        'resources' => {
            'license'    => 'http://dev.perl.org/licenses/',
            'repository' => 'http://github.com/tima/perl-amazon-ec2',

            #'bugtracker' =>
            #  'http://rt.cpan.org/Public/Dist/Display.html?Name=Module-Name',
        },
    },
);
