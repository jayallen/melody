package Melody::Feedback;

use strict;
use warnings;

# See this post about all the reverse "craziness" you see here:
# http://www.advogato.org/article/195.html

# Caching for persistent environments
our $TAB_MARKUP;
our $HOOK;
our $HOOK_REGEX;
our $EXCLUDE_REGEX;
our $FILTER_REGEX;
our $INCLUDE_REGEX;

sub cb_insert_tab {
    my ( $cb, $app, $out, $param, $tmpl ) = @_;
    unless ($EXCLUDE_REGEX) {    # initialize filter
        my $exclude = join '|', qw(
          upgrade.tmpl
          upgrade_runner.tmpl
          rebuilding.tmpl
          setup_initial_blog.tmpl
          \bpopup\b
          \bdialog\b
          \binclude\b
        );
        $EXCLUDE_REGEX = qr/$exclude/;
    }
    my $file = $tmpl->{__file} or return;
    return unless $app->id eq 'cms';    # Precautionary. CMS app only.
    return if $file =~ m{$EXCLUDE_REGEX};
    unless ($FILTER_REGEX) {    # last ditch attempt to filter out any dialogs
        my $filter = reverse('<div id="bootstrapper" class="hidden"></div>')
          ;                     # not in footer_popup.tmpl
        $FILTER_REGEX = qr/$filter/i;
    }
    my $rout = reverse($$out);
    return unless $rout =~ m{$FILTER_REGEX};
    unless ($HOOK) {            # initialize script injection
        $TAB_MARKUP = reverse(
            qq{
<script type="text/javascript" charset="utf-8">
  var is_ssl = ("https:" == document.location.protocol);
  var asset_host = is_ssl ? "https://s3.amazonaws.com/getsatisfaction.com/" : "http://s3.amazonaws.com/getsatisfaction.com/";
  document.write(unescape("%3Cscript src='" + asset_host + "javascripts/feedback-v2.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript" charset="utf-8">
  var feedback_widget_options = {};
  feedback_widget_options.display = "overlay";  
  feedback_widget_options.company = "openmelody";
  feedback_widget_options.placement = "right";
  feedback_widget_options.color = "#222";
  feedback_widget_options.style = "question";
  var feedback_widget = new GSFN.feedback_widget(feedback_widget_options);
  // Added the following to fix Melody stylesheet clash
  document.getElementById("fdbk_iframe").style.borderWidth = 0; 
</script>
}
        );
        $HOOK       = reverse('</body>');
        $HOOK_REGEX = qr/$HOOK/i;
    } ## end unless ($HOOK)
    my ($flag) = $rout =~ s{$HOOK_REGEX}{$HOOK$TAB_MARKUP};
    $$out = reverse($rout);
} ## end sub cb_insert_tab

1;

__END__

=head1 NAME

Melody::Feedback - Class container for adding community
feedback features to the Melody UI

=head1 VERSION

0.1

=head1 DESCRIPTION

Melody::Feedback is a class container for adding community
feedback features to the Melody UI. The single method
contained herein is a transformer callback that injects the
Get Satisfaction JavaScript widget into the output of most
CMS application pages.

=head1 METHODS

=head2 cb_insert_tab

A template output transformer callback routine that injects
the script block for a Get Satisfaction feedback tab widget
right before the closing HTML body tag.

This method filters out popups, dialogs, includes and status
screens where the tab would be useless or an annoyance.

=head1 AUTHOR & COPYRIGHT

=cut
