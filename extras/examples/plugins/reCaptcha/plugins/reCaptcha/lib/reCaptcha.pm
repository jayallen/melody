# reCaptcha plugin for Movable Type
# Author: Six Apart (http://www.sixapart.com)
# Released under the Artistic License
#
# $Id$

package reCaptcha;

use strict;
use warnings;
use base qw(MT::ErrorHandler);

sub form_fields {
    my $self = shift;
	
	my $plugin = MT::Plugin::reCaptcha->instance;
    my $config = $plugin->get_config_hash();
    my $publickey = $config->{recaptcha_publickey};
    my $privatekey = $config->{recaptcha_privatekey};
	return q() unless $publickey && $privatekey;

    return <<FORM_FIELD;
<script type="text/javascript"
   src="http://api.recaptcha.net/challenge?k=$publickey">
</script>

<noscript>
   <iframe src="http://api.recaptcha.net/noscript?k=$publickey"
       height="300" width="500" frameborder="0"></iframe><br>
   <textarea name="recaptcha_challenge_field" rows="3" cols="40">
   </textarea>
   <input type="hidden" name="recaptcha_response_field" 
       value="manual_challenge">
</noscript>
FORM_FIELD
}

sub validate_captcha {
    my $self = shift;
    my ($app) = @_;

    my $config = MT::Plugin::reCaptcha->instance->get_config_hash();
    my $privatekey = $config->{recaptcha_privatekey};
 
    my $challenge = $app->param('recaptcha_challenge_field');
    my $response = $app->param('recaptcha_response_field');
    my $ua = $app->new_ua;
    return 0 unless $ua;
    $ua->max_size(undef) if $ua->can('max_size');

	require HTTP::Request;
    my $req = HTTP::Request->new(POST => 'http://api-verify.recaptcha.net/verify');
    $req->content_type("application/x-www-form-urlencoded");
	require MT::Util;
	my $content = 'privatekey=' . MT::Util::encode_url($privatekey);
	$content .= '&remoteip=' . MT::Util::encode_url($app->remote_ip);
	$content .= '&challenge=' . MT::Util::encode_url($challenge);
	$content .= '&response=' . MT::Util::encode_url($response);
    $req->content($content);
    my $res = $ua->request($req);
    my $c = $res->content;
    if (substr($res->code, 0, 1) eq '2') {
		return 1 if $c =~ /^true\n/;
	}
	0;
}
    
sub generate_captcha {
    #This won't be called since there is no link which requests to "generate_captcha" mode.
    my $self = shift;
    1;
}

1;
