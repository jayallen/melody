# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::DefaultTemplates;

use strict;

=pod

Registry storage format for default templates:

default_templates:
    index:
        # The identifier used here never changes for this
        # template. It is also unique.
        main_index:
            filename: (optional; defaults to <identifier>.mtml)
            label: Main Index (auto-translated)
            outfile: (applicable for index templates only)
            rebuild_me: (applicable for index templates only)

=cut

my $loaded = 0;
my $templates;

BEGIN {

    # These global templates are used by the system for email notifications
    # and other updates. They are automatically installed when when Melody
    # is first installed.
    $templates = {
        'global:module' => { 'footer-email' => { label => 'Mail Footer', }, },
        'global:email'  => {
                     'comment_throttle'  => { label => 'Comment Throttle', },
                     'commenter_confirm' => { label => 'Commenter Confirm', },
                     'commenter_notify'  => { label => 'Commenter Notify', },
                     'new-comment'       => { label => 'New Comment', },
                     'new-ping'          => { label => 'New Ping', },
                     'notify-entry'      => { label => 'Entry Notify', },
                     'recover-password'  => { label => 'Password Recovery', },
                     'verify-subscribe'  => { label => 'Subscribe Verify', },
        },
    };
}

sub core_default_templates {
    return $templates;
}

sub load {
    my $class   = shift;
    my ($terms) = @_;
    my $tmpls   = $class->templates || [];
    if ($terms) {
        foreach my $key ( keys %$terms ) {
            @$tmpls = grep { $_->{$key} eq $terms->{$key} } @$tmpls;
        }
    }
    return wantarray ? @$tmpls : ( @$tmpls ? $tmpls->[0] : undef );
}

sub templates {
    my $pkg = shift;
    my ($set) = @_;
    require File::Spec;

    # A set of default templates as returned by MT::Component->registry
    # yields an array of hashes.

    my @tmpl_path = $set ? ( "template_sets", $set ) : ("default_templates");
    my $all_tmpls = MT::Component->registry(@tmpl_path) || [];
    my $weblog_templates_path = MT->config('WeblogTemplatesPath');

    my ( %tmpls, %global_tmpls );
    foreach my $def_tmpl (@$all_tmpls) {

        # copy structure, then run filter

        my $tmpl_hash;
        if ( $def_tmpl->{templates} && ( $def_tmpl->{templates} eq '*' ) ) {
            $tmpl_hash = MT->registry("default_templates");
        }
        elsif ( $def_tmpl->{templates}
                && ( $def_tmpl->{templates} =~ m/^[-\w]+\.yaml$/ ) )
        {
            $tmpl_hash = MT->registry( 'template_sets', $set, 'templates' );
        }
        else {
            $tmpl_hash = $set ? $def_tmpl->{templates} : $def_tmpl;
        }
        my $plugin = $tmpl_hash->{plugin};

        foreach my $tmpl_set ( keys %$tmpl_hash ) {
            next unless ref( $tmpl_hash->{$tmpl_set} ) eq 'HASH';
            foreach my $tmpl_id ( keys %{ $tmpl_hash->{$tmpl_set} } ) {
                next if $tmpl_id eq 'plugin';
                my $p = $tmpl_hash->{plugin}
                  || $tmpl_hash->{$tmpl_set}{plugin};
                my $base_path = $def_tmpl->{base_path}
                  || $tmpl_hash->{base_path};
                if ( $p && $base_path ) {
                    $base_path = File::Spec->catdir( $p->path, $base_path );
                }
                else {
                    $base_path = $weblog_templates_path;
                }

                my $tmpl = { %{ $tmpl_hash->{$tmpl_set}{$tmpl_id} } };
                my $type = $tmpl_set;
                if ( $tmpl_set =~ m/^global:/ ) {
                    $type =~ s/^global://;
                    $tmpl->{global} = 1;
                }
                $tmpl->{set} = $type;    # system, index, archive, etc.
                $tmpl->{order} = 0 unless exists $tmpl->{order};

                $type = 'custom' if $type eq 'module';
                $type = $tmpl_id if $type eq 'system';
                my $name = $tmpl->{label};
                $name = $name->() if ref($name) eq 'CODE';
                $tmpl->{name}       = $name;
                $tmpl->{type}       = $type;
                $tmpl->{key}        = $tmpl_id;
                $tmpl->{identifier} = $tmpl_id;

                # Even though they are stored as templates, widgetsets
                # are special.  They don't have a "text" attribute value
                # but instead an array of associated widgets which are
                # later translated into template includes and stored
                # in the "text" attribute.
                if ( exists $tmpl->{widgets} ) {
                    my $widgets = $tmpl->{widgets};
                    my @widgets;
                    foreach my $widget (@$widgets) {
                        if ($plugin) {
                            push @widgets, $plugin->translate($widget);
                        }
                        else {
                            push @widgets, MT->translate($widget);
                        }
                    }
                    $tmpl->{widgets} = \@widgets if @widgets;

                    # All NON-widgetsets are processed by the block below
                    # and are defined with the common "text" attribute.
                }
                else {

                    # load template if it hasn't been loaded already
                    if ( !exists $tmpl->{text} ) {
                        local ( *FIN, $/ );
                        my $filename = $tmpl->{filename}
                          || ( $tmpl_id . '.mtml' );
                        my $file
                          = File::Spec->catfile( $base_path, $filename );
                        if ( ( -e $file ) && ( -r $file ) ) {
                            open FIN, "<$file";
                            my $data = <FIN>;
                            close FIN;
                            $tmpl->{text} = $data;
                        }
                        else {
                            $tmpl->{text} = '';
                        }
                    }
                } ## end else [ if ( exists $tmpl->{widgets...})]

                my $local_global_tmpls
                  = $tmpl->{global} ? \%global_tmpls : \%tmpls;
                my $tmpl_key = $type . ":" . $tmpl_id;
                if ( exists $local_global_tmpls->{$tmpl_key} ) {

                    # allow components/plugins to override core
                    # templates
                    $local_global_tmpls->{$tmpl_key} = $tmpl
                      if $p && ( $p->id ne 'core' );
                }
                else {
                    $local_global_tmpls->{$tmpl_key} = $tmpl;
                }
            } ## end foreach my $tmpl_id ( keys ...)
        } ## end foreach my $tmpl_set ( keys...)
    } ## end foreach my $def_tmpl (@$all_tmpls)
    my @tmpls = ( values(%tmpls), values(%global_tmpls) );

    # sort widgets to process last, since they rely on the widgets to exist first.
    @tmpls = sort _template_sort @tmpls;
    MT->run_callbacks( 'DefaultTemplateFilter' . ( $set ? '.' . $set : '' ),
                       \@tmpls );
    return \@tmpls;
} ## end sub templates

sub _template_sort {
    if ( $a->{type} eq 'widgetset' ) {
        return 1 unless $b->{type} eq 'widgetset';
    }
    elsif ( $b->{type} eq 'widgetset' ) {

        # a is not a widgetset
        return -1;
    }

    # both a, b == widgetset or both a, b != widgetset
    return $a->{order} <=> $b->{order};
}

1;
__END__

=head1 NAME

MT::DefaultTemplates

=head1 METHODS

=head2 templates()

Return the list of the templates in the WeblogTemplatesPath.

=head2 core_default_templates

=head2 load

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
