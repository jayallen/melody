package TypePadAntiSpam::Callbacks;
use strict;

sub pre_save_obj {
    my ($cb, $obj) = @_;
    my $plugin = MT->component('TypePadAntiSpam');
    if (!$obj->id && $obj->is_junk && ($obj->junk_log =~ m/TypePad AntiSpam says spam/)) {
        # this was junked due in part to TypePad AntiSpam
        if (my $blog = $obj->blog) {
            $plugin->blocked( $blog, $plugin->blocked($blog) + 1 );
        }
        # now increment total block count:
        $plugin->blocked( undef, $plugin->blocked() + 1 );
    }
}

sub handle_junk {
    my ($cb, $app, $thing) = @_;
    my $plugin = MT->component('TypePadAntiSpam');
    $plugin->require_tpas;
    my $key    = $plugin->is_valid_key($thing)       or return;
    my $sig    = $plugin->package_signature($thing)  or return;
    MT::TypePadAntiSpam->submit_spam($sig, $key);
}

sub handle_not_junk {
    my ($cb, $app, $thing) = @_;
    my $plugin = MT->component('TypePadAntiSpam');
    $plugin->require_tpas;
    my $key    = $plugin->is_valid_key($thing)       or return;
    my $sig    = $plugin->package_signature($thing)  or return;
    MT::TypePadAntiSpam->submit_ham($sig, $key);
}

1;

