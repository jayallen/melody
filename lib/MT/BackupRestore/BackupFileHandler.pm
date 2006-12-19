# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::BackupRestore::BackupFileHandler;

use strict;
use XML::SAX::Base;

@MT::BackupRestore::BackupFileHandler::ISA = qw(XML::SAX::Base);

sub new {
    my $class = shift;
    my (%param) = @_;
    my $self = bless \%param, $class;
    return $self;
}

my %obj_to_restore = (
    'tag' => 'MT::Tag',
    'author' => 'MT::Author',
    'blog' => 'MT::Blog',
    'notification' => 'MT::Notification',
    'fileinfo' => 'MT::FileInfo',
    'template' => 'MT::Template',
    'templatemap' => 'MT::TemplateMap',
    'role' => 'MT::Role',
    'association' => 'MT::Association',
    'permission' => 'MT::Permission',
    'category' => 'MT::Category',
    'placement' => 'MT::Placement',
    'asset' => 'MT::Asset',
    'entry' => 'MT::Entry',
    'objecttag' => 'MT::ObjectTag',
    'trackback' => 'MT::Trackback',
    'tbping' => 'MT::TBPing',
    'comment' => 'MT::Comment',
);

sub start_document {
    my $self = shift;
    my $data = shift;

    $self->{start} = 1;

    1;
}

sub start_element {
    my $self = shift;
    my $data = shift;

    return if $self->{skip};

    my $name = $data->{LocalName};
    my $attrs = $data->{Attributes};
    my $ns = $data->{NamespaceURI};

    if ($self->{start}) {
        die MT->translate("Uploaded file was not a valid Movable Type backup manifest file.")
            if !(('movabletype' eq $name) && (MT::BackupRestore::NS_MOVABLETYPE() eq $ns));
        $self->{start} = 0;
        return 1;
    }

    my $objects = $self->{objects};
    my $deferred = $self->{deferred};
    my $callback = $self->{callback};

    if (my $current = $self->{current}) {
        # this is an element for a text column of the object
        $self->{current_text} = [ $name ];
    } else {
        if (MT::BackupRestore::NS_MOVABLETYPE() eq $ns) {
            if (!exists($obj_to_restore{$name})) {
                push @{$self->{errors}}, MT->translate('[_1] is not a subject to be restored by Movable Type.', $name);
            } else {
                my $class = $obj_to_restore{$name};
                eval "require $class";
                if (my $e = $@) {
                    push @{$self->{errors}}, $e;
                    return;
                }

                my $obj = $class->new;
                my %column_data = map { $attrs->{$_}->{LocalName} => $attrs->{$_}->{Value} } keys(%$attrs);
                $obj->set_values(\%column_data);
                $callback->(MT->translate("Restoring [_1]...\n", $class));
                my $success = $obj->restore_parent_ids(\%column_data, $objects);
                if ($success) {
                    $self->{current} = $obj;
                } else {
                    $callback->(MT->translate("Restoring [_1] (ID: [_2]) was deferred because its parents objects have not been restored yet.\n", $class, $column_data{id}));
                    $deferred->{$class . '#' . $column_data{id}} = 1;
                    $self->{deferred} = $deferred;
                    $self->{skip} += 1;
                }
            }
        } else {
            my $obj = MT->run_callbacks("Restore.$name:$ns", $data, $objects, $deferred, $callback);
            $self->{current} = $obj if defined($obj) && ('1' ne $obj);
        }
    }
    1;
}

sub characters {
    my $self = shift;
    my $data = shift;

    return if $self->{skip};
    return if !exists($self->{current});
use Data::Dumper;
    if (my $text_data = $self->{current_text}) {
        push @$text_data, $data->{Data};
        $self->{current_text} = $text_data;
    }
    1;
}

sub end_element {
    my $self = shift;
    my $data = shift;

    if ($self->{skip}) {
        $self->{skip} -= 1;
        return;
    }

    if (my $obj = $self->{current}) {
        if (my $text_data = $self->{current_text}) {
            my $column_name = shift @{$self->{current_text}};
            my $text;
            $text .= $_ foreach @{$self->{current_text}};
            $obj->column($column_name, $text);
            delete $self->{current_text};
        } else {
            my $old_id = $obj->id;
            $obj->id(0);
            if ($obj->save()) {
                delete $self->{current};
                my $objects = $self->{objects};
                my $deferred = $self->{deferred};
                my $key = ref($obj) . "#$old_id";
                $objects->{$key} = $obj;
                $self->{objects} = $objects;
                $self->{callback}->(
                    MT->translate("[_1] [_2] (ID: [_3]) has been restored successfully with new ID: [_4]\n",
                        $data->{LocalName} =~ m/^[aeiou]/i ? 'An' : 'A',
                        $data->{LocalName},
                        $old_id,
                        $obj->id)
                );
            } else {
                push @{$self->{errors}}, $obj->errstr;
            }
        }
    }
}

1;
