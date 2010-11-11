package TypePadAntiSpam::Tags;
use strict;

sub _hdlr_tpas_counter {
    my ($ctx, $args, $cond) = @_;
    my $blog = $ctx->stash('blog');
    if ($ctx->can('count_format')) {
        return $ctx->count_format($plugin->blocked($blog), $args);
    } else {
        return $plugin->blocked($blog) || 0;
    }
}

1;

