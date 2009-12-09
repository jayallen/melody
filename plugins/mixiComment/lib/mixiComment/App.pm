package mixiComment::App;

use strict;
use mixiComment::Auth::mixi;

sub login_blog_owner {
    my $app = shift;

    $app->param('verify_blog_owner', 1);
    mixiComment::Auth::mixi->login($app);
}

sub verify_blog_owner {
    my $app = shift;
    my $q   = $app->param;

    my $plugin = $app->component('mixicomment');
    return $app->errtrans('Invalid request') unless $plugin;

    my $blog_id = $q->param('blog_id');
    my $blog    = $app->model('blog')->load($blog_id);
    return $app->errtrans('Invalid blog') unless $blog;

    my %param = $app->param_hash;
    my $csr   = MT::Auth::OpenID::_get_csr(\%param, $blog)
        or return $app->errtrans('Invalid request');

    if ( my $setup_url = $csr->user_setup_url( post_grant => 'return' ) ) {
        return $app->redirect($setup_url);
    }
    elsif ( my $vident = $csr->verified_identity ) {
        my $url = $vident->url;
        my ($mixi_id) = $url =~ m|^https?://id.mixi.jp/(\d+)$|;
        return $app->error( $plugin->translate('mixi reported that you failed to login.  Try again.') )
            unless $mixi_id;

        $plugin->save_config(
            { mixi_id => $mixi_id },
            'blog:' . $blog->id
        );

        return $app->redirect(
            $app->uri(
                mode => 'cfg_plugins',
                args => { blog_id => $blog->id }
            )
        );
    }

    # login failed
    return $app->error( $plugin->translate('mixi reported that you failed to login.  Try again.') );
}

sub openid_commenter_condition {
    eval "require Digest::SHA1;";
    return 0 if $@;
    eval "require Crypt::SSLeay;";
    return 0 if $@;
    return 1;
}

sub commenter_auth_params {
    my ($key, $blog_id, $entry_id, $static) = @_;

    my %param;
    my $plugin = MT->component('mixicomment');
    $plugin->load_config(\%param, "blog:$blog_id");
    my $url;
    if ( my $mixi_id = $param{mixi_id} ) {
        $url = "https://id.mixi.jp/$mixi_id/friends";
    }
    else {
        $url = "http://mixi.jp/";
    }
    my $params = {
        blog_id => $blog_id,
        static  => $static,
        url     => $url,
    };
    $params->{entry_id} = $entry_id if defined $entry_id;
    return $params;
}

1;
__END__
