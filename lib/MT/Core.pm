# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::Core;

use strict;
use MT;
use base 'MT::Component';

# This is just to make our localization scanner happy
sub trans {
    return shift;
}

sub name {
    return "Core";
}

my $core_registry;

BEGIN {
    $core_registry = {
        version        => MT->VERSION,
        schema_version => MT->schema_version,
        object_drivers => {
                            'mysql' => {
                                         label          => 'MySQL Database',
                                         dbd_package    => 'DBD::mysql',
                                         config_package => 'DBI::mysql',
                            },
                            'postgres' => {
                                            label => 'PostgreSQL Database',
                                            dbd_package    => 'DBD::Pg',
                                            dbd_version    => '1.32',
                                            config_package => 'DBI::postgres',
                            },
                            'sqlite' => {
                                          label          => 'SQLite Database',
                                          dbd_package    => 'DBD::SQLite',
                                          config_package => 'DBI::sqlite',
                            },
                            'sqlite2' => {
                                           label => 'SQLite Database (v2)',
                                           dbd_package    => 'DBD::SQLite2',
                                           config_package => 'DBI::sqlite',
                            },
        },
        object_types => {
            'entry'           => 'MT::Entry',
            'author'          => 'MT::Author',
            'asset'           => 'MT::Asset',
            'file'            => 'MT::Asset',
            'asset.file'      => 'MT::Asset',
            'asset.image'     => 'MT::Asset::Image',
            'image'           => 'MT::Asset::Image',
            'asset.audio'     => 'MT::Asset::Audio',
            'audio'           => 'MT::Asset::Audio',
            'asset.video'     => 'MT::Asset::Video',
            'video'           => 'MT::Asset::Video',
            'entry.page'      => 'MT::Page',
            'page'            => 'MT::Page',
            'category.folder' => 'MT::Folder',
            'folder'          => 'MT::Folder',
            'category'        => 'MT::Category',
            'user'            => 'MT::Author',
            'commenter'       => 'MT::Author',
            'blog'            => 'MT::Blog',
            'template'        => 'MT::Template',
            'comment'         => 'MT::Comment',
            'notification'    => 'MT::Notification',
            'templatemap'     => 'MT::TemplateMap',
            'tbping'          => 'MT::TBPing',
            'ping'            => 'MT::TBPing',
            'ping_cat'        => 'MT::TBPing',
            'log'             => 'MT::Log',
            'log.ping'        => 'MT::Log::TBPing',
            'log.entry'       => 'MT::Log::Entry',
            'log.comment'     => 'MT::Log::Comment',
            'log.system'      => 'MT::Log',
            'tag'             => 'MT::Tag',
            'role'            => 'MT::Role',
            'association'     => 'MT::Association',
            'permission'      => 'MT::Permission',
            'fileinfo'        => 'MT::FileInfo',
            'placement'       => 'MT::Placement',
            'plugindata'      => 'MT::PluginData',
            'session'         => 'MT::Session',
            'trackback'       => 'MT::Trackback',
            'config'          => 'MT::Config',
            'objecttag'       => 'MT::ObjectTag',
            'objectscore'     => 'MT::ObjectScore',
            'objectasset'     => 'MT::ObjectAsset',
            'filter'          => 'MT::Filter',
            'touch'           => 'MT::Touch',

            # TheSchwartz tables
            'ts_job'        => 'MT::TheSchwartz::Job',
            'ts_error'      => 'MT::TheSchwartz::Error',
            'ts_exitstatus' => 'MT::TheSchwartz::ExitStatus',
            'ts_funcmap'    => 'MT::TheSchwartz::FuncMap',
        },
        list_properties => {
            __virtual => {
                base => {
                    init => sub {
                        my $prop = shift;
                        if ( $prop->has('col') ) {
                            $prop->{raw} = sub {
                                my $prop  = shift;
                                my ($obj) = @_;
                                my $col   = $prop->col;
                                return $obj->$col;
                            }
                            unless $prop->has('raw');
                            $prop->{sort} = sub {
                                my $prop = shift;
                                my ( $terms, $args ) = @_;
                                $args->{sort} = $prop->col;
                                return;
                            }
                            unless $prop->has('sort')
                                || $prop->has('bulk_sort')
                                || $prop->has('sort_method');
                        }
                    },
                },
                hidden => {
                    base  => '__virtual.base',
                    terms => sub {
                        my $prop = shift;
                        my ( $args, $db_terms, $db_args ) = @_;
                        my $col    = $prop->col or die;
                        my $option = $args->{option};
                        my $value  = $args->{value};
                        if ( $prop->is_meta ) {
                            return $prop->join_meta( $db_args, $value );
                        }
                        else {
                            return { $col => $value };
                        }
                    },
                    filter_tmpl => '<mt:Var name="filter_form_hidden">',
                    base_type   => 'hidden',
                    priority    => 4,
                },
                string => {
                    base      => '__virtual.base',
                    col_class => 'string',
                    terms     => sub {
                        my $prop = shift;
                        my ( $args, $db_terms, $db_args ) = @_;
                        my $col    = $prop->col or die;
                        my $option = $args->{option};
                        my $query  = $args->{string};
                        if ( 'contains' eq $option ) {
                            $query = { like => "%$query%" };
                        }
                        elsif ( 'not_contains' eq $option ) {
                            $query = { not_like => "%$query%" };
                        }
                        elsif ( 'beginning' eq $option ) {
                            $query = { like => "$query%" };
                        }
                        elsif ( 'end' eq $option ) {
                            $query = { like => "%$query" };
                        }
                        if ( $prop->is_meta ) {
                            return $prop->join_meta( $db_args, $query );
                        }
                        else {
                            return { $col => $query };
                        }
                    },
                    filter_tmpl    => '<mt:var name="filter_form_string">',
                    base_type      => 'string',
                    args_via_param => sub {
                        my $prop = shift;
                        my ( $app, $val ) = @_;
                        return { option => 'equal', string => $val };
                    },
                    label_via_param => sub {
                        my $prop = shift;
                        my ( $app, $val ) = @_;
                        return MT->translate(
                            '[_1] in [_2]: [_3]',
                            $prop->datasource->class_label_plural,
                            $prop->label,
                            MT::Util::encode_html($val),
                        );
                    },
                    priority => 7,
                },
                integer => {
                    base      => '__virtual.base',
                    col_class => 'num',

                    #sort_method => sub {
                    #    my $prop = shift;
                    #    my ( $obj_a, $obj_b ) = @_;
                    #    my $col = $prop->{col};
                    #    return $obj_a->$col <=> $obj_b->$col;
                    #},
                    terms => sub {
                        my $prop = shift;
                        my ( $args, $db_terms, $db_args ) = @_;
                        my $col    = $prop->col or die;
                        my $option = $args->{option};
                        my $value  = $args->{value};
                        my $query;
                        if ( 'equal' eq $option ) {
                            $query = $value;
                        }
                        elsif ( 'not_equal' eq $option ) {
                            $query = { not => $value };
                        }
                        elsif ( 'greater_than' eq $option ) {
                            $query = { '>' => $value };
                        }
                        elsif ( 'greater_equal' eq $option ) {
                            $query = { '>=' => $value };
                        }
                        elsif ( 'less_than' eq $option ) {
                            $query = { '<' => $value };
                        }
                        elsif ( 'less_equal' eq $option ) {
                            $query = { '<=' => $value };
                        }
                        if ( $prop->is_meta ) {
                            return $prop->join_meta( $db_args, $query );
                        }
                        else {
                            return { $col => $query };
                        }
                    },
                    args_via_param => sub {
                        my $prop = shift;
                        my ( $app, $val ) = @_;
                        return { option => 'equal', value => $val };
                    },
                    filter_tmpl => '<mt:Var name="filter_form_integer">',
                    base_type   => 'integer',
                    priority    => 4,
                    default_sort_order => 'descend',
                },
                float => {
                    base      => '__virtual.integer',
                    condition => sub {0},
                    col_class => 'num',
                    html      => sub {
                        my ( $prop, $obj ) = @_;
                        my $col = $prop->col;
                        return sprintf "%0.1f", $obj->$col;
                    },
                    base_type => 'float',
                },
                date => {
                    base          => '__virtual.base',
                    col_class     => 'date',
                    use_future    => 0,
                    validate_item => sub {
                        my $prop   = shift;
                        my ($item) = @_;
                        my $args   = $item->{args};
                        my $option = $args->{option}
                            or return $prop->error(
                            MT->translate('option is required') );
                        my %params = (
                            range  => { from   => 1, to => 1 },
                            before => { origin => 1 },
                            after  => { origin => 1 },
                            days   => { days   => 1 },
                        );

                        my $using = $params{$option};
                        $using->{option} = 1;
                        for my $key ( keys %$args ) {
                            if ( $using->{$key} ) {
                                ## validate it
                                if ( $key eq 'days' ) {
                                    return $prop->error(
                                        MT->translate(
                                            q{Days can't include non numeriacal characters.}
                                        )
                                    ) if $args->{days} =~ /\D/;
                                }
                                elsif ( $key ne 'option' ) {
                                    my $date = $args->{$key};
                                    return $prop->error(
                                        MT->translate(q{Invalid date.}) )
                                        unless $date
                                            =~ m/^\d{4}\-\d{2}\-\d{2}$/;
                                }
                            }
                            else {
                                ## or remove from $args.
                                delete $args->{$key};
                            }
                        }
                        return 1;
                    },
                    terms => sub {
                        my $prop = shift;
                        my ( $args, $db_terms, $db_args ) = @_;
                        my $col    = $prop->col;
                        my $option = $args->{option};
                        my $query;
                        my $blog = MT->app ? MT->app->blog : undef;
                        require MT::Util;
                        my $now = MT::Util::epoch2ts( $blog, time() );
                        my $from   = $args->{from}   || undef;
                        my $to     = $args->{to}     || undef;
                        my $origin = $args->{origin} || undef;
                        $from   =~ s/\D//g;
                        $to     =~ s/\D//g;
                        $origin =~ s/\D//g;
                        $from .= '000000' if $from;
                        $to   .= '235959' if $to;

                        if ( 'range' eq $option ) {
                            $query = [
                                '-and',
                                { op => '>', value => $from },
                                { op => '<', value => $to },
                            ];
                        }
                        elsif ( 'days' eq $option ) {
                            my $days   = $args->{days};
                            my $origin = MT::Util::epoch2ts( $blog,
                                time - $days * 60 * 60 * 24 );
                            $query = [
                                '-and',
                                { op => '>', value => $origin },
                                { op => '<', value => $now },
                            ];
                        }
                        elsif ( 'before' eq $option ) {
                            $query = {
                                op    => '<',
                                value => $origin . '000000'
                            };
                        }
                        elsif ( 'after' eq $option ) {
                            $query = {
                                op    => '>',
                                value => $origin . '235959'
                            };
                        }
                        elsif ( 'future' eq $option ) {
                            $query = { op => '>', value => $now };
                        }
                        elsif ( 'past' eq $option ) {
                            $query = { op => '<', value => $now };
                        }

                        if ( $prop->is_meta ) {
                            $prop->join_meta( $db_args, $query );
                        }
                        else {
                            return { $col => $query };
                        }
                    },
                    args_via_param => sub {
                        my $prop = shift;
                        my ( $app, $val ) = @_;
                        my $param;
                        if ( $val =~ m/\-/ ) {
                            my ( $from, $to ) = split /-/, $val;
                            $from = undef unless $from =~ m/^\d{8}$/;
                            $to   = undef unless $to   =~ m/^\d{8}$/;
                            $from =~ s/^(\d{4})(\d{2})(\d{2})$/$1-$2-$3/;
                            $to   =~ s/^(\d{4})(\d{2})(\d{2})$/$1-$2-$3/;
                            $param
                                = $from && $to
                                ? {
                                option => 'range',
                                from   => $from,
                                to     => $to
                                }
                                : $from
                                ? { option => 'after', origin => $from }
                                : { option => 'before', origin => $to };
                        }
                        elsif ( $val =~ m/(\d+)days/i ) {
                            $param = { option => 'days', days => $1 };
                        }
                        elsif ( $val eq 'future' ) {
                            $param = { option => 'future' };
                        }
                        elsif ( $val eq 'past' ) {
                            $param = { option => 'past' };
                        }
                        return $param;
                    },
                    label_via_param => sub {
                        my $prop = shift;
                        my ( $app, $val ) = @_;
                        require MT::Util;
                        my ( $mode, $from, $to );
                        if ( $val =~ m/\-/ ) {
                            my ( $from, $to ) = split /-/, $val;
                            $from = undef unless $from =~ m/^\d{8}$/;
                            $to   = undef unless $to   =~ m/^\d{8}$/;
                            my $format = '%x';
                            $from = MT::Util::format_ts(
                                $format, $from . '000000',
                                undef,   MT->current_language
                            ) if $from;
                            $to = MT::Util::format_ts(
                                $format, $to . '000000',
                                undef,   MT->current_language
                            ) if $to;
                            if ( $from && $to ) {
                                return MT->translate(
                                    '[_1] [_2] between [_3] and [_4]',
                                    $prop->datasource->class_label_plural,
                                    $prop->label,
                                    $from,
                                    $to,
                                );
                            }
                            elsif ($from) {
                                return MT->translate(
                                    '[_1] [_2] since [_3]',
                                    $prop->datasource->class_label_plural,
                                    $prop->label,
                                    $from,
                                );
                            }
                            else {
                                return MT->translate(
                                    '[_1] [_2] or before [_3]',
                                    $prop->datasource->class_label_plural,
                                    $prop->label,
                                    $to,
                                );
                            }
                        }
                        elsif ( $val =~ m/(\d+)days/i ) {
                            return MT->translate(
                                '[_1] [_2] these [_3] days',
                                $prop->datasource->class_label_plural,
                                $prop->label, $1,
                            );
                        }
                        elsif ( $val eq 'future' ) {
                            return MT->translate(
                                '[_1] [_2] future',
                                $prop->datasource->class_label_plural,
                                $prop->label,
                            );
                        }
                        elsif ( $val eq 'past' ) {
                            return MT->translate(
                                '[_1] [_2] past',
                                $prop->datasource->class_label_plural,
                                $prop->label,
                            );
                        }
                    },

                    filter_tmpl => sub {
                        ## since __trans macro doesn't work with including itself
                        ## recursively, so do translate by hand here.
                        my $prop  = shift;
                        my $label = '<mt:var name="label">';
                        my $tmpl
                            = $prop->use_future
                            ? 'filter_form_future_date'
                            : 'filter_form_date';
                        my $opts
                            = $prop->use_future
                            ? '<mt:var name="future_date_filter_options">'
                            : '<mt:var name="date_filter_options">';
                        my $contents
                            = $prop->use_future
                            ? '<mt:var name="future_date_filter_contents">'
                            : '<mt:var name="date_filter_contents">';
                        return MT->translate(
                            '<mt:var name="[_1]"> [_2] [_3] [_4]',
                            $tmpl, $label, $opts, $contents );
                    },
                    base_type => 'date',
                    html      => sub {
                        my $prop = shift;
                        my ( $obj, $app, $opts ) = @_;
                        my $ts          = $prop->raw(@_) or return '';
                        my $date_format = MT::App::CMS::LISTING_DATE_FORMAT();
                        my $blog        = $opts->{blog};
                        my $is_relative
                            = ( $app->user->date_format || 'relative' ) eq
                            'relative' ? 1 : 0;
                        return $is_relative
                            ? MT::Util::relative_date( $ts, time, $blog )
                            : MT::Util::format_ts(
                            $date_format,
                            $ts,
                            $blog,
                            $app->user ? $app->user->preferred_language
                            : undef
                            );
                    },
                    priority           => 5,
                    default_sort_order => 'descend',
                },
                single_select => {
                    base      => '__virtual.base',
                    sort      => 0,
                    singleton => 1,
                    terms     => sub {
                        my $prop   = shift;
                        my ($args) = @_;
                        my $col    = $prop->col || $prop->type or die;
                        my $value  = $args->{value};
                        return { $col => $value };
                    },
                    label_via_param => sub {
                        my $prop = shift;
                        my ( $app, $val ) = @_;
                        my $opts = $prop->single_select_options;
                        my ($selected) = grep { $_->{value} eq $val } @$opts
                            or return $prop->error(
                            MT->translate('Invalid parameter.') );
                        return MT->translate(
                            '[_1] [_3] [_2]',
                            $prop->label,
                            $selected->{label},
                            (   defined $prop->verb
                                ? $prop->verb
                                : $app->translate('__SELECT_FILTER_VERB')
                            )
                        );
                    },
                    args_via_param => sub {
                        my $prop = shift;
                        my ( $app, $val ) = @_;
                        return { value => $val };
                    },
                    filter_tmpl =>
                        '<mt:Var name="filter_form_single_select">',
                    base_type => 'single_select',
                    priority  => 2,
                },
                id => {
                    auto               => 1,
                    default_sort_order => 'ascend',
                    label              => 'ID',
                },
                ## translate('No Title')
                ## translate('No Name')
                ## translate('No Label')
                label => {
                    auto              => 1,
                    label             => 'Label',
                    display           => 'force',
                    alternative_label => 'No label',
                    html => \&MT::ListProperty::common_label_html,
                },
                title => {
                    base              => '__virtual.label',
                    alternative_label => 'No Title',
                },
                name => {
                    base              => '__virtual.label',
                    alternative_label => 'No Name',
                },
                created_on => {
                    auto    => 1,
                    label   => 'Date Created',
                    display => 'optional',
                },
                modified_on => {
                    auto    => 1,
                    label   => 'Date Modified',
                    display => 'optional',
                },
                author_name => {
                    label        => 'Author',
                    filter_label => 'Author Name',
                    display      => 'default',
                    base         => '__virtual.string',
                    raw          => sub {
                        my ( $prop, $obj ) = @_;
                        my $col
                            = $prop->datasource->has_column('author_id')
                            ? 'author_id'
                            : 'created_by';
                        my $author = MT->model('author')->load( $obj->$col );
                        return $author
                            ? ( $author->nickname || $author->name )
                            : MT->translate('*User deleted*');
                    },
                    terms => sub {
                        my $prop = shift;
                        my ( $args, $load_terms, $load_args ) = @_;
                        my $col
                            = $prop->datasource->has_column('author_id')
                            ? 'author_id'
                            : 'created_by';
                        my $driver  = $prop->datasource->driver;
                        my $colname = $driver->dbd->db_column_name(
                            $prop->datasource->datasource, $col );
                        $prop->{col} = 'name';
                        my $name_query = $prop->super(@_);
                        $prop->{col} = 'nickname';
                        my $nick_query = $prop->super(@_);
                        $load_args->{joins} ||= [];
                        push @{ $load_args->{joins} },
                            MT->model('author')->join_on(
                            undef,
                            [   [   {   id => \"= $colname",
                                        %$name_query,
                                    },
                                    (   $args->{'option'} eq 'not_contains'
                                        ? '-and'
                                        : '-or'
                                    ),
                                    {   id => \"= $colname",
                                        %$nick_query,
                                    },
                                ]
                            ],
                            {}
                            );
                    },
                    bulk_sort => sub {
                        my $prop = shift;
                        my ($objs) = @_;
                        my $col
                            = $prop->datasource->has_column('author_id')
                            ? 'author_id'
                            : 'created_by';
                        my %author_id = map { $_->$col => 1 } @$objs;
                        my @authors = MT->model('author')
                            ->load( { id => [ keys %author_id ] } );
                        my %nickname
                            = map { $_->id => $_->nickname } @authors;
                        return sort {
                            $nickname{ $a->$col } cmp $nickname{ $b->$col }
                        } @$objs;
                    },
                },
                tag => {
                    base    => '__virtual.string',
                    label   => 'Tag',
                    display => 'none',
                    terms   => sub {
                        my $prop = shift;
                        my ( $args, $base_terms, $base_args, $opts ) = @_;
                        my $option  = $args->{option};
                        my $query   = $args->{string};
                        my $blog_id = $opts->{blog_ids};
                        if ( 'contains' eq $option ) {
                            $query = { like => "%$query%" };
                        }
                        elsif ( 'not_contains' eq $option ) {

                            # After searching by LIKE, negate that results.
                            $query = { like => "%$query%" };
                        }
                        elsif ( 'beginning' eq $option ) {
                            $query = { like => "$query%" };
                        }
                        elsif ( 'end' eq $option ) {
                            $query = { like => "%$query" };
                        }
                        my $ds           = $prop->object_type;
                        my $tagged_class = $prop->tagged_class || $ds;
                        my $join_str     = '= objecttag_object_id';
                        my $ds_join      = MT->model($ds)->join_on(
                            undef,
                            {   id => \$join_str,
                                ( $blog_id ? ( blog_id => $blog_id ) : () ),
                                (   $tagged_class eq '*' ? ()
                                    : ( class => $tagged_class )
                                ),
                            },
                            {   unique => 1,
                                (   $tagged_class eq '*' ? ( no_class => 1 )
                                    : ()
                                ),
                            }
                        );

                        my $tag_ds = $prop->tag_ds || $ds;
                        $join_str = '= objecttag_tag_id';
                        my @objecttag_terms_args = (
                            { object_datasource => $tag_ds, },
                            {   fetchonly => { object_id => 1 },
                                unique    => 1,
                                joins     => [
                                    MT->model('tag')->join_on(
                                        undef,
                                        {   name => $query,
                                            id   => \$join_str,
                                        },
                                    ),
                                    $ds_join,
                                ],
                            }
                        );
                        if ( 'not_contains' eq $option ) {
                            my @ids = map( $_->object_id,
                                MT->model('objecttag')
                                    ->load(@objecttag_terms_args) );
                            { id => { not => \@ids } };
                        }
                        else {
                            $base_args->{joins} ||= [];
                            push @{ $base_args->{joins} },
                                MT->model('objecttag')
                                ->join_on( undef, @objecttag_terms_args );
                        }
                    },
                },
                object_count => {
                    base               => '__virtual.integer',
                    col_class          => 'num',
                    default_sort_order => 'descend',
                    ref_column         => 'id',
                    raw                => sub {
                        my $prop = shift;
                        my ( $obj, $app, $opts ) = @_;
                        my $count_terms
                            = $prop->has('count_terms')
                            ? $prop->count_terms($opts)
                            : {};
                        my $count_args
                            = $prop->has('count_args')
                            ? $prop->count_args($opts)
                            : {};
                        MT->model( $prop->count_class )
                            ->count(
                            { %$count_terms, $prop->count_col => $obj->id },
                            $count_args, );
                    },
                    html => sub {
                        my $prop = shift;
                        my ( $obj, $app ) = @_;
                        my $count = $prop->raw(@_);
                        if ( $prop->has('list_permit_action') ) {
                            my $user = $app->user;
                            my $perm = $user->permissions(
                                  $obj->isa('MT::Blog')       ? ( $obj->id )
                                : $obj->has_column('blog_id') ? $obj->blog_id
                                : 0
                            );
                            return $count
                                unless $perm->can_do(
                                $prop->list_permit_action );
                        }
                        my $args;
                        if ( $prop->filter_type eq 'blog_id' ) {
                            $args = {
                                _type => $prop->list_screen
                                    || $prop->count_class,
                                blog_id => $obj->id,
                            };
                        }
                        else {
                            $args = {
                                _type => $prop->list_screen
                                    || $prop->count_class,
                                blog_id =>
                                    ( $app->blog ? $app->blog->id : 0 ),
                                (   $prop->has('filter_type')
                                    ? ( filter     => $prop->filter_type,
                                        filter_val => $obj->id,
                                        )
                                    : ()
                                ),
                            };
                        }
                        my $uri = $app->uri(
                            mode => 'list',
                            args => $args,
                        );
                        return qq{<a href="$uri">$count</a>};
                    },
                    bulk_sort => sub {
                        my $prop = shift;
                        my ( $objs, $opts ) = @_;
                        my $count_terms
                            = $prop->has('count_terms')
                            ? $prop->count_terms($opts)
                            : {};
                        my $count_args
                            = $prop->has('count_args')
                            ? $prop->count_args($opts)
                            : {};
                        my $iter
                            = MT->model( $prop->count_class )->count_group_by(
                            $count_terms,
                            {   %$count_args,
                                sort      => 'cnt',
                                direction => 'descend',
                                group     => [ $prop->count_col, ],
                            },
                            );
                        return @$objs unless $iter;
                        my @res;
                        my %obj_map = map { $_->id => $_ } @$objs;

                        while ( my ( $count, $id ) = $iter->() ) {
                            next unless $id;
                            push @res, delete $obj_map{$id} if $obj_map{$id};
                        }
                        push @res, values %obj_map;
                        return reverse @res;
                    },
                    terms => 0,
                    grep  => sub {
                        my $prop = shift;
                        my ( $args, $objs, $opts ) = @_;
                        my $count_terms
                            = $prop->has('count_terms')
                            ? $prop->count_terms($opts)
                            : {};
                        my $count_args
                            = $prop->has('count_args')
                            ? $prop->count_args($opts)
                            : {};
                        my $iter
                            = MT->model( $prop->count_class )->count_group_by(
                            $count_terms,
                            {   %$count_args,
                                direction => 'descend',
                                group     => [ $prop->count_col, ],
                            },
                            );
                        my %map;
                        while ( my ( $count, $id ) = $iter->() ) {
                            $map{$id} = $count;
                        }
                        my $op
                            = $args->{option} eq 'equal'         ? '=='
                            : $args->{option} eq 'not_equal'     ? '!='
                            : $args->{option} eq 'greater_than'  ? '<'
                            : $args->{option} eq 'greater_equal' ? '<='
                            : $args->{option} eq 'less_than'     ? '>'
                            : $args->{option} eq 'less_equal'    ? '>='
                            :                                      '';
                        return @$objs unless $op;
                        my $val     = $args->{value};
                        my $sub     = eval "sub { $val $op shift }";
                        my $ref_col = $prop->ref_column;
                        return
                            grep { $sub->( $map{ $_->$ref_col } || 0 ) }
                            @$objs;
                    },
                },
            },
            __common => {
                __legacy => {
                    label           => 'Legacy Quick Filter',
                    priority        => 1,
                    filter_editable => 0,
                    singleton       => 1,
                    terms           => sub {
                        my $prop = shift;
                        my ( $args, $db_terms, $db_args ) = @_;
                        my $ds         = $args->{ds};
                        my $filter_key = $args->{filter_key};
                        my $filter_val = $args->{filter_val};
                        if ($filter_val) {
                            MT->app->param( 'filter_val', $filter_val );
                        }
                        my $filter
                            = MT->registry(
                            applications => cms => list_filters => $ds =>
                                $filter_key )
                            or die "No regacy filter";
                        if ( my $code = $filter->{code}
                            || MT->handler_to_coderef( $filter->{handler} ) )
                        {
                            $code->( $db_terms, $db_args );
                        }
                        return undef;
                    },
                    filter_tmpl => '<mt:var name="filter_form_legacy">',
                },
                __id => {
                    base        => '__virtual.integer',
                    col         => 'id',
                    display     => 'none',
                    view_filter => [],
                },
                pack => {
                    view  => [],
                    terms => \&MT::Filter::pack_terms,
                    grep  => \&MT::Filter::pack_grep,
                },
                blog_name => {
                    label     => 'Blog Name',
                    filter_label => '__WEBSITE_BLOG_NAME',
                    order     => 10000,
                    display   => 'default',
                    site_name => 1,
                    view      => [ 'system' ],
                    bulk_html => sub {
                        my $prop     = shift;
                        my ($objs)   = @_;
                        my %blog_ids = map { $_->blog_id => 1 } @$objs;
                        my @blogs    = MT->model('blog')->load(
                            { id => [ keys %blog_ids ], },
                            {   fetchonly => {
                                    id        => 1,
                                    name      => 1,
                                }
                            }
                        );
                        my %blog_map = map { $_->id        => $_ } @blogs;
#                        my %site_ids = map { $_->parent_id => 1 }
#                            grep { $_->parent_id && !$blog_map{ $_->parent_id } } @blogs;
#                        my @sites
#                            = MT->model('website')
#                            ->load( { id => [ keys %site_ids ], },
#                            { fetchonly => { id => 1, name => 1, }, } )
#                            if keys %site_ids;
                        my %blog_site_map
                            = map { $_->id => $_ } ( @blogs );
                        my @out;

                        for my $obj (@$objs) {
                            if ( !$obj->blog_id ) {
                                push @out, MT->translate('(system)');
                                next;
                            }
                            my $blog = $blog_site_map{ $obj->blog_id };
                            unless ($blog) {
                                push @out,
                                    MT->translate('*Blog deleted*');
                                next;
                            }
                            push @out, $blog->name;
                        }
                        return map { MT::Util::encode_html($_) } @out;
                    },
                    condition => sub {
                        my $prop = shift;
                        $prop->datasource->has_column('blog_id') or return;
                        my $app = MT->app or return;
                        return !$app->blog;
                    },
                    bulk_sort => sub {
                        my $prop    = shift;
                        my ($objs)  = @_;
                        my %blog_id = map { $_->blog_id => 1 } @$objs;
                        my @blogs
                            = MT->model('blog')
                            ->load( { id => [ keys %blog_id ] },
                            { no_class => 1, } );
                        my %blogname = map { $_->id => $_->name } @blogs;
                        return sort {
                            $blogname{ $a->blog_id }
                                cmp $blogname{ $b->blog_id }
                        } @$objs;
                    },
                },
                current_user => {
                    base            => '__virtual.hidden',
                    label           => 'My Items',
                    order           => 20000,
                    display         => 'none',
                    filter_editable => 0,
                    condition       => sub {
                        my $prop  = shift;
                        my $class = $prop->datasource;
                        return $class->has_column('author_id')
                            || $class->has_column('created_by');
                    },
                    terms => sub {
                        my $prop = shift;
                        my ( $args, $load_terms, $load_args ) = @_;
                        my $app = MT->app or return;
                        my $class = $prop->datasource;
                        my $col
                            = $class->has_column('author_id')
                            ? 'author_id'
                            : 'created_by';
                        return { $col => $app->user->id };
                    },
                    singleton       => 1,
                    label_via_param => sub {
                        my $prop  = shift;
                        my $class = $prop->datasource;
                        return MT->translate( 'My [_1]',
                            $class->class_label_plural );
                    },
                },
                current_context => {
                    base  => '__virtual.hidden',
                    label => sub {
                        my $prop = shift;
                        my ($settings) = @_;
                        return MT->translate(
                            '[_1] of this Website',
                            $settings->{object_label_plural}
                                || $prop->datasource->class_label_plural,
                        );
                    },
                    order           => 30000,
                    view            => 'website',
                    display         => 'none',
                    filter_editable => 1,
                    condition       => sub {
                        my $prop = shift;
                        $prop->datasource->has_column('blog_id');
                    },
                    terms => sub {
                        my $prop = shift;
                        my ( $args, $load_terms, $load_args, $opts ) = @_;
                        { blog_id => $opts->{blog_id} };
                    },
                    singleton => 1,
                },
            },
            blog         => '$Core::MT::Blog::list_props',
            entry        => '$Core::MT::Entry::list_props',
            page         => '$Core::MT::Page::list_props',
            asset        => '$Core::MT::Asset::list_props',
            category     => '$Core::MT::Category::list_props',
            folder       => '$Core::MT::Folder::list_props',
            comment      => '$Core::MT::Comment::list_props',
            ping         => '$Core::MT::TBPing::list_props',
            author       => '$Core::MT::Author::list_props',
            member       => '$Core::MT::Author::member_list_props',
            commenter    => '$Core::MT::Author::commenter_list_props',
            tag          => '$Core::MT::Tag::list_props',
            banlist      => '$Core::MT::IPBanList::list_props',
            association  => '$Core::MT::Association::list_props',
            role         => '$Core::MT::Role::list_props',
            notification => '$Core::MT::Notification::list_props',
            log          => '$Core::MT::Log::list_props',
            filter       => '$Core::MT::Filter::list_props',
        },
        system_filters => {
            entry     => '$Core::MT::Entry::system_filters',
            page      => '$Core::MT::Page::system_filters',
            comment   => '$Core::MT::Comment::system_filters',
            ping      => '$Core::MT::TBPing::system_filters',
            tag       => '$Core::MT::Tag::system_filters',
            asset     => '$Core::MT::Asset::system_filters',
            author    => '$Core::MT::Author::system_filters',
            member    => '$Core::MT::Author::member_system_filters',
            commenter => '$Core::MT::Author::commenter_system_filters',
            log       => '$Core::MT::Log::system_filters',
        },
        listing_screens => {
            blog => {
                object_label     => 'Blog',
                view             => [qw( system )],
                primary          => 'name',
                default_sort_key => 'name',
                scope_mode       => 'none',
            },
            entry => {
                object_label     => 'Entry',
                primary          => 'title',
                default_sort_key => 'authored_on',
                permission       => "access_to_entry_list",
                feed_link        => sub {
                    my ($app) = @_;
                    return 1 if $app->user->is_superuser;

                    if ( $app->blog ) {
                        return 1
                            if $app->user->can_do( 'get_entry_feed',
                            at_least_one => 1 );
                    }
                    else {
                        my $iter = MT->model('permission')->load_iter(
                            {   author_id => $app->user->id,
                                blog_id   => { not => 0 },
                            }
                        );
                        my $cond;
                        while ( my $p = $iter->() ) {
                            $cond = 1, last
                                if $p->can_do('get_entry_feed');
                        }
                        return $cond ? 1 : 0;
                    }
                    0;
                },
                condition => sub {
                    my $app = MT->instance;
                    return 1 if $app->user->is_superuser;

                    my $blog = $app->blog;
                    my $blog_ids = !$blog ? undef : [ $blog->id ];

                    require MT::Permission;
                    my $iter = MT::Permission->load_iter(
                        {   author_id => $app->user->id,
                            (   $blog_ids
                                ? ( blog_id => $blog_ids )
                                : ( blog_id => { not => 0 } )
                            ),
                        }
                    );

                    my $cond;
                    while ( my $p = $iter->() ) {
                        $cond = 1, last
                            if $p->can_do('access_to_entry_list')
                                and $p->blog;
                    }
                    return $cond ? 1 : 0;
                },
            },
            page => {
                object_label     => 'Page',
                primary          => 'title',
                default_sort_key => 'modified_on',
                permission       => 'access_to_page_list',
                feed_link        => sub {
                    my ($app) = @_;
                    return 1 if $app->user->is_superuser;

                    if ( $app->blog ) {
                        return 1
                            if $app->user->can_do( 'get_page_feed',
                            at_least_one => 1 );
                    }
                    else {
                        my $iter = MT->model('permission')->load_iter(
                            {   author_id => $app->user->id,
                                blog_id   => { not => 0 },
                            }
                        );
                        my $cond;
                        while ( my $p = $iter->() ) {
                            $cond = 1, last
                                if $p->can_do('get_page_feed');
                        }
                        return $cond ? 1 : 0;
                    }
                    0;
                },
            },
            asset => {
                object_label     => 'Asset',
                primary          => 'label',
                permission       => 'access_to_asset_list',
                default_sort_key => 'created_on',
            },
            log => {
                object_label     => 'Log',
                default_sort_key => 'created_on',
                primary          => 'message',
                condition        => sub {
                    my $app     = MT->instance;
                    my $user    = $app->user;
                    my $blog_id = $app->param('blog_id');
                    return 1 if $user->is_superuser;
                    return 0 unless defined $blog_id;

                    my $terms;
                    push @$terms, { author_id => $user->id };
                    if ($blog_id) {
                        my $blog = MT->model('blog')->load($blog_id);
                        my @blog_ids;
                        push @blog_ids, $blog_id;
                        push @$terms,
                            [
                            '-and',
                            {   blog_id => \@blog_ids,
                                permissions =>
                                    { like => "\%'view_blog_log'\%" },
                            }
                            ];
                    }
                    else {
                        my $gt = ' > 0';
                        push @$terms,
                            [
                            '-and',
                            [   {   blog_id => 0,
                                    permissions =>
                                        { like => "\%'view_log'\%" },
                                },
                                '-or',
                                {   blog_id => \$gt,
                                    permissions =>
                                        { like => "\%'view_blog_log'\%" },
                                }
                            ]
                            ];
                    }

                    my $cnt = MT->model('permission')->count($terms);
                    return ( $cnt && $cnt > 0 ) ? 1 : 0;
                },
                feed_link => sub {
                    my ($app) = @_;
                    return 1 if $app->user->is_superuser;
                    return 1 if $app->can_do('get_all_system_feed');

                    if ( $app->blog ) {
                        return 1
                            if $app->user->can_do( 'get_system_feed',
                            at_least_one => 1 );
                    }
                    else {
                        my $iter = MT->model('permission')->load_iter(
                            {   author_id => $app->user->id,
                                blog_id   => { not => 0 },
                            }
                        );
                        my $cond;
                        while ( my $p = $iter->() ) {
                            $cond = 1, last
                                if $p->can_do('get_system_feed');
                        }
                        return $cond ? 1 : 0;
                    }

                    0;
                },
                feed_label   => 'Activity Feed',
                screen_label => 'Activity Log',
            },
            category => {
                object_label          => 'Category',
                primary               => 'label',
                template              => 'list_category.tmpl',
                contents_label        => 'Entry',
                contents_label_plural => 'Entries',
                permission            => 'access_to_category_list',
                view                  => 'blog',
                scope_mode            => 'this',
                condition             => sub {
                    my $app = shift;
                    ( $app->param('_type') || '' ) ne 'filter';
                },
            },
            folder => {
                primary               => 'label',
                object_label          => 'Folder',
                template              => 'list_category.tmpl',
                search_type           => 'page',
                contents_label        => 'Page',
                contents_label_plural => 'Pages',
                permission            => 'access_to_folder_list',
                view                  => [ 'blog' ],
                scope_mode            => 'this',
                condition             => sub {
                    my $app = shift;
                    ( $app->param('_type') || '' ) ne 'filter';
                },
            },
            comment => {
                object_label     => 'Comment',
                default_sort_key => 'created_on',
                permission       => 'access_to_comment_list',
                primary          => 'comment',
                feed_link        => sub {
                    my ($app) = @_;
                    return 1 if $app->user->is_superuser;

                    if ( $app->blog ) {
                        return 1
                            if $app->user->can_do( 'get_comment_feed',
                            at_least_one => 1 );
                    }
                    else {
                        my $iter = MT->model('permission')->load_iter(
                            {   author_id => $app->user->id,
                                blog_id   => { not => 0 },
                            }
                        );
                        my $cond;
                        while ( my $p = $iter->() ) {
                            $cond = 1, last
                                if $p->can_do('get_comment_feed');
                        }
                        return $cond ? 1 : 0;
                    }
                    0;
                },
            },
            ping => {
                primary          => 'excerpt',
                object_label     => 'Trackback',
                default_sort_key => 'created_on',
                permission       => 'access_to_trackback_list',
                feed_link        => sub {
                    my ($app) = @_;
                    return 1 if $app->user->is_superuser;

                    if ( $app->blog ) {
                        return 1
                            if $app->user->can_do( 'get_trackback_feed',
                            at_least_one => 1 );
                    }
                    else {
                        my $iter = MT->model('permission')->load_iter(
                            {   author_id => $app->user->id,
                                blog_id   => { not => 0 },
                            }
                        );
                        my $cond;
                        while ( my $p = $iter->() ) {
                            $cond = 1, last
                                if $p->can_do('get_trackback_feed');
                        }
                        return $cond ? 1 : 0;
                    }
                    0;
                },
            },
            author => {
                object_label     => 'Author',
                primary          => 'name',
                permission       => 'administer',
                default_sort_key => 'name',
                view             => 'system',
                scope_mode       => 'none',
            },
            commenter => {
                primary             => 'name',
                object_label        => 'Commenter',
                object_label_plural => 'Commenters',
                object_type         => 'author',
                permission          => 'administer',
                default_sort_key    => 'name',
                condition           => sub {
                    return MT->config->SingleCommunity;
                },
                view         => 'system',
                scope_mode   => 'none',
                screen_label => 'Manage Commenters',
            },
            member => {
                primary             => 'name',
                object_label        => 'Member',
                object_label_plural => 'Members',
                object_type         => 'author',
                default_sort_key    => 'name',
                view                => [ 'blog' ],
                scope_mode          => 'none',
                permission          => {
                    permit_action => 'access_to_blog_member_list',
                    inherit       => 0,
                },
            },
            tag => {
                primary      => 'name',
                object_label => 'Tag',
                permission   => {
                    permit_action => 'access_to_tag_list',
                    inherit       => 0,
                },
                default_sort_key => 'name',
                view             => [ 'blog' ],
                scope_mode       => 'none',
            },
            association => {
                object_label        => 'Permission',
                object_label_plural => 'Permissions',
                object_type         => 'association',
                search_type         => 'author',

                #permission => 'access_to_permission_list',
                default_sort_key => 'created_on',
                primary          => [ 'user_name', 'role_name' ],
                view             => 'system',
            },
            role => {
                object_label     => 'Role',
                object_type      => 'role',
                search_type      => 'author',
                primary          => 'name',
                permission       => 'access_to_role_list',
                default_sort_key => 'name',
                view             => 'system',
            },
            banlist => {
                object_label        => 'IP address',
                object_label_plural => 'IP addresses',
                action_label        => 'IP address',
                action_label_plural => 'IP addresses',
                zero_state          => 'IP address',
                condition           => sub {
                    my $app = shift;
                    return 1 if MT->config->ShowIPInformation;
                    $app->errtrans(
                        'IP Banlist is disabled by system configuration.');
                },
                primary          => 'ip',
                permission       => 'access_to_banlist',
                default_sort_key => 'created_on',
                screen_label     => 'IP Banning Settings',
            },
            notification => {
                object_label => 'Contact',
                condition    => sub {
                    my $app = shift;
                    return 1 if MT->config->EnableAddressbook;
                    $app->errtrans(
                        'Address Book is disabled by system configuration.');
                },
                permission       => 'access_to_notification_list',
                primary          => [ 'email', 'url' ],
                default_sort_key => 'created_on',
                screen_label     => 'Manage Address Book',
            },
            filter => {
                object_label     => 'Filter',
                view             => 'system',
                permission       => 'access_to_filter_list',
                primary          => 'label',
                default_sort_key => 'created_on',
                scope_mode       => 'none',
            },
        },
        summaries => {
            'author' => {
                entry_count => {
                    type => 'integer',
                    code =>
                      '$Core::MT::Summary::Author::summarize_entry_count',
                    expires => {
                        'MT::Entry' => {
                            id_column => 'author_id',
                            code =>
                              '$Core::MT::Summary::Author::expire_entry_count',
                        },
                    },
                },
                comment_count => {
                    type => 'integer',
                    code =>
                      '$Core::MT::Summary::Author::summarize_comment_count',
                    expires => {
                        'MT::Comment' => {
                            id_column => 'commenter_id',
                            code =>
                              '$Core::MT::Summary::Author::expire_comment_count',
                        },
                        'MT::Entry' => {
                            id_column => 'author_id',
                            code =>
                              '$Core::MT::Summary::Author::expire_comment_count_entry',
                        },
                    },
                },
            },
            'entry' => {
                all_assets => {
                    type => 'string',
                    code => '$Core::MT::Summary::Entry::summarize_all_assets',
                    expires => {
                                 'MT::ObjectAsset' => {
                                     id_column => 'object_id',
                                     code => '$Core::MT::Summary::expire_all',
                                 }
                    }
                }
            },
        },
        backup_instructions => \&load_backup_instructions,
        permission_groups   => {
            sys_admin => {
                label => 'System Administration',
                order => 100,
                system => 1
            },
            blog_admin => {
                label => 'Administration',
                order => 100,
                system => 0
            },
            auth_pub => {
                label => 'Authoring and Publishing',
                order => 200,
                system => 0
            },
            blog_design => {
                label => 'Designing',
                order => 300,
                system => 0
            },
            blog_upload => {
                label => 'Assets',
                order => 400,
                system => 0
            },
            blog_comment => {
                label => 'Commenting',
                order => 500,
                system => 0
            }
        },
        permissions         => {
            'system.administer' => {
                                     label => trans("System Administrator"),
                                     group => 'sys_admin',
                                     order => 0,
            },
            'system.create_blog' => {
                                      label => trans("Create Blogs"),
                                      group => 'sys_admin',
                                      order => 100,
            },
            'system.manage_plugins' => {
                                         label => trans('Manage Plugins'),
                                         group => 'sys_admin',
                                         order => 200,
            },
            'system.edit_templates' => {
                                         label => trans('Manage Templates'),
                                         group => 'sys_admin',
                                         order => 250,
            },
            'system.view_log' => {
                                   label => trans("View System Activity Log"),
                                   group => 'sys_admin',
                                   order => 300,
            },

            'blog.administer_blog' => {
                                        label => trans("Blog Administrator"),
                                        group => 'blog_admin',
                                        order => 0,
            },
            'blog.edit_config' => {
                                    label => trans("Configure Blog"),
                                    group => 'blog_admin',
                                    order => 100,
            },
            'blog.set_publish_paths' => {
                                       label => trans('Set Publishing Paths'),
                                       group => 'blog_admin',
                                       order => 200,
            },
            'blog.edit_categories' => {
                                        label => trans('Manage Categories'),
                                        group => 'blog_admin',
                                        order => 300,
            },
            'blog.edit_tags' => {
                                  label => trans('Manage Tags'),
                                  group => 'blog_admin',
                                  order => 400,
            },
            'blog.edit_notifications' => {
                                        label => trans('Manage Address Book'),
                                        group => 'blog_admin',
                                        order => 500,
            },
            'blog.view_blog_log' => {
                                      label => trans('View Activity Log'),
                                      group => 'blog_admin',
                                      order => 600,
            },
            'blog.manage_users' => {
                                     label => trans('Manage Users'),
                                     group => 'blog_admin',
                                     order => 700,
            },

            'blog.create_post' => {
                                    label => trans('Create Entries'),
                                    group => 'auth_pub',
                                    order => 100,
            },
            'blog.publish_post' => {
                                     label => trans('Publish Entries'),
                                     group => 'auth_pub',
                                     order => 200,
            },
            'blog.send_notifications' => {
                                         label => trans('Send Notifications'),
                                         group => 'auth_pub',
                                         order => 300,
            },
            'blog.edit_all_posts' => {
                                       label => trans('Edit All Entries'),
                                       group => 'auth_pub',
                                       order => 400,
            },
            'blog.manage_pages' => {
                                     label => trans('Manage Pages'),
                                     group => 'auth_pub',
                                     order => 500,
            },
            'blog.rebuild' => {
                                label => trans('Publish Blog'),
                                group => 'auth_pub',
                                order => 600,
            },

            'blog.edit_templates' => {
                                       label => trans('Manage Templates'),
                                       group => 'blog_design',
                                       order => 100,
            },

            'blog.upload' => {
                               label => trans("Upload File"),
                               group => 'blog_upload',
                               order => 100,
            },
            'blog.save_image_defaults' => {
                                        label => trans('Save Image Defaults'),
                                        group => 'blog_upload',
                                        order => 200,
            },
            'blog.edit_assets' => {
                                    label => trans('Manage Assets'),
                                    group => 'blog_upload',
                                    order => 300,
            },

            'blog.comment' => {
                                label => trans("Post Comments"),
                                group => 'blog_comment',
                                order => 100,
            },
            'blog.manage_feedback' => {
                                        label => trans('Manage Feedback'),
                                        group => 'blog_comment',
                                        order => 200,
            },
        },
        config_settings => {
            'AtomApp' => {
                           type    => 'HASH',
                           default => {
                                   weblog => 'MT::AtomServer::Weblog::Legacy',
                                   '1.0'  => 'MT::AtomServer::Weblog',
                                   comments => 'MT::AtomServer::Comments',
                           },
            },
            'SchemaVersion'   => undef,
            'MTVersion'       => undef,
            'NotifyUpgrade'   => { default => 1 },
            'Database'        => undef,
            'DBHost'          => undef,
            'DBSocket'        => undef,
            'DBPort'          => undef,
            'DBUser'          => undef,
            'DBPassword'      => undef,
            'DefaultLanguage' => { default => 'en_US', },
            'LocalPreviews'   => { default => 0 },
            'DefaultSiteRoot' => { default => '', },
            'DefaultSiteURL'  => { default => '', },
            'DefaultCommenterAuth' =>
              { default => 'MovableType,LiveJournal,Vox' },
            'TemplatePath' => { default => 'tmpl', path => 1, },
            'WeblogTemplatesPath' =>
              { default => 'default_templates', path => 1, },
            'AltTemplatePath' => { default => 'alt-tmpl', path => 1, },
            'CSSPath'         => { default => 'css', },
            'ImportPath'      => { default => 'import',   path => 1, },
            'PluginPath' =>
              { default => 'plugins', path => 1, type => 'ARRAY', },
            'PerlLocalLibPath' =>    # This directive is deprecated.
              { default => undef, path => 1, type => 'ARRAY', },
            'PERL5LIB' => { default => undef, path => 1, type => 'ARRAY', },
            'EnableArchivePaths' => { default => 0, },
            'SearchTemplatePath' =>
              { default => 'search_templates', path => 1, },
            'SupportDirectoryPath' => { default => '' },
            'SupportDirectoryURL'  => { default => '' },
            'ObjectDriver'         => undef,
            'ObjectCacheLimit'     => { default => 1000 },
            'ObjectCacheDisabled'  => undef,
            'DisableObjectCache'   => { default => 0, },
            'AllowedTextFilters'   => undef,
            'Serializer'           => { default => 'MT', },
            'SendMailPath'         => { default => '/usr/lib/sendmail', },
            'RsyncPath'            => undef,
            'TimeOffset'           => { default => 0, },
            'WSSETimeout'          => { default => 120, },
            'StaticWebPath'        => { default => '', },
            'StaticFilePath'       => undef,
            'CGIPath'              => { default => '/cgi-bin/', },
            'AdminCGIPath'         => undef,
            'CookieDomain'         => undef,
            'CookiePath'           => undef,
            'MailEncoding'         => { default => 'ISO-8859-1', },
            'MailTransfer'         => { default => 'sendmail' },
            'SMTPServer'           => { default => 'localhost', },
            'DebugEmailAddress'    => undef,
            'WeblogsPingURL' => { default => 'http://rpc.weblogs.com/RPC2', },
            'BlogsPingURL'   => { default => 'http://ping.blo.gs/', },
            'MTPingURL' =>
              { default => 'http://www.movabletype.org/update/', },
            'GooglePingURL' =>
              { default => 'http://blogsearch.google.com/ping/RPC2', },
            'CGIMaxUpload'          => { default => 20_480_000 },
            'DBUmask'               => { default => '0111', },
            'HTMLUmask'             => { default => '0111', },
            'UploadUmask'           => { default => '0111', },
            'DirUmask'              => { default => '0000', },
            'HTMLPerms'             => { default => '0666', },
            'UploadPerms'           => { default => '0666', },
            'NoTempFiles'           => { default => 0, },
            'TempDir'               => { default => '/tmp', },
            'RichTextEditor'        => { default => 'sixapart', },
            'EntriesPerRebuild'     => { default => 40, },
            'UseNFSSafeLocking'     => { default => 0, },
            'NoLocking'             => { default => 0, },
            'NoHTMLEntities'        => { default => 1, },
            'NoCDATA'               => { default => 0, },
            'NoPlacementCache'      => { default => 0, },
            'NoPublishMeansDraft'   => { default => 0, },
            'IgnoreISOTimezones'    => { default => 0, },
            'PingTimeout'           => { default => 60, },
            'HTTPTimeout'           => { default => 60 },
            'PingInterface'         => undef,
            'HTTPInterface'         => undef,
            'PingProxy'             => undef,
            'HTTPProxy'             => undef,
            'PingNoProxy'           => { default => 'localhost', },
            'HTTPNoProxy'           => { default => 'localhost', },
            'ImageDriver'           => { default => 'ImageMagick', },
            'NetPBMPath'            => undef,
            'AdminScript'           => { default => 'index.cgi', },
            'ActivityFeedScript'    => { default => 'feed.cgi', },
            'ActivityFeedItemLimit' => { default => 50, },
            'CommentScript'         => { default => 'comments.cgi', },
            'TrackbackScript'       => { default => 'tb.cgi', },
            'SearchScript'          => { default => 'search.cgi', },
            'XMLRPCScript'          => { default => 'xmlrpc.cgi', },
            'ViewScript'            => { default => 'view.cgi', },
            'AtomScript'            => { default => 'atom.cgi', },
            'UpgradeScript'         => { default => 'upgrade.cgi', },
            'CheckScript'           => { default => 'check.cgi', },
            'NotifyScript'          => { default => 'add-notify.cgi', },
            'PublishCharset'        => { default => 'utf-8', },
            'SafeMode'              => { default => 1, },
            'GlobalSanitizeSpec'    => {
                       default =>
                         'a href,b,i,br/,p,strong,em,ul,ol,li,blockquote,pre',
            },
            'GenerateTrackBackRSS'        => { default => 0, },
            'DBIRaiseError'               => { default => 0, },
            'SearchAlwaysAllowTemplateID' => { default => 0, },

            ## Search settings, copied from Jay's mt-search and integrated
            ## into default config.
            'NoOverride'          => { default => '', },
            'RegexSearch'         => { default => 0, },
            'CaseSearch'          => { default => 0, },
            'ResultDisplay'       => { default => 'descend', },
            'ExcerptWords'        => { default => 40, },
            'SearchElement'       => { default => 'entries', },
            'ExcludeBlogs'        => undef,
            'IncludeBlogs'        => undef,
            'DefaultTemplate'     => { default => 'default.tmpl', },
            'Type'                => { default => 'straight', },
            'MaxResults'          => { default => '20', },
            'SearchCutoff'        => { default => '9999999', },
            'CommentSearchCutoff' => { default => '30', },
            'AltTemplate' =>
              { type => 'ARRAY', default => 'feed results_feed.tmpl', },
            'SearchSortBy'          => undef,
            'SearchSortOrder'       => { default => 'ascend', },
            'SearchNoOverride'      => { default => 'SearchMaxResults', },
            'SearchResultDisplay'   => { alias => 'ResultDisplay', },
            'SearchExcerptWords'    => { alias => 'ExcerptWords', },
            'SearchDefaultTemplate' => { alias => 'DefaultTemplate', },
            'SearchMaxResults'      => { alias => 'MaxResults', },
            'SearchAltTemplate'     => { alias => 'AltTemplate' },
            'SearchPrivateTags'     => { default => 0 },
            'RegKeyURL' =>
              { default => 'http://www.typekey.com/extras/regkeys.txt', },
            'IdentitySystem' =>
              { default => 'http://www.typekey.com/t/typekey', },
            'SignOnURL' =>
              { default => 'https://www.typekey.com/t/typekey/login?', },
            'SignOffURL' =>
              { default => 'https://www.typekey.com/t/typekey/logout?', },
            'IdentityURL' => { default => "http://profile.typekey.com/", },
            'DynamicComments'           => { default => 0, },
            'SignOnPublicKey'           => { default => '', },
            'ThrottleSeconds'           => { default => 20, },
            'SearchCacheTTL'            => { default => 20, },
            'SearchThrottleSeconds'     => { default => 5 },
            'SearchThrottleIPWhitelist' => undef,
            'OneHourMaxPings'           => { default => 10, },
            'OneDayMaxPings'            => { default => 50, },
            'SupportURL' =>
              { default => 'http://getsatisfaction.com/openmelody', },
            'NewsURL' => { default => 'http://openmelody.org/blog/', },
            ### TODO The following should consume feeds instead of custom HTML
            'NewsboxURL' => {
                       default =>
                         'http://openmelody.org/blog/melody_news_widget.html',
            },
            'DocNewsURL' => {
                default => 'https://github.com/openmelody/melody/wiki.atom'
            },

            # 'MTNewsURL' => {
            #     default => 'http://www.sixapart.com/movabletype/news/mt4_news_widget.html',
            # },
            'LearningNewsURL' => { default => 'disable', },

            # 'HackingNewsURL' => {
            #     default => 'http://hacking.movabletype.org/newsbox.html',
            # },
            'EmailAddressMain'      => undef,
            'EmailReplyTo'          => undef,
            'EmailNotificationBcc'  => { default => 1, },
            'CommentSessionTimeout' => { default => 60 * 60 * 24 * 3, },
            'UserSessionTimeout'    => { default => 60 * 60 * 4, },
            'UserSessionCookieName' => { handler => \&UserSessionCookieName },
            'UserSessionCookieDomain' =>
              { default => '<$MTBlogHost exclude_port="1"$>' },
            'UserSessionCookiePath' => { handler => \&UserSessionCookiePath },
            'UserSessionCookieTimeout' => { default => 60 * 60 * 4, },
            'LaunchBackgroundTasks'    => { default => 0 },
            'TypeKeyVersion'           => { default => '1.1' },
            'TransparentProxyIPs'      => { default => 0, },

            # 11/Nov/2010 - Temporarily setting default DebugMode to 1. See
            # https://openmelody.lighthouseapp.com/projects/26604/tickets/567
            'DebugMode'     => { default => 0, },
            'AllowComments' => { default => 1, },
            'AllowPings'    => { default => 1, },
            'HelpURL'       => { default => 'http://openmelody.org/docs/', },
            'UsePlugins'    => { default => 1, },
            'PluginSwitch'  => { type    => 'HASH', },
            'PluginSchemaVersion'      => { type    => 'HASH', },
            'OutboundTrackbackLimit'   => { default => 'any', },
            'OutboundTrackbackDomains' => { type    => 'ARRAY', },
            'IndexBasename'            => { default => 'index', },
            'LogExportEncoding'        => { default => 'utf-8', },
            'ActivityFeedsRunTasks'    => { default => 1, },
            'ExportEncoding'           => { default => 'utf-8', },
            'SQLSetNames'              => undef,
            'UseSQLite2'               => { default => 0, },
            'UseJcodeModule'           => { default => 0, },
            'DefaultTimezone'          => { default => '0', },
            'CategoryNameNodash'       => { default => '0', },
            'DefaultListPrefs'         => { type    => 'HASH', },
            'DefaultEntryPrefs'        => {
                type    => 'HASH',
                default => {
                             type   => 'Default',    # Default|All|Custom
                             button => 'Below',      # Above|Below|Both
                             height => 162,          # textarea height
                },
            },
            'DeleteFilesAtRebuild'      => { default => 1, },
            'RebuildAtDelete'           => { default => 1, },
            'MaxTagAutoCompletionItems' => { default => 1000, },
            'NewUserAutoProvisioning' =>
              { handler => \&NewUserAutoProvisioning, },
            'NewUserTemplateBlogId' => undef,
            'DefaultUserLanguage'   => undef,
            'DefaultUserTagDelimiter' =>
              { handler => \&DefaultUserTagDelimiter, default => 'comma', },
            'JQueryURL'             => { handler => \&JQueryURL },
            'AuthenticationModule'  => { default => 'MT', },
            'AuthLoginURL'          => undef,
            'AuthLogoutURL'         => undef,
            'DefaultAssignments'    => undef,
            'AutoSaveFrequency'     => { default => 5 },
            'FuturePostFrequency'   => { default => 1 },
            'AssetCacheDir'         => { default => 'assets_c', },
            'IncludesDir'           => { default => 'includes_c', },
            'MemcachedServers'      => { type    => 'ARRAY', },
            'MemcachedNamespace'    => undef,
            'MemcachedDriver'       => { default => 'Cache::Memcached' },
            'CommenterRegistration' => {
                                  type    => 'HASH',
                                  default => { Allow => '1', Notify => q(), },
            },
            'CaptchaSourceImageBase' => undef,
            'SecretToken'            => { handler => \&SecretToken, },
            ## NaughtyWordChars settings
            'NwcSmartReplace' => { default => 0, },
            'NwcReplaceField' =>
              { default => 'title,text,text_more,keywords,excerpt,tags', },
            'DisableNotificationPings' => { default => 0 },
            'SyncTarget'               => { type    => 'ARRAY' },
            'RsyncOptions'             => undef,
            'UserpicAllowRect'         => { default => 0 },
            'UserpicMaxUpload'         => { default => 0 },
            'UserpicThumbnailSize'     => { default => 100 },

            ## Stats settings
            'StatsCacheTTL'        => { default => 15 },          # in minutes
            'StatsCachePublishing' => { default => 'OnLoad' },    # Off|OnLoad

            # Basename settings
            'AuthorBasenameLimit' => { default => 30 },
            'PerformanceLogging'  => { default => 0 },
            'PerformanceLoggingPath' =>
              { handler => \&PerformanceLoggingPath },
            'PerformanceLoggingThreshold' => { default => 0.1 },
            'ProcessMemoryCommand' => { handler => \&ProcessMemoryCommand },
            'EnableAddressBook'    => { default => 0 },
            'SingleCommunity'      => { default => 1 },
            'DefaultTemplateSet'   => { default => 'DePoClean_theme' },

            'AssetFileTypes' => { type => 'HASH' },

            'FastCGIMaxTime'     => { default => 60 * 60 },    # 1 hour
            'FastCGIMaxRequests' => { default => 1000 },       # 1000 requests

            'RPTFreeMemoryLimit'      => undef,
            'RPTProcessCap'           => undef,
            'RPTSwapMemoryLimit'      => undef,
            'SchwartzClientDeadline'  => undef,
            'SchwartzFreeMemoryLimit' => undef,
            'SchwartzSwapMemoryLimit' => undef,

            # Revision History
            'TrackRevisions'    => { default => 1 },
            'RevisioningDriver' => { default => 'Local' },
        },
        upgrade_functions => \&load_upgrade_fns,
        applications      => {
            'xmlrpc'   => { handler => 'MT::XMLRPCServer', },
            'atom'     => { handler => 'MT::AtomServer', },
            'feeds'    => { handler => 'MT::App::ActivityFeeds', },
            'view'     => { handler => 'MT::App::Viewer', },
            'notify'   => { handler => 'MT::App::NotifyList', },
            'tb'       => { handler => 'MT::App::Trackback', },
            'upgrade'  => { handler => 'MT::App::Upgrade', },
            'wizard'   => { handler => 'MT::App::Wizard', },
            'comments' => {
                            handler => 'MT::App::Comments',
                            tags    => sub { MT->app->load_core_tags },
            },
            'search' => {
                          handler => 'MT::App::Search::Legacy',
                          tags    => sub { MT->app->load_core_tags },
            },
            'new_search' => {
                handler => 'MT::App::Search',
                tags    => sub {
                    require MT::Template::Context::Search;
                    return MT::Template::Context::Search->load_core_tags();
                },
                methods => sub { MT->app->core_methods() },
                default => sub { MT->app->core_parameters() },
            },
            'cms' => {
                handler      => 'MT::App::CMS',
                cgi_base     => 'mt',
                page_actions => sub { MT->app->core_page_actions(@_) },
                list_actions => sub { MT->app->core_list_actions(@_) },
                list_filters => sub { MT->app->core_list_filters(@_) },
                search_apis  => sub {
                    require MT::CMS::Search;
                    return MT::CMS::Search::core_search_apis( MT->app, @_ );
                },
                menus           => sub { MT->app->core_menus() },
                methods         => sub { MT->app->core_methods() },
                widgets         => sub { MT->app->core_widgets() },
                blog_stats_tabs => sub { MT->app->core_blog_stats_tabs() },
                import_formats  => sub {
                    require MT::Import;
                    return MT::Import->core_import_formats();
                },
            },
        },
        archive_types => \&load_archive_types,
        tags          => \&load_core_tags,
        text_filters  => {
            '__default__' => {
                               label   => 'Convert Line Breaks',
                               handler => 'MT::Util::html_text_transform',
            },
            'richtext' => {
                label     => 'Rich Text',
                handler   => 'MT::Util::rich_text_transform',
                condition => sub {
                    my ($type)  = @_;
                    my $rte     = lc( MT->config('RichTextEditor') );
                    my $editors = MT->registry("richtext_editors");
                    return 0 unless $rte && $editors && $editors->{$rte};
                    return 1 if $type && ( $type ne 'comment' );
                },
            },
        },
        ping_servers => {
                          'weblogs' => {
                                         label => 'weblogs.com',
                                         url => 'http://rpc.weblogs.com/RPC2',
                          },
                          'google' => {
                              label => 'google.com',
                              url => 'http://blogsearch.google.com/ping/RPC2',
                          },
        },
        commenter_authenticators => \&load_core_commenter_auth,
        captcha_providers        => \&load_captcha_providers,
        tasks                    => \&load_core_tasks,
        default_templates        => \&load_default_templates,
        junk_filters             => \&load_junk_filters,
        task_workers             => {
                      'mt_rebuild' => {
                                        label => "Publishes content.",
                                        class => 'MT::Worker::Publish',
                      },
                      'mt_sync' => {
                          label => "Synchronizes content to other server(s).",
                          class => 'MT::Worker::Sync',
                      },
                      'mt_summarize' => {
                                       label => "Refreshes object summaries.",
                                       class => 'MT::Worker::Summarize',
                      },
                      'mt_summary_watcher' => {
                                  label => "Adds Summarize workers to queue.",
                                  class => 'MT::Worker::SummaryWatcher',
                      }
        },
        archivers => {
              'zip' => { class => 'MT::Util::Archive::Zip', label => 'zip', },
              'tgz' =>
                { class => 'MT::Util::Archive::Tgz', label => 'tar.gz', },
        },
        template_snippets => {
            'insert_entries' => {
                      trigger => 'entries',
                      label   => 'Entries List',
                      content =>
                        qq{<mt:Entries lastn="10">\n    \$0\n</mt:Entries>\n},
            },
            'blog_url' => {
                            trigger => 'blogurl',
                            label   => 'Blog URL',
                            content => '<$mt:BlogURL$>$0',
            },
            'blog_id' => {
                           trigger => 'blogid',
                           label   => 'Blog ID',
                           content => '<$mt:BlogID$>$0',
            },
            'blog_name' => {
                             trigger => 'blogname',
                             label   => 'Blog Name',
                             content => '<$mt:BlogName$>$0',
            },
            'entry_body' => {
                              trigger => 'entrybody',
                              label   => 'Entry Body',
                              content => '<$mt:EntryBody$>$0',
            },
            'entry_excerpt' => {
                                 trigger => 'entryexcerpt',
                                 label   => 'Entry Excerpt',
                                 content => '<$mt:EntryExcerpt$>$0',
            },
            'entry_link' => {
                              trigger => 'entrylink',
                              label   => 'Entry Link',
                              content => '<$mt:EntryLink$>$0',
            },
            'entry_more' => {
                              trigger => 'entrymore',
                              label   => 'Entry Extended Text',
                              content => '<$mt:EntryMore$>$0',
            },
            'entry_title' => {
                               trigger => 'entrytitle',
                               label   => 'Entry Title',
                               content => '<$mt:EntryTitle$>$0',
            },
            'if' => {
                  trigger => 'mtif',
                  label   => 'If Block',
                  content => qq{<mt:if name="variable">\n    \$0\n</mt:if>\n},
            },
            'if_else' => {
                trigger => 'mtife',
                label   => 'If/Else Block',
                content =>
                  qq{<mt:if name="variable">\n    \$0\n<mt:else>\n\n</mt:if>\n},
            },
            'include_module' => {
                                  trigger => 'module',
                                  label   => 'Include Template Module',
                                  content => '<$mt:Include module="$0"$>',
            },
            'include_file' => {
                                trigger => 'file',
                                label   => 'Include Template File',
                                content => '<$mt:Include file="$0"$>',
            },
            'getvar' => {
                          trigger => 'get',
                          label   => 'Get Variable',
                          content => '<$mt:var name="$0"$>',
            },
            'setvar' => {
                          trigger => 'set',
                          label   => 'Set Variable',
                          content => '<$mt:var name="$0" value="value"$>',
            },
            'setvarblock' => {
                trigger => 'setb',
                label   => 'Set Variable Block',
                content =>
                  qq{<mt:SetVarBlock name="variable">\n    \$0\n</mt:SetVarBlock>\n},
            },
            'widget_manager' => {
                                  trigger => 'widget',
                                  label   => 'Widget Set',
                                  content => '<$mt:WidgetSet name="$0"$>',
            },
        },
    };
} ## end BEGIN

sub id {
    return 'core';
}

sub load_junk_filters {
    require MT::JunkFilter;
    return MT::JunkFilter->core_filters;
}

sub load_core_tasks {
    my $cfg = MT->config;
    return {
        'FuturePost' => {
            label     => 'Publish Scheduled Entries',
            frequency => $cfg->FuturePostFrequency * 60,    # once per minute
            code      => sub {
                MT->instance->publisher->publish_future_posts;
              }
        },
        'AddSummaryWatcher' => {
            label     => 'Add Summary Watcher to queue',
            frequency => 2 * 60,                          # every other minute
            code      => sub {
                require MT::TheSchwartz;
                require TheSchwartz::Job;
                my $job = TheSchwartz::Job->new();
                $job->funcname('MT::Worker::SummaryWatcher');
                $job->uniqkey(1);
                $job->priority(4);
                MT::TheSchwartz->insert($job);
            },
        },
        'JunkExpiration' => {
            label => 'Junk Folder Expiration',
            frequency => 12 * 60 * 60,    # no more than every 12 hours
            code      => sub {
                require MT::JunkFilter;
                MT::JunkFilter->task_expire_junk;
            },
        },
        'CleanTemporaryFiles' => {
            label     => 'Remove Temporary Files',
            frequency => 60 * 60,                    # once per hour
            code      => sub {
                MT::Core->remove_temporary_files;
            },
        },
        'RemoveExpiredUserSessions' => {
            label     => 'Remove Expired User Sessions',
            frequency => 60 * 60 * 24,                     # once a day
            code      => sub {
                MT::Core->remove_expired_sessions;
            },
        },
        'RemoveExpiredSearchCaches' => {
            label     => 'Remove Expired Search Caches',
            frequency => 60 * 60 * 24,                     # once a day
            code      => sub {
                MT::Core->remove_expired_search_caches;
            },
        },
    };
} ## end sub load_core_tasks

sub remove_temporary_files {
    require MT::Session;

    my @files = MT::Session->load( {
                                      kind  => 'TF',
                                      start => [ undef, time - 60 * 60 ]
                                   },
                                   { range => { start => 1 } }
    );
    my $fmgr = MT::FileMgr->new('Local');
    foreach my $f (@files) {
        if ( $fmgr->delete( $f->name ) ) {
            $f->remove;
        }
    }

    # This is a silent task; no need to log removal of temporary files
    return '';
}

sub remove_expired_sessions {
    require MT::Session;

    my $expired = MT->config->UserSessionTimeout;
    MT::Session->remove( {
                            kind  => 'US',
                            start => [ undef, time - $expired ],
                            data  => { not_like => '%remember-%' }
                         },
                         { range => { start => 1 } }
    );
    return '';
}

sub remove_expired_search_caches {
    require MT::Session;

    MT::Session->remove( { kind => 'CS', start => [ undef, time - 60 * 60 ] },
                         { range => { start => 1 } } );
    return '';
}

sub load_default_templates {
    require MT::DefaultTemplates;
    return MT::DefaultTemplates->core_default_templates;
}

sub load_captcha_providers {
    return MT->core_captcha_providers;
}

sub load_core_commenter_auth {
    return MT->core_commenter_authenticators;
}

sub load_core_tags {
    require MT::Template::ContextHandlers;
    return MT::Template::Context::core_tags();
}

sub load_upgrade_fns {
    require MT::Upgrade;
    return MT::Upgrade->core_upgrade_functions;
}

sub load_backup_instructions {
    require MT::BackupRestore;
    return MT::BackupRestore::core_backup_instructions();
}

sub l10n_class {'MT::L10N'}

sub init_registry {
    my $c = shift;
    return $c->{registry} = $core_registry;
}

# Config handlers for these settings...

sub load_archive_types {
    require MT::WeblogPublisher;
    return MT::WeblogPublisher->core_archive_types;
}

sub PerformanceLoggingPath {
    my $cfg = shift;
    my ( $path, $default );
    return $cfg->set_internal( 'PerformanceLoggingPath', @_ ) if @_;

    unless ( $path = $cfg->get_internal('PerformanceLoggingPath') ) {
        $path = $default = File::Spec->catdir( MT->instance->static_file_path,
                                               'support', 'logs' );
    }

    # If the $path is not a writeable directory, we need to
    # do some work to see if we can create it
    if ( !( -d $path and -w $path ) ) {

        # Determine where MT should put its logging data.  It will be
        # the first existing and writeable directory found or created
        # between PerformanceLoggingPath configuration directive value
        # and the default fallback of MT_DIR/support/logs.  If neither
        # can be used, we return an undefined value and simply don't
        # log the performance stats.
        #
        # However, we do log any such errors in the activity log to
        # notify the user that there is a problem.

        my @dirs
          = ( $path, ( $default && $path ne $default ? ($default) : () ) );
        require File::Spec;
        foreach my $dir (@dirs) {
            my $msg = '';
            if ( -d $dir and -w $dir ) {
                $path = $dir;
            }
            elsif ( !-e $dir ) {
                require File::Path;
                eval { File::Path::mkpath( [$dir], 0, 0777 ); $path = $dir; };
                if ($@) {
                    $msg =
                      MT->translate(
                        'Error creating performance logs directory, [_1]. Please either change the permissions to make it writable or specify an alternate using the PerformanceLoggingPath configuration directive: [_2]',
                        $dir, $@
                      );
                }
            }
            elsif ( -e $dir and !-d $dir ) {
                $msg = MT->translate(
                    'Error creating performance logs: PerformanceLoggingPath setting must be a directory path, not a file: [_1]',
                    $dir
                );
            }
            elsif ( -e $dir and !-w $dir ) {
                $msg = MT->translate(
                    'Error creating performance logs: PerformanceLoggingPath directory exists but is not writeable: [_1]',
                    $dir
                );
            }

            if ($msg) {

                # Issue MT log within an eval block in the
                # event that the plugin error is happening before
                # the database has been initialized...
                require MT::Log;
                MT->log( {
                           message => $msg,
                           class   => 'system',
                           level   => MT::Log::ERROR()
                         }
                );
            }
            last if $path;
        } ## end foreach my $dir (@dirs)
    } ## end if ( !( -d $path and -w...))
    return $path;
} ## end sub PerformanceLoggingPath

sub ProcessMemoryCommand {
    my $cfg = shift;
    $cfg->set_internal( 'ProcessMemoryCommand', @_ ) if @_;
    my $cmd = $cfg->get_internal('ProcessMemoryCommand');
    unless ($cmd) {
        my $os = $^O;
        if ( $os eq 'darwin' ) {
            $cmd = 'ps $$ -o rss=';
        }
        elsif ( $os eq 'linux' ) {
            $cmd = 'ps -p $$ -o rss=';
        }
        elsif ( $os eq 'MSWin32' ) {
            $cmd = {
                     command => q{tasklist /FI "PID eq $$" /FO TABLE /NH},
                     regex   => qr/([\d,]+) K/
            };
        }
    }
    return $cmd;
} ## end sub ProcessMemoryCommand

sub SecretToken {
    my $cfg = shift;
    $cfg->set_internal( 'SecretToken', @_ ) if @_;
    my $secret = $cfg->get_internal('SecretToken');
    unless ($secret) {
        my @alpha = ( 'a' .. 'z', 'A' .. 'Z', 0 .. 9 );
        $secret = join '', map $alpha[ rand @alpha ], 1 .. 40;
        $secret = $cfg->set_internal( 'SecretToken', $secret, 1 );
        $cfg->save_config();
    }
    return $secret;
}

sub DefaultUserTagDelimiter {
    my $mgr = shift;
    return $mgr->set_internal( 'DefaultUserTagDelimiter', @_ ) if @_;
    my $delim = $mgr->get_internal('DefaultUserTagDelimiter');
    if ( lc $delim eq 'comma' ) {
        return ord(',');
    }
    elsif ( lc $delim eq 'space' ) {
        return ord(' ');
    }
    else {
        return ord(',');
    }
}

sub JQueryURL {
    my $mgr = shift;
    return $mgr->set_internal( 'JQueryURL', @_ ) if @_;
    require MT::Util;
    my $url = $mgr->get_internal('JQueryURL');
    if ( !$url ) {
        $url = MT::Util::caturl( MT->instance->static_path(),
                                 'jquery', 'jquery.js' );
    }
    elsif ( $url !~ m{^http://}i and substr( $url, 0, 1 ) ne '/' ) {
        $url = MT::Util::caturl( MT->instance->static_path(), $url );
    }
    return $url;
}

sub NewUserAutoProvisioning {
    my $mgr = shift;
    return $mgr->set_internal( 'NewUserAutoProvisioning', @_ ) if @_;
    return 0 unless $mgr->DefaultSiteRoot && $mgr->DefaultSiteURL;
    $mgr->get_internal('NewUserAutoProvisioning');
}

sub UserSessionCookieName {
    my $mgr = shift;
    return $mgr->set_internal( 'UserSessionCookieName', @_ ) if @_;
    my $name = $mgr->get_internal('UserSessionCookieName');
    return $name if defined $name;
    if ( $mgr->get_internal('SingleCommunity') ) {
        return 'mt_blog_user';
    }
    else {
        return 'mt_blog%b_user';
    }
}

sub UserSessionCookiePath {
    my $mgr = shift;
    return $mgr->set_internal( 'UserSessionCookiePath', @_ ) if @_;
    my $path = $mgr->get_internal('UserSessionCookiePath');
    return $path if defined $path;
    if ( $mgr->get_internal('SingleCommunity') ) {
        return '/';
    }
    else {
        return '<$MTBlogRelativeURL$>';
    }
}

1;
__END__

=head1 NAME

MT::Core - Core component for Movable Type functionality.

=head1 METHODS

=head2 MT::Core::trans($phrase)

Stub method that returns the phrase it is given.

=head2 MT::Core->name()

Returns a string identifying this component.

=head2 MT::Core->id()

Returns the identifier for this component.

=head2 MT::Core::load_junk_filters()

Routine that returns the core junk filter registry elements (these
live in the L<MT::JunkFilter> package).

=head2 MT::Core::load_core_tasks()

Routine that returns the core L<MT::TaskMgr> registry elements.

=head2 MT::Core->remove_temporary_files()

Utility method for removing any temporary files that MT generates.

=head2 MT::Core->remove_expired_sessions()

Utility method for clearing expired MT user session records.

=head2 MT::Core->remove_expired_search_caches()

Utility method for removing expired search cache records.

=head2 MT::Core::load_default_templates()

Routine that returns the default template set registry elements.

=head2 MT::Core::load_captcha_providers()

Routine that returns the CAPTCHA provider registry elements.

=head2 MT::Core::load_core_commenter_auth()

Routine that returns the core registry elements for commenter
authentication methods.

=head2 MT::Core::load_core_tags()

Routine that returns the core registry elements for the MT
template tags are enabled for the entire system (excludes
application-specific tags).

=head2 MT::Core::load_upgrade_fns()

Routine that returns the core registry elements for the MT
schema upgrade framework.

=head2 MT::Core::load_backup_instructions

Routine that returns the core registry elements for the MT
Backup/Restore framework.

=head2 MT::Core->l10n_class

Returns the localization package for the core component.

=head2 $core->init_registry()

=head2 MT::Core::load_archive_types()

Routine that returns the core registry elements for the
publishable archive types. See L<MT::ArchiveType>.

=head2 MT::Core::PerformanceLoggingPath

A L<MT::ConfigMgr> get/set method for the C<PerformanceLoggingPath>
configuration setting. If the user has not designated a path, this
will return a default location, which is programatically determined.

=head2 MT::Core::ProcessMemoryCommand

A L<MT::ConfigMgr> get/set method for the C<ProcessMemoryCommand>
configuration setting. If the user has not assigned this themselves,
it will return a default command, determined by the operating system
Movable Type is running on.

=head2 MT::Core::SecretToken

A L<MT::ConfigMgr> get/set method for the C<SecretToken>
configuration setting. If the user has not assigned this themselves,
it will return a random token value, and save it to the database for
future use.

=head2 MT::Core::DefaultUserTagDelimiter

A L<MT::ConfigMgr> get/set method for the C<DefaultUserTagDelimiter>
configuration setting. Translates the keyword values 'comma' and
'space' to the ASCII code for those characters.

=head2 MT::Core::NewUserAutoProvisioning

A L<MT::ConfigMgr> get/set method for the C<NewUserAutoProvisioning>
configuration setting. Even if the user has enabled this setting,
it will force a value of '0' unless the C<DefaultSiteRoot> and
C<DefaultSiteURL> configuration settings are also assigned.

=head2 MT::Core::UserSessionCookieName

A L<MT::ConfigMgr> get/set method for the C<UserSessionCookieName>
configuration setting. If the user has not specifically assigned
this setting, a default value is returned, affected by the
C<SingleCommunity> setting. If C<SingleCommunity> is enabled, it
returns a cookie name that is the same for all blogs. If it is
off, it returns a cookie name that is blog-specific (contains the
blog id in the cookie name).

=head2 UserSessionCookiePath

A L<MT::ConfigMgr> get/set method for the C<UserSessionCookiePath>
configuration setting. If the user has not specifically assigned
this setting, a default value is returned, affected by the
C<SingleCommunity> setting. If C<SingleCommunity> is enabled, it
returns a path that is the same for all blogs ('/'). If it is
off, it returns a value that will yield the blog's relative
URL path.

=head1 LICENSE

The license that applies is the one you agreed to when downloading
Movable Type.

=head1 AUTHOR & COPYRIGHT

Please see the I<MT> manpage for author, copyright, and license information.

=cut
