# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::Builder;

use strict;
use base qw( MT::ErrorHandler );

use constant NODE => 'MT::Template::Node';

sub new { bless { }, $_[0] }

sub compile {
    my $build = shift;
    my($ctx, $text, $opt) = @_;
    my $tmpl;

    $opt ||= { uncompiled => 1 };
    my $depth = $opt->{depth} ||= 0;

    my $ids;
    my $classes;
    my $errors;

    # handle $builder->compile($template) signature
    if (UNIVERSAL::isa($ctx, 'MT::Template')) {
        $tmpl = $ctx;
        $ctx = $tmpl->context;
        $text = $tmpl->text;
        $tmpl->reset_tokens();
        $ids = $build->{__state}{ids} = {};
        $classes = $build->{__state}{classes} = {};
        $errors = $build->{__state}{errors} = [];
        $build->{__state}{tmpl} = $tmpl;
    } else {
        $ids = $build->{__state}{ids} || {};
        $classes = $build->{__state}{classes} || {};
        $tmpl = $build->{__state}{tmpl};
        $errors = $build->{__state}{errors} ||= [];
    }

    return [ ] unless defined $text;

    my $mods;

    # Translate any HTML::Template markup into native MT syntax.
    if ($text =~ m/<(?:MT_TRANS\b|MT_ACTION\b|(?:tmpl_(?:if|loop|unless|else|var|include)))/i) {
        translate_html_tmpl($text);
    }

    my $state = $build->{__state};
    local $state->{tokens} = [];
    local $state->{classes} = $classes;
    local $state->{tmpl} = $tmpl;
    local $state->{ids} = $ids;
    local $state->{text} = \$text;

    my $pos = 0;
    my $len = length $text;
    # MT tag syntax: <MTFoo>, <$MTFoo$>, <$MTFoo>
    #                <MT:Foo>, <$MT:Foo>, <$MT:Foo$>
    #                <MTFoo:Bar>, <$MTFoo:Bar>, <$MTFoo:Bar$>
    # For 'function' tags, the '$' characters are optional
    # For namespace, the ':' is optional for the default 'MT' namespace.
    # Other namespaces (like 'Foo') would require the colon.
    # Tag and attributes are case-insensitive. So you can write:
    #   <mtfoo>...</MTFOO>
    while ($text =~ m!(<\$?(MT:?)((?:<[^>]+?>|"[^"]*?"|'[^']*?'|.)+?)[\$/]?>)!gis) {
        my($whole_tag, $prefix, $tag) = ($1, $2, $3);
        ($tag, my($args)) = split /\s+/, $tag, 2;
        my $sec_start = pos $text;
        my $tag_start = $sec_start - length $whole_tag;
        _text_block($state, $pos, $tag_start) if $pos < $tag_start;
        $args ||= '';
        # Structure of a node:
        #   tag name, attribute hashref, contained tokens, template text,
        #       attributes arrayref, parent array reference
        my $rec = bless [ $tag, \my %args, undef, undef, \my @args ], NODE;
        while ($args =~ /
            (?:
                (?:
                    (\w+)                           #1
                    \s*=\s*
                    (?:(?:
                        (["'])                      #2
                        ((?:<[^>]+?>|.)*?)          #3
                        \2
                        (                           #4
                            (?:
                                [,:]
                                (["'])              #5
                                (?:(?:<[^>]+?>|.)*?)
                                \5
                            )+
                        )?
                    ) |
                    (\S+))                          #6
                )
            ) |
            (\w+)                                   #7
            /gsx) {
            if (defined $7) {
                # An unnamed attribute gets stored in the 'name' argument.
                $args{'name'} = $7;
            } else {
                my $attr = lc $1;
                my $value = defined $6 ? $6 : $3;
                my $extra = $4;
                if (defined $extra) {
                    my @extra;
                    push @extra, $2 while $extra =~ m/[,:](["'])((?:<[^>]+?>|.)*?)\1/gs;
                    $value = [ $value, @extra ];
                }
                # We need a reference to the filters to check
                # attributes and whether they need to be in the array of
                # attributes for post-processing.
                $mods ||= $ctx->{__filters};
                push @args, [$attr, $value] if exists $mods->{$attr};
                $args{$attr} = $value;
                if ($attr eq 'id') {
                    # store a reference to this token based on the 'id' for it
                    $ids->{$3} = $rec;
                } 
                elsif ($attr eq 'class') {
                    # store a reference to this token based on the 'id' for it
                    $classes->{lc $3} ||= [];
                    push @{ $classes->{lc $3} }, $rec;
                }
            }
        }
        my($h, $is_container) = $ctx->handler_for($tag);
        if (!$h) {
            # determine line #
            my $pre_error = substr($text, 0, $tag_start);
            my @m = $pre_error =~ m/\r?\n/g;
            my $line = scalar @m;
            if ($depth) {
                $opt->{error_line} = $line;
                push @$errors, { message => MT->translate("<[_1]> at line [_2] is unrecognized.", $prefix . $tag, "#"), line => $line };
            } else {
                push @$errors, { message => MT->translate("<[_1]> at line [_2] is unrecognized.", $prefix . $tag, $line + 1), line => $line };
            }
        }
        if ($is_container) {
            if ($whole_tag !~ m|/>$|) {
                my ($sec_end, $tag_end) = _consume_up_to(\$text,$sec_start,$tag);
                if ($sec_end) {
                    my $sec = $tag =~ m/ignore/i ? '' # ignore MTIgnore blocks
                            : substr $text, $sec_start, $sec_end - $sec_start;
                    if ($sec !~ m/<\$?MT/i) {
                        $rec->[2] = [ ($sec ne '' ? ['TEXT', $sec ] : ()) ];
                    }
                    else {
                        local $opt->{depth} = $opt->{depth} + 1;
                        local $opt->{parent} = $rec;
                        $rec->[2] = $build->compile($ctx, $sec, $opt);
                        if ( @$errors ) {
                            my $pre_error = substr($text, 0, $sec_start);
                            my @m = $pre_error =~ m/\r?\n/g;
                            my $line = scalar @m;
                            foreach (@$errors) {
                                $line += $_->{line};
                                $_->{line} = $line;
                                $_->{message} =~ s/#/$line/;
                            }
                        }
                        # unless (defined $rec->[2]) {
                        #     my $pre_error = substr($text, 0, $sec_start);
                        #     my @m = $pre_error =~ m/\r?\n/g;
                        #     my $line = scalar @m;
                        #     if ($depth) {
                        #         $opt->{error_line} = $line + ($opt->{error_line} || 0);
                        #         return;
                        #     }
                        #     else {
                        #         $line += ($opt->{error_line} || 0) + 1;
                        #         my $err = $build->errstr;
                        #         $err =~ s/#/$line/;
                        #         return $build->error($err);
                        #     }
                        # }
                    }
                    $rec->[3] = $sec if $opt->{uncompiled};
                }
                else {
                    my $pre_error = substr($text, 0, $tag_start);
                    my @m = $pre_error =~ m/\r?\n/g;
                    my $line = scalar @m;
                    if ($depth) {
                        # $opt->{error_line} = $line;
                        # return $build->error(MT->translate("<[_1]> with no </[_1]> on line #", $prefix . $tag));
                        push @$errors, { message => MT->translate("<[_1]> with no </[_1]> on line [_2].", $prefix . $tag, "#" ), line => $line };
                    }
                    else {
                        push @$errors, { message => MT->translate("<[_1]> with no </[_1]> on line [_2].", $prefix . $tag, $line +1 ), line => $line + 1 };
                        # return $build->error(MT->translate("<[_1]> with no </[_1]> on line [_2]", $prefix . $tag, $line + 1));
                    }
                    last; # return undef;
                }
                $pos = $tag_end + 1;
                (pos $text) = $tag_end;
            }
            else {
                $rec->[3] = '';
            }
        }
        $rec->[5] = $opt->{parent} || $tmpl;
        $rec->[6] = $tmpl;
        push @{ $state->{tokens} }, $rec;
        $pos = pos $text;
    }
    _text_block($state, $pos, $len) if $pos < $len;
    if (defined $tmpl) {
        # assign token and id references to template
        $tmpl->tokens($state->{tokens});
        $tmpl->token_ids($state->{ids});
        $tmpl->token_classes($state->{classes});
        $tmpl->errors($state->{errors})
            if $state->{errors} && (@{$state->{errors}});
    }
    return $state->{tokens};
}

sub translate_html_tmpl {
    $_[0] =~ s!<(/?)tmpl_(if|loop|unless|else|var|include)\b!<$1mt:$2!ig;
    $_[0] =~ s!<MT_TRANS\b!<__trans!ig;
    $_[0] =~ s!<MT_ACTION\b!<__action!ig;
}

sub _consume_up_to {
    my($text, $start, $stoptag) = @_;
    my $pos;
    (pos $$text) = $start;
    while ($$text =~ m!(<([\$/]?)MT:?($stoptag)\b(?:[^>]*?)[\$/]?>)!gi) {
        my($whole_tag, $prefix, $tag) = ($1, $2, $3);
        my $end = pos $$text;
        if ($prefix && ($prefix eq '/')) {
            return ($end - length($whole_tag), $end);
        } elsif ($whole_tag !~ m|/>|) {
            my ($sec_end, $end_tag) = _consume_up_to($text, $end, $tag);
            last if !$sec_end;
            (pos $$text) = $end_tag;
        }
    }
    # special case for unclosed 'else' tag:
    if (lc($stoptag) eq 'else' || lc($stoptag) eq 'elseif') {
        return ($start + length($$text), $start + length($$text));
    }
    return (0, 0);
}

sub _text_block {
    my $text = substr ${ $_[0]->{text} }, $_[1], $_[2] - $_[1];
    push @{ $_[0]->{tokens} }, bless [ 'TEXT', $text, undef, undef, undef, $_[0]->{tokens}, $_[0]->{tmpl} ], NODE
        if (defined $text) && ($text ne '');
}

sub syntree2str {
    my ($tokens, $depth) = @_;
    my $string = '';
    foreach my $t (@$tokens) {
        my ($name, $args, $tokens, $uncompiled) = @$t;
        $string .= (" " x $depth) .  $name;
        if (ref $args eq 'HASH') {
            $string .= join(", ", (map { " $_ => " . $args->{$_} }
                                   (keys %$args)));
        }

        $string.= "\n";
        $string .= syntree2str($tokens, $depth + 2);
    }
    return $string;
}

my $count=0;
sub build {
    my $build = shift;
    my($ctx, $tokens, $cond) = @_;

    #print STDERR syntree2str($tokens,0) unless $count++ == 1;

    if ($cond) {
        my %lcond;
        # lowercase condtional keys since we're storing tags in lowercase now
        %lcond = map { lc $_ => $cond->{$_} } keys %$cond;
        $cond = \%lcond;
    } else {
        $cond = {};
    }
    $ctx->stash('builder', $build);
    my $res = '';
    my $ph = $ctx->post_process_handler;

    for my $t (@$tokens) {
        if ($t->[0] eq 'TEXT') {
            $res .= $t->[1];
        } else {
            my($tokens, $tokens_else, $uncompiled);
            my $tag = lc $t->[0];
            if ($cond && (exists $cond->{ $tag } && !$cond->{ $tag })) {
                # if there's a cond for this tag and it's false,
                # walk the children and look for an MTElse.
                # the children of the MTElse will become $tokens
                for my $tok (@{ $t->[2] }) {
                    if (lc $tok->[0] eq 'else' || lc $tok->[0] eq 'elseif') {
                        $tokens = $tok->[2];
                        $uncompiled = $tok->[3];
                        last;
                    }
                }
                next unless $tokens;
            } else {
                if ($t->[2] && ref($t->[2])) {
                    # either there is no cond for this tag, or it's true,
                    # so we want to partition the children into
                    # those which are inside an else and those which are not.
                    ($tokens, $tokens_else) = ([], []);
                    for my $sub (@{ $t->[2] }) {
                        if (lc $sub->[0] eq 'else' || lc $sub->[0] eq 'elseif') {
                            push @$tokens_else, $sub;
                        } else {
                            push @$tokens, $sub;
                        }
                    }
                }
                $uncompiled = $t->[3];
            }
            my($h, $type) = $ctx->handler_for($t->[0]);
            if ($h) {
                my $start;
                if ($MT::DebugMode & 8) {
                    require Time::HiRes;
                    $start = [ Time::HiRes::gettimeofday() ];
                }
                local($ctx->{__stash}{tag}) = $t->[0];
                local($ctx->{__stash}{tokens}) = ref($tokens) ? bless $tokens, 'MT::Template::Tokens' : undef;
                local($ctx->{__stash}{tokens_else}) = ref($tokens_else) ? bless $tokens_else, 'MT::Template::Tokens' : undef;
                local($ctx->{__stash}{uncompiled}) = $uncompiled;
                my %args = %{$t->[1]} if defined $t->[1];
                my @args = @{$t->[4]} if defined $t->[4];

                # process variables
                foreach my $v (keys %args) {
                    if (ref $args{$v} eq 'ARRAY') {
                        foreach (@{$args{$v}}) {
                            if (m/^\$([A-Za-z_](\w|\.)*)$/) {
                                $_ = $ctx->var($1);
                            }
                        }
                    } else {
                        if ($args{$v} =~ m/^\$([A-Za-z_](\w|\.)*)$/) {
                            $args{$v} = $ctx->var($1);
                        }
                    }
                }
                foreach (@args) {
                    $_ = [ $_->[0], $_->[1] ];
                    my $arg = $_;
                    if (ref $arg->[1] eq 'ARRAY') {
                        $arg->[1] = [ @{$arg->[1]} ];
                        foreach (@{$arg->[1]}) {
                            if (m/^\$([A-Za-z_](\w|\.)*)$/) {
                                $_ = $ctx->var($1);
                            }
                        }
                    } else {
                        if ($arg->[1] =~ m/^\$([A-Za-z_](\w|\.)*)$/) {
                            $arg->[1] = $ctx->var($1);
                        }
                    }
                }

                # Stores a reference to the ordered list of arguments,
                # just in case the handler wants them
                local $args{'@'} = \@args;
                my $out = $h->($ctx, \%args, $cond);

                unless (defined $out) {
                    my $err = $ctx->errstr;
                    if (defined $err) {
                        return $build->error(MT->translate("Error in <mt:[_1]> tag: [_2]", $t->[0], $ctx->errstr));
                    }
                    else {
                        # no error was given, so undef will mean '' in
                        # such a scenario
                        $out = '';
                    }
                }

                if ((defined $type) && ($type == 2)) {
                    # conditional; process result
                    $out = $out ? $ctx->slurp(\%args, $cond) : $ctx->else(\%args, $cond);
                    delete $ctx->{__stash}{vars}->{__value__};
                    delete $ctx->{__stash}{vars}->{__name__};
                }

                $out = $ph->($ctx, \%args, $out, \@args)
                    if %args && $ph;
                $res .= $out
                    if defined $out;
                if ($MT::DebugMode & 8) {
                    my $elapsed = Time::HiRes::tv_interval($start);
                    print STDERR "Builder: Tag [" . $t->[0] . "] - $elapsed seconds\n" if $elapsed > 0.25;
                }
            } else {
                if ($t->[0] !~ m/^_/) { # placeholder tag. just ignore
                    return $build->error(MT->translate("Unknown tag found: [_1]", $t->[0]));
                }
            }
        }
    }

    return $res;
}

1;
__END__

=head1 NAME

MT::Builder - Parser and interpreter for MT templates

=head1 SYNOPSIS

    use MT::Builder;
    use MT::Template::Context;

    my $build = MT::Builder->new;
    my $ctx = MT::Template::Context->new;

    my $tokens = $build->compile($ctx, '<$MTVersion$>')
        or die $build->errstr;
    defined(my $out = $build->build($ctx, $tokens))
        or die $build->errstr;

=head1 DESCRIPTION

I<MT::Builder> provides the parser and interpreter for taking a template
body and turning it into a generated output page. An I<MT::Builder> object
knows how to parse a string of text into tokens, then take those tokens and
build a scalar string representing the output of the page. It does not,
however, know anything about the types of tags that it encounters; it hands
off this work to the I<MT::Template::Context> object, which can look up a
tag and determine whether it's valid, whether it's a container or substitution
tag, etc.

All I<MT::Builder> knows is the basic structure of a Movable Type tag, and
how to break up a string into pieces: plain text pieces interspersed with
tag callouts. It then knows how to take a list of these tokens/pieces and
build a completed page, using the same I<MT::Template::Context> object to
actually fill in the values for the Movable Type tags.

=head1 USAGE

=head2 MT::Builder->new

Constructs and returns a new parser/interpreter object.

=head2 $build->compile($ctx, $string)

Given an I<MT::Template::Context> object I<$ctx>, breaks up the scalar string
I<$string> into tokens and returns the list of tokens as a reference to an
array. Returns C<undef> on compilation failure.

=head2 $build->build($ctx, \@tokens [, \%cond ])

Given an I<MT::Template::Context> object I<$ctx>, turns a list of tokens
I<\@tokens> and generates an output page. Returns the output page on success,
C<undef> on failure. Note that the empty string (C<''>) and the number zero
(C<0>) are both valid return values for this method, so you should check
specifically for an undefined value when checking for errors.

The optional argument I<\%cond> specifies a list of conditions under which
the tokens will be interpreted. If provided, I<\%cond> should be a reference
to a hash, where the keys are MT tag names (without the leading C<MT>), and
the values are boolean flags specifying whether to include the tag; a true
value means that the tag should be included in the final output, a false value
that it should not. This is useful when a template includes conditional
container tags (eg C<E<lt>MTEntryIfExtendedE<gt>>), and you wish to influence
the inclusion of these container tags. For example, if a template contains
the container

    <MTEntryIfExtended>
    <$MTEntryMore$>
    </MTEntryIfExtended>

and you wish to exclude this conditional, you could call I<build> like this:

    my $out = $build->build($ctx, $tokens, { EntryIfExtended => 0 });

=head2 $build->syntree2str(\@tokens)

Internal debugging routine to dump a set of template tokens. Returns a
readable string of contents of the C<$tokens> parameter.

=head1 ERROR HANDLING

On an error, the above methods return C<undef>, and the error message can
be obtained by calling the method I<errstr> on the object. For example:

    defined(my $out = $build->build($ctx, $tokens))
        or die $build->errstr;

=head1 AUTHOR & COPYRIGHTS

Please see the I<MT> manpage for author, copyright, and license information.

=cut
