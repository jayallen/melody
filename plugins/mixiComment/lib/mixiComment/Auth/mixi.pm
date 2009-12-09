package mixiComment::Auth::mixi;

use strict;
use base qw( MT::Auth::OpenID );

sub check_url_params {
    my $class = shift;
    my ( $app, $blog ) = @_;
    my $q = $app->{query};

    if ( $q->param('verify_blog_owner') ) {
        my $path = MT->config->AdminCGIPath || MT->config->CGIPath;
        $path = _adjust_path( $path, $blog );
        $path .= MT->config->AdminScript;
        my $return_to = $path . '?__mode=mixicomment_verify_blog_owner'
            . '&blog_id='  . $blog->id;
        return ( trust_root => $path, return_to => $return_to, delayed_return => 1 );
    }
    else {
        my %params = $class->SUPER::check_url_params(@_);
        $params{delayed_return} = 1;
        return %params;
    }
}

sub _adjust_path {
    my ( $path, $blog ) = @_;
    if ($path =~ m!^/!) {
        # relative path, prepend blog domain
        my ($blog_domain) = $blog->archive_url =~ m|(.+://[^/]+)|;
        $path = $blog_domain . $path;
    }
    $path .= '/' unless $path =~ m|/$|;
    $path;
}

sub set_extension_args {
    my $class = shift;
    my ( $claimed_identity ) = @_;

    $claimed_identity->set_extension_args(MT::Auth::OpenID::NS_OPENID_SREG(), {
        optional => join(",", qw/email nickname fullname/)
    });
}

sub get_nickname {
    my $class = shift;
    my ($vident) = @_;

    # Try SREG extension first
    my $fields = $vident->extension_fields(MT::Auth::OpenID::NS_OPENID_SREG());
    my $nick = $fields->{nickname} if exists $fields->{nickname};
    $nick ||= $fields->{fullname} if exists $fields->{fullname};
    if ( $nick ) {
        if ( MT->config->PublishCharset !~ /utf-?8/i ) {
            $nick = MT::I18N::encode_text( MT::Util::decode_url($nick), 'UTF-8', MT->config->PublishCharset );
        }
        return $nick;
    }
    $class->SUPER::get_nickname(@_);
}

1;
__END__
