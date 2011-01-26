package DePoCleanTheme::Callbacks;
use strict;

sub _ts_change {
    my ($cb, $param) = @_;
    my $blog = $param->{blog};
    my $blog_template_set = $blog->template_set || '';
    return 1
        if 'DePoClean_theme' ne $blog_template_set;
    return 1
        if MT->component('ActionStreams');
    my $template = MT->model('template')->load({
            blog_id => $blog->id,
            identifier => 'action_streams'
    });

    $template->remove if $template;
}

1;
