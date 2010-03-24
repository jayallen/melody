package Spamlookup::Util;
use strict;
use MT::JunkFilter qw(ABSTAIN);
use Exporter;
use base qw(Exporter);
use vars qw( @EXPORT_OK );
@EXPORT_OK = qw( checkdns reversedns extract_domains decode_entities wordlist_match domain_or_ip_in_whitelist );

sub checkdns {
    my ($name) = @_;
    if ($name =~ m/^\d+\.\d+\.\d+\.\d+$/) {
        return $name;
    }
    require MT::Request;
    my $cache = MT::Request->instance->cache('checkdns_cache') || {};
    return $cache->{$name} if exists $cache->{$name};
    my $iaddr = gethostbyname($name);
    return 0 unless $iaddr;
    require Socket;
    my $ip = Socket::inet_ntoa($iaddr);
    $cache->{$name} = $ip;
    MT::Request->instance->cache('checkdns_cache', $cache);
    return $ip ? $ip : undef;
}

sub reversedns {
    my ($ip) = @_;
    require MT::Request;
    my $cache = MT::Request->instance->cache('reversedns_cache') || {};
    return $cache->{$ip} if exists $cache->{$ip};
    require Socket;
    my $iaddr = Socket::inet_aton($ip);
    my $name = gethostbyaddr($iaddr, Socket::AF_INET());
    return undef unless $name;
    $cache->{$ip} = $name;
    MT::Request->instance->cache('reversedns_cache', $cache);
    return $name;
}

sub extract_domains {
    my ($str, $mode, $total) = @_;

    $mode ||= 0;
    # unmunge so we can see encoded urls as well
    $str = lc decode_entities($str);
    my @urls;
    my %seen;
    while ($str =~ m!(?:ht(?:tp)?s?:)?//(?:[a-z0-9\-\.\+:]+@)?([a-z0-9\.\-]+)!gi) {
        my $domain = $1;
        $domain =~ s/^\s+//s;
        $domain =~ s/\s+$//s;
        $domain =~ s/^www\.//s;
        next unless $domain;
        next unless $domain =~ m/\./;
        my @parts = split /\./, $domain;
        next unless @parts;
        if (($domain =~ m/^\d+\.\d+\.\d+\.\d+$/) || ($domain =~ m/^\d+$/)) {
            $$total++ if(defined($total));
            next if $seen{$domain};
            $seen{$domain} = 1;
            push @urls, $domain;
            next;
        }
        return $domain if $mode == 1;
        $$total++ if(defined($total));
        next if $seen{$domain};
        if ($mode == 0) {  # default mode, replicate for all subdomains
            my $last = $#parts;
            my $start = length($parts[$last]) < 3 ? 2 : 1;
            if ($start > $last) {
                $seen{$domain} = 1;
                push @urls, $domain;
            }
            foreach (my $i = $start; $i <= $last; $i++) {
                my $partial = join '.', @parts[$last - $i .. $last];
                next if $seen{$partial};
                $seen{$partial} = 1;
                push @urls, $partial;
            }
        } else {
            $seen{$domain} = 1;
            push @urls, $domain;
        }
    }

    @urls;
}

sub decode_entities {
    my ($str) = @_;
    if (eval { require HTML::Entities; 1 }) {
        return HTML::Entities::decode($str);
    } else {
        # yanked from HTML::Entities, since some users don't have the module
        my $c;
        for ($str) {
            s/(&\#(\d+);?)/$2 < 256 ? chr($2) : $1/eg;
            s/(&\#[xX]([0-9a-fA-F]+);?)/$c = hex($2); $c < 256 ? chr($c) : $1/eg;
        }
        $str;
    }
}
{
    my $has_encode = eval { require Encode; 1; };

sub wordlist_match {
    my ($text, $patterns) = @_;

    my $enc = MT::ConfigMgr->instance->PublishCharset;
    if ($has_encode) {
        $text = Encode::decode($enc, $text);
        $patterns = Encode::decode($enc, $patterns);
    }

    $text ||= '';
    my @patt = split /[\r\n]+/, $patterns;
    my @matches;
    foreach my $patt (@patt) {
        next if $patt =~ m/^#/;
        my $score = 1;
        if ($patt =~ m/^(.*?) (\d+(?:\.\d+)?) *$/) {
            $patt = $1;
            $score = $2;
        }
        $patt =~ s/(^ +| +$)//g;
        next if $patt eq '';

        my $re_opt = MT::ConfigMgr->instance->DefaultLanguage eq 'ja' ? '' : '\b';
        if ($patt =~ m!^/!) {
            my $re = $patt;
            my ($opt) = $re =~ m!/([^/]*)$!;
            $re =~ s!^/!!;
            $re =~ s!/[^/]*$!!;
            if ($opt) {
                # increment any internal backreferences (\1),
                # since we're wrapping the whole expression in
                # a capturing group
                $re =~ s/ \\(\d+) / '\\' . ($1 + 1) /gex;

                $re = '(?' . $opt . ':' . $re . ')';
            }
            $re = eval { qr/($re)/ };
            $re = $re_opt . quotemeta($patt) . $re_opt if $@;
            if ($has_encode) {
                push @matches, [ Encode::encode($enc, $patt),
                    Encode::encode($enc, $1), int($score) ] if $text =~ m/($re)/;
            } else {
                push @matches, [ $patt, $1, int($score) ] if $text =~ m/($re)/;
            }
        } else {
            my $re = $re_opt . quotemeta($patt) . $re_opt;
            if ($has_encode) {
                push @matches, [ Encode::encode($enc, $patt),
                    Encode::encode($enc, $1), int($score) ] if $text =~ m/($re)/i;
            } else {
                push @matches, [ $patt, $1, int($score) ] if $text =~ m/($re)/i;
            }
        }
    }
    @matches;
}
}

sub domain_or_ip_in_whitelist {
    my ($domain, $ip, $whitelist) = @_;

    if (ref $domain eq 'ARRAY') {
        my %domains;
        foreach my $domain (@$domain) {
            my @whitelist = split /\r?\n/, $whitelist;
            foreach my $whiteitem (@whitelist) {
                next if $whiteitem =~ m/^#/;
                if ($whiteitem =~ m/^\d{1,3}\.(?:\d{1,3}\.(?:\d{1,3}\.(?:\d{1,3})?)?)?$/) {
                    return 1 if defined $ip && ($ip =~ m/^\Q$whiteitem\E/);
                } elsif ($whiteitem =~ m/\w/) {
                    next if defined $domain && ($domain =~ m/\Q$whiteitem\E$/i);
                    $domains{$domain} = 1;
                }
            }
        }
        @$domain = keys %domains;
        return 0;
    }

    $whitelist ||= '';
    my @whitelist = split /\r?\n/, $whitelist;
    foreach my $whiteitem (@whitelist) {
        next if $whiteitem =~ m/^#/;
        if ($whiteitem =~ m/^\d{1,3}\.(?:\d{1,3}\.(?:\d{1,3}\.(?:\d{1,3})?)?)?$/) {
            return 1 if defined $ip && ($ip =~ m/^\Q$whiteitem\E/);
        } elsif ($whiteitem =~ m/\w/) {
            return 1 if defined $domain && ($domain =~ m/\Q$whiteitem\E$/i);
        }
    }

    return 0;
}

1;
