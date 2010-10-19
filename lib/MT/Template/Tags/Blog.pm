# Movable Type (r) Open Source (C) 2001-2010 Six Apart Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id: Blog.pm 5151 2010-01-06 07:51:27Z takayama $                                                                                                       
package MT::Template::Tags::Blog;

use strict;

use MT;
use MT::Util qw( encode_xml );

###########################################################################

=head2 Blogs

A container tag which iterates over a list of all of the blogs in the
system. You can use any of the blog tags (L<BlogName>, L<BlogURL>, etc -
anything starting with MTBlog) inside of this tag set.

B<Attributes:>

=over 4

=item * blog_ids

This attribute allows you to limit the set of blogs iterated over by
L<Blogs>. Multiple blogs are specified in a comma-delimited fashion.
For example:

    <mt:Blogs blog_ids="1,12,19,37,112">

would iterate over only the blogs with IDs 1, 12, 19, 37 and 112.

=item * glue (optional)

Specifies a string that is output in between output produce within the
L<Blogs> container tags. For example:

    <mt:Blogs glue=","><$mt:BlogID$></mt:Blogs>

might output something like this:

    1,2,5,10,28,32,33,34

=back

=for tags multiblog, loop, blogs

=cut

sub _hdlr_blogs {
    my($ctx, $args, $cond) = @_;
    my (%terms, %args);

    $ctx->set_blog_load_context($args, \%terms, \%args, 'id')
        or return $ctx->error($ctx->errstr);

    my $builder = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');

    local $ctx->{__stash}{entries} = undef
        if $args->{ignore_archive_context};
    local $ctx->{current_timestamp} = undef
        if $args->{ignore_archive_context};
    local $ctx->{current_timestamp_end} = undef
        if $args->{ignore_archive_context};
    local $ctx->{__stash}{category} = undef
        if $args->{ignore_archive_context};
    local $ctx->{__stash}{archive_category} = undef
        if $args->{ignore_archive_context};

    require MT::Blog;
    $args{'sort'} = 'name';
    $args{direction} = 'ascend';
    my $iter = MT::Blog->load_iter(\%terms, \%args);
    my $res = '';
    my $count = 0;
    my $next = $iter->();
    my $glue = $args->{glue};
    my $vars = $ctx->{__stash}{vars} ||= {};
    while ($next) {
        my $blog = $next;
        $next = $iter->();
        $count++;
        local $ctx->{__stash}{blog} = $blog;
        local $ctx->{__stash}{blog_id} = $blog->id;
        local $vars->{__first__} = $count == 1;
        local $vars->{__last__} = !$next;
        local $vars->{__odd__} = ($count % 2) == 1;
        local $vars->{__even__} = ($count % 2) == 0;
        local $vars->{__counter__} = $count;
        defined(my $out = $builder->build($ctx, $tokens, $cond))
            or return $ctx->error($builder->errstr);
        # See http://bugs.movabletype.org/?79873
        $res .= $glue
            if defined $glue && ($count > 1) && length($res) && length($out);
        $res .= $out;
    }
    $res;
}

###########################################################################

=head2 BlogIfCCLicense

A conditional tag that is true when the current blog in context has
been assigned a Creative Commons License.

=for tags blogs, creativecommons

=cut

sub _hdlr_blog_if_cc_license {
    my ($ctx) = @_;
    my $blog = $ctx->stash('blog');
    return 0 unless $blog;
    return $blog->cc_license ? 1 : 0;
}

###########################################################################

=head2 IfBlog

A conditional tag that produces its contents when there is a blog in
context. This tag is useful for situations where a blog may or may not
be in context, such as the search template, when a search is conducted
across all blogs.

B<Example:>

    <mt:IfBlog>
        <h1>Search results for <$mt:BlogName$>:</h1>
    <mt:Else>
        <h1>Search results from all blogs:</h1>
    </mt:IfBlog>

=for tags blogs

=cut

###########################################################################

=head2 BlogID

Outputs the numeric ID of the blog currently in context.

=for tags blogs

=cut

sub _hdlr_blog_id {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    $blog ? $blog->id : 0;
}

###########################################################################

=head2 BlogName

Outputs the name of the blog currently in context.

=for tags blogs

=cut

sub _hdlr_blog_name {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $name = $blog->name;
    defined $name ? $name : '';
}

###########################################################################

=head2 BlogDescription

Outputs the description field of the blog currently in context.

=for tags blogs

=cut

sub _hdlr_blog_description {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $d = $blog->description;
    defined $d ? $d : '';
}

{
    my %real_lang = (cz => 'cs', dk => 'da', jp => 'ja', si => 'sl');
    ###########################################################################

=head2 BlogLanguage

The blog's specified language for date display. This setting can be changed
on the blog's Entry settings screen.

B<Attributes:>

=over 4

=item * locale (optional; default "0")

If assigned, will format the language in the style "language_LOCALE" (ie: "en_US", "de_DE", etc).

=item * ietf (optional; default "0")

If assigned, will change any '_' in the language code to a '-', conforming
it to the IETF RFC # 3066.

=back

=for tags blogs

=cut

sub _hdlr_blog_language {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    my $lang_tag = ($blog ? $blog->language : $ctx->{config}->DefaultLanguage) || '';
    $lang_tag = ($real_lang{$lang_tag} || $lang_tag);
    if ($args->{'locale'}) {
        $lang_tag =~ s/^(..)([-_](..))?$/$1 . '_' . uc($3||$1)/e;
    } elsif ($args->{"ietf"}) {
        # http://www.ietf.org/rfc/rfc3066.txt
        $lang_tag =~ s/_/-/;
    }
    $lang_tag;
}
}

###########################################################################

=head2 BlogURL

Outputs the Site URL field of the blog currently in context. An ending
'/' character is guaranteed.

=for tags blogs

=cut

sub _hdlr_blog_url {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $url = $blog->site_url;
    return '' unless defined $url;
    $url .= '/' unless $url =~ m!/$!;
    $url;
}

###########################################################################

=head2 BlogArchiveURL

Outputs the Archive URL of the blog currently in context. An ending
'/' character is guaranteed.

=for tags blogs

=cut

sub _hdlr_blog_archive_url {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $url = $blog->archive_url;
    return '' unless defined $url;
    $url .= '/' unless $url =~ m!/$!;
    $url;
}

###########################################################################

=head2 BlogRelativeURL

Similar to the L<BlogURL> tag, but removes any domain name from the URL.

=for tags blogs

=cut

sub _hdlr_blog_relative_url {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $host = $blog->site_url;
    return '' unless defined $host;
    if ($host =~ m!^https?://[^/]+(/.*)$!) {
        return $1;
    } else {
        return '';
    }
}

###########################################################################

=head2 BlogSitePath

Outputs the Site Root field of the blog currently in context. An ending
'/' character is guaranteed.

=for tags blogs

=cut

sub _hdlr_blog_site_path {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $path = $blog->site_path;
    return '' unless defined $path;
    $path .= '/' unless $path =~ m!/$!;
    $path;
}

###########################################################################

=head2 BlogHost

The host name part of the absolute URL of your blog.

B<Attributes:>

=over 4

=item * exclude_port (optional; default "0")

Removes any specified port number if this attribute is set to true (1),
otherwise it will return the hostname and port number (e.g.
www.somedomain.com:8080).

=item * signature (optional; default "0")

If set to 1, then this template tag will instead return a unique signature
for the hostname, by replacing all occurrences of decimals (".") with
underscores ("_").

=back

=for tags blogs

=cut

sub _hdlr_blog_host {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $host = $blog->site_url;
    if ($host =~ m!^https?://([^/:]+)(:\d+)?/?!) {
        if ($args->{signature}) {
            # using '_' to replace '.' since '-' is a valid
            # letter for domains
            my $sig = $1;
            $sig =~ s/\./_/g;
            return $sig;
        }
        return $args->{exclude_port} ? $1 : $1 . ($2 || '');
    } else {
        return '';
    }
}

###########################################################################

=head2 BlogTimezone

The timezone that has been specified for the blog displayed as an offset
from UTC in +|-hh:mm format. This setting can be changed on the blog's
General settings screen.

B<Attributes:>

=over 4

=item * no_colon (optional; default "0")

If specified, will produce the timezone without the ":" character
("+|-hhmm" only).

=back

=for tags blogs

=cut

sub _hdlr_blog_timezone {
    my ($ctx, $args) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $so = $blog->server_offset;
    my $no_colon = $args->{no_colon};
    my $partial_hour_offset = 60 * abs($so - int($so));
    sprintf("%s%02d%s%02d", $so < 0 ? '-' : '+',
            abs($so), $no_colon ? '' : ':',
            $partial_hour_offset);
}

###########################################################################

=head2 BlogCCLicenseURL

Publishes the license URL of the Creative Commons logo appropriate
to the license assigned to the blog inc ontex.t If the blog doesn't
have a Creative Commons license, this tag returns an empty string.

=for tags blogs, creativecommons

=cut

sub _hdlr_blog_cc_license_url {
    my ($ctx) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    return $blog->cc_license_url;
}

###########################################################################

=head2 BlogCCLicenseImage

Publishes the URL of the Creative Commons logo appropriate to the
license assigned to the blog in context. If the blog doesn't have
a Creative Commons license, this tag returns an empty string.

B<Example:>

    <MTIf tag="BlogCCLicenseImage">
    <img src="<$MTBlogCCLicenseImage$>" alt="Creative Commons" />
    </MTIf>

=for tags blogs, creativecommons

=cut

sub _hdlr_blog_cc_license_image {
    my ($ctx) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $cc = $blog->cc_license or return '';
    my ($code, $license, $image_url) = $cc =~ /(\S+) (\S+) (\S+)/;
    return $image_url if $image_url;
    "http://creativecommons.org/images/public/" .
        ($cc eq 'pd' ? 'norights' : 'somerights');
}

###########################################################################

=head2 CCLicenseRDF

Returns the RDF markup for a Creative Commons License. If the blog
has not been assigned a license, this returns an empty string.

B<Attributes:>

=over 4

=item * with_index (optional; default "0")

If specified, forces the trailing "index" filename to be left on any
entry permalink published in the RDF block.

=back

=for tags blogs, creativecommons

=cut

sub _hdlr_cc_license_rdf {
    my ($ctx, $arg) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $cc = $blog->cc_license or return '';
    my $cc_url = $blog->cc_license_url;
    my $rdf = <<RDF;
<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
         xmlns:dc="http://purl.org/dc/elements/1.1/"
         xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
RDF
    ## SGML comments cannot contain double hyphens, so we convert
    ## any double hyphens to single hyphens.
    my $strip_hyphen = sub {
        (my $s = $_[0]) =~ tr/\-//s;
        $s;
    };
    if (my $entry = $ctx->stash('entry')) {
        my $link = $entry->permalink;
        my $author_name = $entry->author ? $entry->author->nickname || '' : '';
        $link = MT::Util::strip_index($entry->permalink, $blog) unless $arg->{with_index};
        $rdf .= <<RDF;
<Work rdf:about="$link">
<dc:title>@{[ encode_xml($strip_hyphen->($entry->title)) ]}</dc:title>
<dc:description>@{[ encode_xml($strip_hyphen->(_hdlr_entry_excerpt(@_))) ]}</dc:description>
<dc:creator>@{[ encode_xml($strip_hyphen->($author_name)) ]}</dc:creator>
<dc:date>@{[ _hdlr_entry_date($ctx, { 'format' => "%Y-%m-%dT%H:%M:%S" }) .
             _hdlr_blog_timezone($ctx) ]}</dc:date>
<license rdf:resource="$cc_url" />
</Work>
RDF
    } else {
        $rdf .= <<RDF;
<Work rdf:about="@{[ $blog->site_url ]}">
<dc:title>@{[ encode_xml($strip_hyphen->($blog->name)) ]}</dc:title>
<dc:description>@{[ encode_xml($strip_hyphen->($blog->description)) ]}</dc:description>
<license rdf:resource="$cc_url" />
</Work>
RDF
    }
    $rdf .= MT::Util::cc_rdf($cc) . "</rdf:RDF>\n-->\n";
    $rdf;
}

###########################################################################

=head2 BlogFileExtension

Returns the configured blog filename extension, including a leading
'.' character. If no extension is assigned, this returns an empty
string.

=for tags blogs

=cut

sub _hdlr_blog_file_extension {
    my($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $ext = $blog->file_extension || '';
    $ext = '.' . $ext if $ext ne '';
    $ext;
}

###########################################################################

=head2 BlogTemplateSetID

Returns an identifier for the currently assigned template set for the
blog in context. The identifier is modified such that underscores are
changed to dashes. In the MT template sets, this identifier is assigned
to the "id" attribute of the C<body> HTML tag.

=for tags blogs

=cut

sub _hdlr_blog_template_set_id {
    my ($ctx) = @_;
    my $blog = $ctx->stash('blog');
    return '' unless $blog;
    my $set = $blog->template_set || 'classic_blog';
    $set =~ s/_/-/g;
    return $set;
}

1;
__END__
