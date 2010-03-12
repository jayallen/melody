package Textile::MovableType::Plugin;
use strict;

our ($_initialized, $Have_SmartyPants);

sub _init {
    require Text::Textile;
    @MT::Textile::ISA = qw(Text::Textile);
    $Have_SmartyPants = defined &SmartyPants::SmartyPants ? 1 : 0;
    $_initialized = 1;
}

sub textile_2 {
    my ($str, $ctx) = @_;

    _init() unless $_initialized;

    my $textile;
    if ((defined $ctx)  && (ref($ctx) eq 'MT::Template::Context')) {
        $textile = $ctx->stash('TextileObj');
        unless ($textile) {
            $textile = _new_textile($ctx);
            $ctx->stash('TextileObj', $textile);
        }
        $textile->head_offset($ctx->stash('TextileHeadOffsetStart') || 0);
        if (my $opts = $ctx->stash('TextileOptions')) {
            $textile->set($_, $opts->{$_}) foreach keys %$opts;
            # now clear the options from the stash so we don't
            # repeat this for each invocation of textile...
            $ctx->stash('TextileOptions', undef);
        }

        # reduces circular references
        # $textile->filter_param($ctx);
        require MT::Util;
        MT::Util::weaken( $textile->{filter_param} = $ctx );
    } else {
        # no Context object...
        $textile = _new_textile();
    }

    require MT::I18N;
    $str = MT::I18N::encode_text( $str, MT->instance->config->PublishCharset, 'utf-8' );

    $str = $textile->process($str);

    if ((defined $ctx) && (ref($ctx) eq 'MT::Template::Context')) {
        my $entry = $ctx->stash('entry');
        if ($entry && $entry->id) {
            my $link = $entry->permalink;
            $link =~ s/#.+$//;
            $str =~ s/(<a .*?(?<=[ ])href=")(#fn(?:\d)+".*?>)/$1$link$2/g;
        }
    }

    # invoke MT-CodeBeautifier for any <code> or <blockcode> tags that
    # specify a 'language' attribute:
    my $beautifier = defined &Voisen::CodeBeautifier::beautifier;
    if ($beautifier) {
        $str =~ s|<((block)?code)([^>]*?) language="([^"]+?)"([^>]*?)>(.+?)</\1>|_highlight($1, $3, $5, $4, $textile->decode_html($6))|ges; # "
    }

    $str = MT::I18N::encode_text( $str, 'utf-8', MT->instance->config->PublishCharset );

    $str;
}

sub _new_textile {
    my ($ctx) = @_;

    my $textile = new MT::Textile;

    # this copies the named filters from MT to TextileFormat
    my %list;
    my $filters = MT::all_text_filters();
    foreach my $name (keys %$filters) {
        $list{$name} = $filters->{$name}{on_format};
    }
    $textile->filters(\%list);

    my $cfg = MT::ConfigMgr->instance;

    if ($cfg->NoHTMLEntities) {
        $textile->char_encoding(0);
    }

    $textile->charset('utf-8');

    $textile;
}

sub Textile {
    my ($ctx, $args, $cond) = @_;
    _init() unless $_initialized;
    local $ctx->{__stash}{TextileObj} = _new_textile($ctx);
    local $ctx->{__stash}{TextileOptions} = $args if keys %$args;
    my $str = $ctx->slurp;
    textile_2($str, $ctx);
}

sub TextileHeadOffset {
    my ($ctx, $args, $cond) = @_;
    my $start = $args->{start};
    if ($start && $start =~ m/^\d+$/ && $start >= 1 && $start <= 6) {
        $ctx->stash('TextileHeadOffsetStart', $start);
    }
    '';
}

sub TextileOptions {
    my ($ctx, $args, $cond) = @_;
    $ctx->stash('TextileOptions', $args);
    '';
}

sub _highlight {
    my ($tag, $attr1, $attr2, $lang, $code) = @_;
    my $tagopen = '<'.$tag;
    $tagopen .= $attr1 if defined $attr1;
    $tagopen .= $attr2 if defined $attr2;
    $tagopen .= '>';
    if ($lang =~ m/perl/i) {
        $code = Voisen::CodeBeautifier::highlight_perl($code);
    } elsif ($lang =~ m/php/i) {
        $code = Voisen::CodeBeautifier::highlight_php3($code);
    } elsif ($lang =~ m/java/i) {
        $code = Voisen::CodeBeautifier::highlight_java($code);
    } elsif (($lang =~ m/actionscript/i) || ($lang =~ m/as/i)) {
        $code = Voisen::CodeBeautifier::highlight_as($code);
    } elsif ($lang =~ m/scheme/i) {
        $code = Voisen::CodeBeautifier::highlight_scheme($code);
    }
    $code =~ s!^<pre>!!;
    $code =~ s!</pre>$!!;
    return $tagopen . $code .'</'.$tag.'>';
}

# This is a Text::Textile subclass that provides enhanced
# functionality for Movable Type integration

package MT::Textile;

sub image_size {
    my $self = shift;
    my ($src) = @_;
    my $ctx = $self->filter_param;
    if ($src !~ m|^http:| && $ctx) {
        my $blog = $ctx->stash('blog');
        if ($blog) {
            require File::Spec;
            # local image -- calc size
            my $file;
            if (($src =~ m!^/!) && (exists $ENV{DOCUMENT_ROOT})) {
                $file = File::Spec->catfile($ENV{DOCUMENT_ROOT}, $src);
            } else {
                $file = File::Spec->catfile($blog->site_path, $src);
            }
            if (-f $file) {
                eval {require MT::Image;};
                if (!$@) {
                    my $img = MT::Image->new(Filename => $file);
                    if ($img) {
                        return $img->get_dimensions;
                    }
                }
            }
        }
    }
    undef;
}

sub format_link {
    my $self = shift;
    my (%args) = @_;
    my $title = exists $args{title} ? $args{title} : '';
    my $url = exists $args{url} ? $args{url} : '';
    my $ctx = $self->filter_param;
    if ($url =~ m/^\d+$/ && $ctx) {
        my $blog = $ctx->stash('blog');
        if ($blog) {
            require MT::Entry;
            my $entry = MT::Entry->load({ blog_id => $blog->id, id => $url });
            if ($entry) {
                local $ctx->{__stash}{entry} = $entry;
                my $relurl = MT::Template::Context::_hdlr_blog_url($ctx);
                my $regrelurl = quotemeta($relurl);
                $args{url} = MT::Template::Context::_hdlr_entry_permalink($ctx);
                $args{url} =~ s/^.*?($regrelurl)/$1/;
                if ((!exists $args{title}) && ($entry->title)) {
                    require MT::Util;
                    my $title = MT::Util::remove_html($entry->title); # strip HTML
                    $title =~ s/"/&quot;/g; # convert double quotes to entities
                    $args{title} = $title;
                }
            }
        }
    }

    $self->SUPER::format_link(%args);
}

sub process_quotes {
    my $self = shift;
    my ($str) = @_;
    return $str unless $self->{do_quotes};
    if ($plugins::textile2::Have_SmartyPants) {
        $str = SmartyPants::SmartyPants($str, $self->{smarty_mode});
    }
    $str;
}

sub format_url {
    my $self = shift;
    my (%args) = @_;
    my $url = exists $args{url} ? $args{url} : '';
    my $ctx = $self->filter_param;
    if ($url =~ m/^\d+$/ && $ctx) {
        # looks like an entry id, so let's link it
        my $blog = $ctx->stash('blog');
        if ($blog) {
            require MT::Entry;
            my $entry = MT::Entry->load({'blog_id' => $blog->id, 'id'=>$url});
            if ($entry) {
                local $ctx->{__stash}{entry} = $entry;
                my $relurl = MT::Template::Context::_hdlr_blog_relative_url($ctx);
                my $regrelurl = quotemeta($relurl);
                $args{url} = MT::Template::Context::_hdlr_entry_permalink($ctx);
                $args{url} =~ s/^.+?($regrelurl)/$1/;
            }
        }
    } elsif ($url =~ m/^imdb(?::(.+))?$/) {
        my $term = $1;
        $term ||= MT::Util::remove_html($args{linktext}||'');
        $args{url} = 'http://www.imdb.com/Find?for=' . $term;
    } elsif ($url =~ m/^google(?::(.+))?$/) {
        my $term = $1;
        $term ||= MT::Util::remove_html($args{linktext}||'');
        $args{url} = 'http://www.google.com/search?q=' . $term;
    } elsif ($url =~ m/^dict(?::(.+))?$/) {
        my $term = $1;
        $term ||= MT::Util::remove_html($args{linktext}||'');
        $args{url} = 'http://www.dictionary.com/search?q=' . $term;
    } elsif ($url =~ m/^amazon(?::(.+))?$/) {
        my $term = $1;
        $term ||= MT::Util::remove_html($args{linktext}||'');
        $args{url} = 'http://www.amazon.com/exec/obidos/external-search?index=blended&keyword=' . $term;
    }
    $self->SUPER::format_url(%args);
}

1;

