use ExtUtils::MakeMaker;
use strict;

use lib 'lib';
use lib 'extlib';

WriteMakefile(
    'NAME'         => 'Melody',
    'VERSION_FROM' => 'lib/MT.pm',
    'ABSTRACT' =>
      'Melody is an open source content management, blogging and publishing platform, derived from the popular blogging tool Movable Type.',
    'MIN_PERL_VERSION' => '5.8.8',
    'LICENSE'          => 'gpl',
    'AUTHOR'           => 'Open Melody Software Group <admin@openmelody.org>',
    'PREREQ_PM'        => {

# required NoXS
        'Algorithm::Diff'          => '1.1902',
        'Cache'                    => '2.04',
        'CGI'                      => '3.45',
        'Class::Accessor'          => '0.22',
        'Class::Data::Inheritable' => '0.06',
        'Class::Trigger'           => '0.1001',
        'Data::ObjectDriver'       => '0.06',
        'File::Copy::Recursive'    => '0.23',
        'Heap::Fibonacci'          => '0.71',
        'HTML::Diff'               => '0.561',
        'Image::Size'              => '2.93',
        'Jcode'                    => '0.88',
        'JSON'                     => '2.12',
        'Locale::Maketext'         => '1.13',
        'Log::Dispatch'            => '2.26',
        'Log::Log4perl'            => '1.3',
        'Lucene::QueryParser'      => '1.04',
        'LWP'                      => '5.831',
        'Params::Validate'         => '0.73',
        'Sub::Install'             => '0.925',
        'TheSchwartz'              => '1.07',
        'URI'                      => '1.36',
        'version'                  => '0.76',
        'YAML::Tiny'               => '1.12',

#required XS
        'Digest::SHA1' => '0.06',
        'HTML::Parser' => '3.66',
        'DBI'          => '1.21',

#optional
        'bignum'                => '0.17',
        'Crypt::DH'             => '0.06',
        'IO::Scalar'            => '2.110',
        'Mail::Sendmail'        => 0,
        'Math::BigInt'          => '1.63',
        'MIME::Charset'         => '0.044',
        'MIME::EncWords'        => '0.040',
        'Net::OpenID::Consumer' => '1.03',
        'Path::Class'           => '0.21',
        'SOAP::Lite'            => '0.710.08',
        'XML::NamespaceSupport' => '1.09',
        'XML::SAX'              => '0.96',
        'XML::Simple'           => '2.14',

        # For Testing
        # From Bundle::Melody::Test (please keep in sync)
        'Devel::Cover'        => 0,
        'Scalar::Util'        => 0,
        'Test::Class'         => 0,
        'Test::Deep'          => 0,
        'Test::Manifest'      => 0,
        'Test::More'          => 0,
        'Test::PerlTidy'      => 0,
        'Test::Pod'           => 0,
        'Test::Pod::Coverage' => 0,
        'Test::Strict'        => 0,
    },
    'META_MERGE' => {
           'resources' => {
               'license'    => 'http://dev.perl.org/licenses/',
               'repository' => 'http://github.com/openmelody/melody',
               'bugtracker' =>
                 'https://openmelody.lighthouseapp.com/projects/26604-melody',
           },
    },
);
