# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::Template::Context::Search;

use strict;
use base qw( MT::Template::Context );
use MT::Util qw( encode_url decode_html );

sub load_core_tags {
    require MT::Template::Context;
    return {
        function => {
            SearchString => \&_hdlr_search_string,
            SearchResultCount => \&_hdlr_result_count,
            MaxResults => \&_hdlr_max_results,
            SearchIncludeBlogs => \&_hdlr_include_blogs,
            SearchTemplateID => \&_hdlr_template_id,
        },
        block => {
            SearchResults => \&_hdlr_results,
            'IfTagSearch?' => sub { MT->instance->mode eq 'tag' },
            'IfStraightSearch?' => sub { MT->instance->mode eq 'default' },
            'NoSearchResults?' => sub { $_[0]->stash('count') ? 0 : 1; },
            'NoSearch?' => sub { ( $_[0]->stash('search_string') &&
                                   $_[0]->stash('search_string') =~ /\S/ ) ? 0 : 1 },
            SearchResultsHeader => \&MT::Template::Context::_hdlr_pass_tokens,
            SearchResultsFooter => \&MT::Template::Context::_hdlr_pass_tokens,
            BlogResultHeader => \&MT::Template::Context::_hdlr_pass_tokens,
            BlogResultFooter => \&MT::Template::Context::_hdlr_pass_tokens,
            'IfMaxResultsCutoff?' => \&MT::Template::Context::_hdlr_pass_tokens,
        },
    };
}

###########################################################################

=head2 SearchResultsHeader

The content of this block tag is rendered when the item in context
from search results are the first item of the result set.  You can
use the block to render headings and titles of the result table,
for example.

This tag is only recognized in SearchResults block.

=for tags search

=cut

###########################################################################

=head2 SearchResultsFooter

The content of this block tag is rendered when the item in context
from search results are the last item of the result set.  You can
use the block to render closeing tags of a HTML element, for example.

This tag is only recognized in SearchResults block.

=for tags search

=cut

###########################################################################

=head2 BlogResultHeader

The contents of this container tag will be displayed when the blog id of
the entry in context from search results differs from the previous entry's
blog id.

This tag is only recognized in search templates.

=for tags search

=cut

###########################################################################

=head2 BlogResultFooter

The contents of this container tag will be displayed when the blog id of
the entry in context from search results differs from the next entry's
blog id.

This tag is only recognized in search templates.

=for tags search

=cut

###########################################################################

=head2 IfMaxResultsCutOff

NOTE: this tag only applies if you are using older Movable Type than
version 4.15, or you set up your search script so it instantiates
MT::App::Search::Legacy, the older search script.  Under the default
search script in Movable Type, this tag will never be evaluated as true and
therefore the contents will never be rendered.

A conditional tag that returns true when the number of search results
per blog exceeds the maximium limit specified in MaxResults configuration
directive.

This tag is only recognized in search templates.

=cut

###########################################################################

=head2 MaxResults

Returns the value of SearchMaxResults, specified either in configuration
(via C<SearchMaxResults> configuration directive) or in the search query
parameter in the URL.

This tag is only recognized in search templates.

=cut

sub _hdlr_include_blogs { $_[0]->stash('include_blogs') || '' }
sub _hdlr_search_string { $_[0]->stash('search_string') || '' }
sub _hdlr_template_id { $_[0]->stash('template_id') || '' }
sub _hdlr_max_results { $_[0]->stash('maxresults') || '' }

sub _hdlr_result_count {
    my $results = $_[0]->stash('count');
    $results ? $results : 0;
}

sub _hdlr_results {
    my($ctx, $args, $cond) = @_;

    ## If there are no results, return the empty string, knowing
    ## that the handler for <MTNoSearchResults> will fill in the
    ## no results message.
    my $iter = $ctx->stash('results') or return '';
    my $count = $ctx->stash('count') or return '';
    my $max = $ctx->stash('maxresults');
    my $stash_key = $ctx->stash('stash_key') || 'entry';

    my $output = '';
    my $build = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');
    my $blog_header = 1;
    my $blog_footer = 0;
    my $footer = 0;
    my $count_per_blog = 0;
    my $max_reached = 0;
    my ( $this_object, $next_object );
    $this_object = $iter->();
    return '' unless $this_object;
    for ( my $i = 0; $i < $count; $i++) {
        $count_per_blog++;
        $ctx->stash($stash_key, $this_object);
        local $ctx->{__stash}{blog} = $this_object->blog
            if $this_object->can('blog');
        my $ts;
        if ( $this_object->isa('MT::Entry') ) {
            $ts = $this_object->authored_on;
        }
        elsif ( $this_object->properties->{audit} ) {
            $ts = $this_object->created_on;
        }
        local $ctx->{current_timestamp} = $ts;

        # TODO: per blog max objects?
        #if ( $count_per_blog >= $max ) {
        #    while (1) {
        #        if ( $count > $i + 1 ) {
        #            $next_object = $results->[$i + 1];
        #            if ( $next_object->blog_id ne $this_object->blog_id ) {
        #                $blog_footer = 1;
        #                last;
        #            }
        #            else {
        #                $max_reached = 1;
        #            }
        #        }
        #        else {
        #            $next_object = undef;
        #            $blog_footer = 1;
        #            last;
        #        }
        #        $i++;
        #    }
        #}
        #elsif ( $count > $i + 1 ) {
        #    $next_object = $results->[$i + 1];
        #    $blog_footer = $next_object->blog_id ne $this_object->blog_id ? 1 : 0;
        #}
        #else {
        #    $blog_footer = 1;
        #}
        if ( $next_object = $iter->() ) {
            $blog_footer = $next_object->blog_id ne $this_object->blog_id ? 1 : 0;
        }
        else {
            $blog_footer = 1;
            $footer      = 1;
        }

        defined(my $out = $build->build($ctx, $tokens,
            { %$cond, 
                SearchResultsHeader => $i == 0,
                SearchResultsFooter => $footer,
                BlogResultHeader => $blog_header,
                BlogResultFooter => $blog_footer,
                IfMaxResultsCutoff => $max_reached,
            }
            )) or return $ctx->error( $build->errstr );
        $output .= $out;

        $this_object = $next_object;
        last unless $this_object;
        $blog_header = $blog_footer ? 1 : 0;
    }
    $output;
}

sub context_script {
	my ( $ctx, $args, $cond ) = @_;

    my $search_string = decode_html( $ctx->stash('search_string') ) ;
    my $cgipath = $ctx->_hdlr_cgi_path($args);
    my $script = $ctx->{config}->SearchScript;
    my $link = $cgipath.$script . '?search=' . encode_url( $search_string );
    if ( my $mode = $ctx->stash('mode') ) {
        $mode = encode_url($mode);
        $link .= "&__mode=$mode";
    }
    if ( my $type = $ctx->stash('type') ) {
        $type = encode_url($type);
        $link .= "&type=$type";
    }
    if ( my $include_blogs = $ctx->stash('include_blogs') ) {
        $link .= "&IncludeBlogs=$include_blogs";
    }
    elsif ( my $blog_id = $ctx->stash('blog_id') ) {
        $link .= "&blog_id=$blog_id";
    }
    if ( my $format = $ctx->stash('format') ) {
        $link .= '&format=' . encode_url($format);
    }
	$link;
}

1;
__END__

