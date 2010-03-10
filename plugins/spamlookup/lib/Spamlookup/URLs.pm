package Spamlookup::URLs;

use strict;
use MT::JunkFilter qw(ABSTAIN);

sub urls {
    my $plugin = shift;
    my ($obj) = @_;

    my $config = $plugin->get_config_hash('blog:' . $obj->blog_id); # config($plugin);

    # URL tests...

    # count URLs...
    my $nurls = 0;
    my $text = $obj->all_text;
    
    use Spamlookup::Util qw(extract_domains domain_or_ip_in_whitelist);
    
    my @domains = extract_domains($text, 0, \$nurls);

    if ($config->{urlcount_none_mode}) {
        return (int($config->{urlcount_none_weight}) || 1,
            MT->translate("No links are present in feedback")) unless $nurls;
    }

    my $domain;
    if (UNIVERSAL::isa($obj, 'MT::Comment')) {
        $domain = extract_domains($obj->url, 1);
    } elsif (UNIVERSAL::isa($obj, 'MT::TBPing')) {
        $domain = extract_domains($obj->source_url, 1);
    }

    my $pingip = $obj->ip;

    if (domain_or_ip_in_whitelist($nurls == 1 ? $domain : undef, $pingip, $config->{whitelist})) {
        return (ABSTAIN);
    }

    if ($config->{urlcount_junk_mode}) {
        if ($nurls >= $config->{urlcount_junk_limit}) {
            return (-1 * (int($config->{urlcount_junk_weight}) || 1),
                MT->translate("Number of links exceed junk limit ([_1])", $config->{urlcount_junk_limit}));
        }
    }

    if ($config->{urlcount_moderate_mode}) {
        if ($nurls >= $config->{urlcount_moderate_limit}) {
            $obj->moderate;
            return (0,
                MT->translate("Number of links exceed moderation limit ([_1])", $config->{urlcount_moderate_limit}));
        }
    }
    return (ABSTAIN);
}

sub link_memory {
    my $plugin = shift;
    my ($obj) = @_;

    my $config = $plugin->get_config_hash('blog:'.$obj->blog_id); # config($plugin);
    use Spamlookup::Util qw(extract_domains );
    
    
    if ($config->{priorurl_mode}) {
        # this lookup is only effective on SQL databases since the
        # comment_url column is unindexed.
        if (!UNIVERSAL::isa(MT::Object->driver, 'MT::ObjectDriver::DBM')) {
            if (UNIVERSAL::isa($obj, 'MT::Comment')) {
                my @textdomains = extract_domains($obj->text);
                if (!@textdomains) {
                    my $url = $obj->url || '';
                    $url =~ s/^\s+|\s+$//gs;
                    if ($url =~ m!https?://\w+!) { # valid url requirement...
                        require MT::Comment;
                        my $terms = { url => $url,
                            blog_id => $obj->blog_id,
                            visible => 1 };
                        my $args;
                        if (my $grey = $config->{priorurl_greyperiod}) {
                            my $ts = time;
                            $ts -= $grey * (24 * 60 * 60);
                            require MT::Util;
                            $ts = MT::Util::epoch2ts($obj->blog_id, $ts);
                            $terms->{created_on} = [undef, $ts];
                            $args->{range_incl}{created_on} = 1;
                        }
                        my $c = MT::Comment->load($terms, $args);
                        if ($c) {
                            return ((int($config->{priorurl_weight}) || 1),
                                MT->translate("Link was previously published (comment id [_1]).", $c->id));
                        }
                    }
                }
            } elsif (UNIVERSAL::isa($obj, 'MT::TBPing')) {
                my $url = $obj->source_url || '';
                $url =~ s/^\s+|\s+$//gs;
                my $terms = { source_url => $url,
                    blog_id => $obj->blog_id,
                    visible => 1 };
                my $args;
                if ($config->{priorurl_greyperiod_mode}) {
                    my $grey = $config->{priorurl_greyperiod};
                    my $ts = time;
                    $ts -= $grey * (24 * 60 * 60);
                    require MT::Util;
                    $ts = MT::Util::epoch2ts($obj->blog_id, $ts);
                    $terms->{created_on} = [undef, $ts];
                    $args->{range_incl}{created_on} = 1;
                }
                my $t = MT::TBPing->load($terms, $args);
                if ($t) {
                    return ((int($config->{priorurl_weight}) || 1),
                        MT->translate("Link was previously published (TrackBack id [_1]).", $t->id));
                }
            }
        }
    }
    return (ABSTAIN);
}

sub email_memory {
    my $plugin = shift;
    my ($obj) = @_;

    my $config = $plugin->get_config_hash('blog:'. $obj->blog_id);

    if ($config->{prioremail_mode}) {
        # this lookup is only effective on SQL databases since the
        # comment_url collumn is unindexed.
        if (UNIVERSAL::isa($obj, 'MT::Comment')) {
            my $email = $obj->email;
            $email =~ s/^\s+|\s+$//gs;
            if ($email =~ m/\w+@\w+/) {
                require MT::Comment;
                my $terms = { email => $email,
                    blog_id => $obj->blog_id,
                    visible => 1 };
                my $args;
                if ($config->{prioremail_greyperiod}) {
                    my $grey = $config->{prioremail_greyperiod};
                    my $ts = time;
                    $ts -= $grey * (24 * 60 * 60);
                    require MT::Util;
                    $ts = MT::Util::epoch2ts($obj->blog_id, $ts);
                    $terms->{created_on} = [undef, $ts];
                    $args->{range_incl}{created_on} = 1;
                }
                my $c = MT::Comment->load($terms, $args);
                if ($c) {
                    return ((int($config->{prioremail_weight}) || 1),
                        MT->translate("E-mail was previously published (comment id [_1]).", $c->id));
                }
            }
        }
    }

    return (ABSTAIN);
}

1;

