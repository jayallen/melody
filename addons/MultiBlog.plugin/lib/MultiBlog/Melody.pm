package MultiBlog::Melody;

use strict;

sub search_blog_filter {
    my ( $cb, $app, $list, $processed ) = @_;
    my $plugin = MT->component('MultiBlog');

    require MT::Template::Context;
    my $ctx = MT::Template::Context->new;
    $ctx->stash('blog_id',$app->param('blog_id'));

    my $args;
    $args->{'include_blogs'} = $app->param('IncludeBlogs')
        if $app->param('IncludeBlogs');
    $args->{'exclude_blogs'} = $app->param('ExcludeBlogs')
        if $app->param('ExcludeBlogs');

    require MultiBlog;
    MultiBlog::filter_blogs_from_args($plugin,$ctx,$args);
    my $key;
    my @blogs;
    if ($args->{'exclude_blogs'}) {
        $key = 'ExcludeBlogs';
        @blogs = split(',',$args->{'exclude_blogs'});
        $app->param('ExcludeBlogs',$args->{'exclude_blogs'});
    } elsif ($args->{'include_blogs'}) {
        $key = 'IncludeBlogs';
        @blogs = split(',',$args->{'include_blogs'});
    }
    my $list;
    foreach (@blogs) { $list->{$_} = 1; }
    $app->{searchparam}{$key} = $list;
    return 1;
}

1;
__END__
