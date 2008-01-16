# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
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
        die MT->translate('Uploaded file was not a valid Movable Type backup manifest file.')
            if !(('movabletype' eq $name) && (MT::BackupRestore::NS_MOVABLETYPE() eq $ns));
        unless ($self->{ignore_schema_conflicts}) {
            my $schema = $attrs->{'{}schema_version'}->{Value};
            if (('ignore' ne $self->{schema_version}) && ($schema > $self->{schema_version})) {
                $self->{critical} = 1;
                my $message = MT->translate('Uploaded file was backed up from Movable Type with the newer schema version ([_1]) than the one in this system ([_2]).  It is not safe to restore the file to this version of Movable Type.', MT::I18N::encode_text(MT::I18N::utf8_off($schema), 'utf-8'), $self->{schema_version});
                MT->log({ 
                    message => $message,
                    level => MT::Log::ERROR(),
                    class => 'system',
                    category => 'restore',
                });
                die $message;
            }
        }
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
            my $class = MT->model($name);
            unless ($class) {
                push @{$self->{errors}}, MT->translate('[_1] is not a subject to be restored by Movable Type.', $name);
            } else {
                if ($self->{current_class} ne $class) {
                    if (my $c = $self->{current_class}) {
                        my $state = $self->{state};
                        my $records = $self->{records};
                        $callback->($state . " " . MT->translate("[_1] records restored.", $records), $c->class_type || $c->datasource);
                    }
                    $self->{records} = 0;
                    $self->{current_class} = $class;
                    my $state = MT->translate('Restoring [_1] records:', $class);
                    $callback->($state, $name);
                    $self->{state} = $state;
                }
                my %column_data = map { $attrs->{$_}->{LocalName} => 
                        MT::I18N::encode_text(MT::I18N::utf8_off($attrs->{$_}->{Value}), 'utf-8')
                    } keys(%$attrs);
                my $obj;
                if ( 'author' eq $name ) {
                    $obj = $class->load({ name => $column_data{name} });
                    if ($obj) {
                        if ( $obj->id == MT->instance->user->id ) {
                            MT->log({ message => MT->translate(
                                "User with the same name as the name of the currently logged in ([_1]) found.  Skipped the record.", $obj->name),
                                level => MT::Log::INFO(),
                                metadata => 'Permissions and Associations have been restored.',
                                class => 'system',
                                category => 'restore',
                            });
                            $objects->{"$class#" . $column_data{id}} = $obj;
                            $self->{skip} += 1;
                        }
                        else {
                            $self->{callback}->("\n");
                            MT->log({ message => MT->translate(
                                "User with the same name '[_1]' found (ID:[_2]).  Restore replaced this user with the data backed up.",
                                                  $obj->name, $obj->id),
                                level => MT::Log::INFO(),
                                metadata => 'Permissions and Associations have been restored as well.',
                                class => 'system',
                                category => 'restore',
                            });
                            my $old_id = delete $column_data{id};
                            $objects->{"$class#$old_id"} = $obj;
                            my $child_classes = $obj->properties->{child_classes} || {};
                            for my $class (keys %$child_classes) {
                                eval "use $class;";
                                $class->remove({ author_id => $obj->id, blog_id => '0' });
                            }
                            my $success = $obj->restore_parent_ids(\%column_data, $objects);
                            if ($success) {
                                $obj->set_values(\%column_data);
                                $self->{current} = $obj;
                            } else {
                                $deferred->{$class . '#' . $column_data{id}} = 1;
                                $self->{deferred} = $deferred;
                                $self->{skip} += 1;
                            }
                            $self->{loaded} = 1;
                        }
                    }
                } elsif ('template' eq $name) {
                    if (!$column_data{blog_id}) {
                        $obj = $class->load({ blog_id => 0, identifier => $column_data{identifier} });
                        if ($obj) {
                            my $old_id = delete $column_data{id};
                            $objects->{"$class#$old_id"} = $obj;
                            if ($self->{overwrite_template}) {
                                $obj->set_values(\%column_data);
                                $self->{current} = $obj;
                            } else {
                                $self->{skip} += 1;
                            }
                            $self->{loaded} = 1;
                        }
                    }
                }
                unless ($obj) {
                    $obj = $class->new;
                }
                unless ($obj->id) {
                    my $success = $obj->restore_parent_ids(\%column_data, $objects);
                    if ($success) {
                        $obj->set_values(\%column_data);
                        $self->{current} = $obj;
                    } else {
                        $deferred->{$class . '#' . $column_data{id}} = 1;
                        $self->{deferred} = $deferred;
                        $self->{skip} += 1;
                    }
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
    if (my $text_data = $self->{current_text}) {
        push @$text_data, MT::I18N::utf8_off($data->{Data});
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

    my $name = $data->{LocalName};
    my $class = MT->model($name);

    if (my $obj = $self->{current}) {
        if (my $text_data = delete $self->{current_text}) {
            my $column_name = shift @$text_data;
            my $text;
            $text .= $_ foreach @$text_data;
            
            my $defs = $obj->column_defs;
            if ('blob' eq $defs->{$column_name}->{type}) {
                require MIME::Base64;
                $obj->column($column_name, MIME::Base64::decode_base64($text));
            } else {
                $text = MT::I18N::encode_text($text, 'utf-8');
                $obj->column($column_name, $text);
            }
        } else {
            my $old_id = $obj->id;
            unless ((('author' eq $name) || ('template' eq $name)) && (exists $self->{loaded})) {
                delete $obj->{column_values}->{id};
                delete $obj->{changed_cols}->{id};
            } else {
                delete $self->{loaded};
            }
            my $exists = 0;
            if ('tag' eq $name) {
                if (my $tag = MT::Tag->load({ name => $obj->name }, { binary => { name => 1 } } )) {
                    $exists = 1;
                    $self->{objects}->{"$class#$old_id"} = $tag;
                    $self->{callback}->("\n");
                    $self->{callback}->(
                        MT->translate("Tag '[_1]' exists in the system.",
                            $obj->name)
                    );
                }
            } elsif ('trackback' eq $name) {
                my $term;
                my $message;
                if ($obj->entry_id) {
                    $term = { entry_id => $obj->entry_id };
                } elsif ($obj->category_id) {
                    $term = { category_id => $obj->category_id };
                }
                if (my $tb = $class->load($term)) {
                    $exists = 1;
                    my $changed = 0;
                    if ($obj->passphrase) {
                        $tb->passphrase($obj->passphrase);
                        $changed = 1;
                    }
                    if ($obj->is_disabled) {
                        $tb->is_disabled($obj->is_disabled);
                        $changed = 1;
                    }
                    $tb->save if $changed;
                    $self->{objects}->{"$class#$old_id"} = $tb;
                    my $records = $self->{records};
                    $self->{callback}->($self->{state} . " " . MT->translate("[_1] records restored...", $records), $data->{LocalName})
                        if $records && ($records % 10 == 0);
                    $self->{records} = $records + 1;
                }
            }
            elsif ('permission' eq $name) {
                my $perm = $class->count( {
                    author_id => $obj->author_id,
                    blog_id   => $obj->blog_id
                });
                $exists = 1 if $perm;
            }
            unless ($exists) {
                my $result;
                if ( $obj->id ) {
                    $result = $obj->update();
                }
                else {
                    $result = $obj->insert();
                }
                if ( $result ) {
                    if ($class =~ /MT::Asset(::.+)*/) {
                        $class = 'MT::Asset';
                    }
                    $self->{objects}->{"$class#$old_id"} = $obj;
                    my $records = $self->{records};
                    $self->{callback}->($self->{state} . " " . MT->translate("[_1] records restored...", $records), $data->{LocalName})
                        if $records && ($records % 10 == 0);
                    $self->{records} = $records + 1;
                } else {
                    push @{$self->{errors}}, $obj->errstr;
                    $self->{callback}->($obj->errstr);
                }
            }
            delete $self->{current};
        }
    }
}

sub end_document {
    my $self = shift;
    my $data = shift;

    if (my $c = $self->{current_class}) {
        my $state = $self->{state};
        my $records = $self->{records};
        $self->{callback}->($state . " " . MT->translate("[_1] records restored.", $records), $c->class_type || $c->datasource);
    }

    1;
}

1;
