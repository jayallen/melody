package MultiBlog::Melody;

use strict;

sub search_blog_filter {
    my ( $cb, $app, $list, $processed ) = @_;
    my $plugin = MT->component('MultiBlog');
    my $q      = $app->query;

    require MT::Template::Context;
    my $ctx = MT::Template::Context->new;
    $ctx->stash( 'blog_id', $q->param('blog_id') );

    my $args;
    $args->{'include_blogs'} = $q->param('IncludeBlogs')
      if $q->param('IncludeBlogs');
    $args->{'exclude_blogs'} = $q->param('ExcludeBlogs')
      if $q->param('ExcludeBlogs');

    require MultiBlog;
    MultiBlog::filter_blogs_from_args( $plugin, $ctx, $args );
    my $key;
    my @blogs;
    if ( $args->{'exclude_blogs'} ) {
        $key = 'ExcludeBlogs';
        @blogs = split( ',', $args->{'exclude_blogs'} );
        $q->param( 'ExcludeBlogs', $args->{'exclude_blogs'} );
    }
    elsif ( $args->{'include_blogs'} ) {
        $key = 'IncludeBlogs';
        @blogs = split( ',', $args->{'include_blogs'} );
    }
    foreach (@blogs) { $list->{$_} = 1; }
    $app->{searchparam}{$key} = $list;
    return 1;
} ## end sub search_blog_filter

1;
__END__


=head1 NAME

MultiBlog::Melody - this package contains Melody-specific additions to the
MultiBlog plugin.

=head1 METHODS

=over 4 search_blog_filter

This method is invoked via the search_blog_list callback. It is responsible
for modifying the list of blogs to be included and excluded from a search. 
The callback was implemented by Melody to address the concern that the 
Context Privacy setting associated with a blog's MultiBlog configuration
was not being respected when executing a search.

Without this callback, one could configure a blog to be "private" but still
have that blog's content surface in search results - thus violating the 
intent of the setting. 

Users should be warned that Six Apart advises the following with regards to
this capability:

1) The prospective behavior (having search.cgi respect Multiblog privacy
settings) was never an intended function of the Multiblog plugin.

2) Movable Type already provides the IncludeBlogs and ExcludeBlogs
configuration directives to specify blogs to be included or excluded in a
search.

3) Multiblog plugin privacy settings shouldn't interact with or override the
IncludeBlogs / ExcludeBlogs configuration directives.  That could lead to 
unexpected results, particularly if the settings conflict with each other.

4) Altering the functionality as proposed would make troubleshooting issues 
with the inclusion / exclusion of blogs in searches much more difficult.  
There would be no clear way for Movable Type to show that Multiblog 
privacy settings influence the search results, or that Multiblog privacy 
settings may be overriding explicit IncludeBlogs / ExcludeBlogs settings 
in the config.cgi configuration file.

=item 

=back

=head1 AUTHOR & COPYRIGHTS

Author(s): Byrne Reese <byrne@endevver.com>

(C) 2010 Open Melody Software Group.

=cut
