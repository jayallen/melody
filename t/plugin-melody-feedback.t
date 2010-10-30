#!/usr/bin/perl

use strict;
use warnings;

use lib 't/lib', 'plugins/MelodyFeedback/lib', 'lib', 'extlib';
use MT::Test;

use Test::More tests => 4;

use MT::App::CMS;
use MT::App::Comments;
use MT::Callback;
use Melody::Feedback;

# Test data;
my $cms      = MT::App::CMS->new;
my $comments = MT::App::Comments->new;

use_ok('Melody::Feedback');

# Using faux template objects since MT::Template doesn't
# have an accessor method anyways.
my $pass_regex = qr/feedback_widget_options/;    # common string in GS widget
my $tmpl1 = {'__file' => 'dashboard.tmpl'};
my $tmpl2 = {'__file' => 'popup/rebuilt.tmpl'};
my $tmpl3 = {'__file' => 'login.tmpl'};
my $out;
my $html =
  "<html>\n\n<body>\nwhatever\n<br/></p>body copy\t\t<br />\tbody copy\t\rbody copy\n</BOdY></html>";
my $cb = MT::Callback->new(
    'name' => 'MT::App::CMS::template_output',
    'code' => \&Melody::Feedback::cb_insert_tab,
);    # not sure this is necessary for our purposes here but...

# We're going direct here so what this doesn't test is if
# the callback hook is registered and being called.

# We're also not checking if an error is being returned from
# the callback.

$out = $html;
$cb->invoke($cms, \$out, {}, $tmpl1);
ok($out =~ m{$pass_regex}, 'Injects GS widget in to CMS app template');

$out = $html;
$cb->invoke($cms, \$out, {}, $tmpl2);
ok($out !~ m{$pass_regex},
    'Does not inject GS widget in to CMS popup app template');

$out = $html;
$cb->invoke($comments, \$out, {}, $tmpl3);
ok($out !~ m{$pass_regex},
    'Does not inject GS widget in to comments app template');

1;    # done.
