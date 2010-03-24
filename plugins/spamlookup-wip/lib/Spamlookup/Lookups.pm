package Spamlookup::Lookups;
use strict;
use MT::JunkFilter qw(ABSTAIN);

sub ipbl {
    my $plugin = MT->component('SpamLookupLookups');
    my ($obj) = @_;
    return (ABSTAIN) unless $obj->ip;
    use Spamlookup::Util qw(domain_or_ip_in_whitelist);
    
    
    my $config = $plugin->get_config_hash('blog:'. $obj->blog_id); # config($plugin);
    return (ABSTAIN) unless $config->{ipbl_mode};

    my $remote_ip = $obj->ip;

    if (domain_or_ip_in_whitelist(undef, $remote_ip, $config->{whitelist})) {
        return (ABSTAIN);
    }

    my ($a, $b, $c, $d) = split /\./, $remote_ip;
    return (ABSTAIN) unless $a && $b && $c &&$d;

    my @ipbl_service = split /\s*,?\s+/, $config->{ipbl_service};
    return (ABSTAIN) unless @ipbl_service;

    foreach my $service (@ipbl_service) {
        $service =~ s/^\.//;
        $service =~ s/^\s+|\s+$//gs;
        if (checkdns("$d.$c.$b.$a.$service.")) {
            my $log = MT->translate("[_1] found on service [_2]", $remote_ip, $service);
            if ($config->{ipbl_mode} == 2) {
                $obj->moderate;
                return (0, $log);
            } else {
                return (-1 * (int($config->{ipbl_weight}) || 1), $log);
            }
        }
    }
    return (ABSTAIN);
}

sub domainbl {
    my $plugin = MT->component('SpamLookupLookups');
    my ($obj) = @_;

    my $config = $plugin->get_config_hash('blog:' . $obj->blog_id); # config($plugin);
    return (ABSTAIN) unless $config->{domainbl_mode};

    my @domainbl_service = split /\s*,?\s+/, $config->{domainbl_service};
    return (ABSTAIN) unless @domainbl_service;
    
    use Spamlookup::Util qw(extract_domains domain_or_ip_in_whitelist checkdns);
    
    my $text = $obj->all_text;
    my @domains = extract_domains($text);
    my $remote_ip = $obj->ip;

    if (domain_or_ip_in_whitelist(\@domains, $remote_ip, $config->{whitelist})) {
        return (ABSTAIN);
    }

    foreach my $domain (@domains) {
        next if $domain !~ m/\./;  # ignore domain if it is just a single word
        if ($domain =~ m/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/) {
            $domain = "$4.$3.$2.$1";
        }
        foreach my $service (@domainbl_service) {
            $service =~ s/^\.//;
            $service =~ s/^\s+|\s+$//gs;
            if (checkdns("$domain.$service.")) {
                my $log = MT->translate("domain '[_1]' found on service [_2]", $domain, $service);
                if ($config->{domainbl_mode} == 2) {
                    $obj->moderate;
                    return (0, $log);
                } else {
                    return (-1 * (int($config->{domainbl_weight}) || 1), $log);
                }
            }
        }
    }
    return (ABSTAIN);
}

sub tborigin {
    my $plugin = MT->component('SpamLookupLookups');
    my ($obj) = @_;

    # only filter TrackBack pings...
    return (ABSTAIN) unless UNIVERSAL::isa($obj, 'MT::TBPing');

    use Spamlookup::Util qw( domain_or_ip_in_whitelist extract_domains checkdns reversedns );

    my $domain = extract_domains($obj->source_url, 1);

    my $config = $plugin->get_config_hash('blog:' . $obj->blog_id); # config($plugin);
    my $pingip = $obj->ip;
    
    if (domain_or_ip_in_whitelist($domain, $pingip, $config->{whitelist})) {
        return (ABSTAIN);
    }

    my $score = int($config->{tborigin_weight}) || 1;
    my $domainip = checkdns($domain);
    if (!$domainip) {
        return (-1 * $score, MT->translate("Failed to resolve IP address for source URL [_1]", $obj->source_url));
    }

    my @domainip = split /\./, $domainip;
    my @pingip = split /\./, $pingip;
    
    my $distance = 4;
    foreach (0..3) {
        if ($domainip[$_] == $pingip[$_]) {
            $distance--; 
        } else {
            last;
        }
    }

    return (ABSTAIN) if $distance < 3;

    # reverse lookup ip address if we can. if it matches to the
    # domain of the source url, then ABSTAIN.

    my $hostname = reversedns($pingip);
    if ($hostname) {
        if (domain_or_ip_in_whitelist($hostname, undef, $config->{whitelist})) {
            return (ABSTAIN);
        }
        $domain = lc $domain;
        $hostname = lc $hostname;
        if ($domain =~ m/\Q$hostname\E$/) {
            return (ABSTAIN);
        }
    }

    # check distance of sender's IP. if it is too far from the
    # source url domain, moderate/junk it.
    if ($config->{tborigin_mode} == 2) {
        $obj->moderate;
        return (0, MT->translate("Moderating: Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]", $obj->source_url, $domainip, $pingip));
    }

    if ($config->{tborigin_mode} == 1) {
        return (-1 * $score,
            MT->translate("Domain IP does not match ping IP for source URL [_1]; domain IP: [_2]; ping IP: [_3]", $obj->source_url, $domainip, $pingip));
    }

    return (ABSTAIN);
}

1;
