# Copyright 2001-2007 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::BackupRestore;
use strict;

use Symbol;
use MT::ErrorHandler;
@MT::BackupRestore::ISA = qw( MT::ErrorHandler );

use constant NS_MOVABLETYPE => 'http://www.sixapart.com/ns/movabletype';

use File::Spec;
use File::Copy;

sub backup {
    my $class = shift;
    my ($blog_ids, $printer, $splitter, $finisher, $size, $enc) = @_;
    my $obj_to_backup = [];

    if (defined($blog_ids) && scalar(@$blog_ids)) {
        push @$obj_to_backup, {'MT::Tag' => {
            term => undef, 
            args => { 'join' =>
                [ 'MT::ObjectTag', 'tag_id', { blog_id => $blog_ids }, undef ]
            }}};
        push @$obj_to_backup, {'MT::Author' => {
            term => undef, 
            args => { 'join' => 
                [ 'MT::Association', 'author_id', { blog_id => $blog_ids }, undef ]
            }}};
        ## Author has two different ways to associate to a weblog...
        push @$obj_to_backup, {'MT::Author' => {
            term => undef, 
            args => { 'join' => 
                [ 'MT::Permission', 'author_id', { blog_id => $blog_ids }, undef ]
            }}};
        push @$obj_to_backup, {'MT::Blog' => { 
            term => { 'id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Notification' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Template' => { 
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::TemplateMap' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Role' => {
            term => undef,
            args => { 'join' => 
                [ 'MT::Association', 'role_id', { blog_id => $blog_ids }, undef ]
            }}};
        push @$obj_to_backup, {'MT::Association' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Permission' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Category' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Asset' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Entry' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::FileInfo' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::ObjectTag' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Placement' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Trackback' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::TBPing' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::Comment' => {
            term => { 'blog_id' => $blog_ids }, 
            args => undef
            }};
        push @$obj_to_backup, {'MT::PluginData' => { term => undef, args => undef }};
    } else {
        push @$obj_to_backup, {'MT::Tag' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Author' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Blog' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Notification' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Template' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::TemplateMap' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Role' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Association' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Permission' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Category' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Asset' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Entry' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::FileInfo' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::ObjectTag' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Placement' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Trackback' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::TBPing' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Comment' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::PluginData' => { term => undef, args => undef }};
        $blog_ids = [];
    }

    my $header .= "<movabletype xmlns='" . NS_MOVABLETYPE . "'>\n";
    $header = "<?xml version='1.0' encoding='$enc'?>\n$header" if $enc !~ m/utf-?8/i;
    $printer->($header, q());

    my $files = {};
    _loop_through_objects(
        $printer, $splitter, $finisher, $size, $obj_to_backup, $files);

    my $else_xml = MT->run_callbacks('Backup', $blog_ids);
    $printer->($else_xml, q()) if $else_xml ne '1';

    $printer->('</movabletype>', q());
    $finisher->($files);
}

sub _loop_through_objects {
    my ($printer, $splitter, $finisher, $size, $obj_to_backup, $files) = @_;

    my $counter = 1;
    my $bytes = 0;
    my %author_ids_seen;
    for my $class_hash (@$obj_to_backup) {
        my ($class, $term_arg) = each(%$class_hash);
        eval "require $class;";
        my $children = $class->children_names || {};
        for my $child_class (values %$children) {
            eval "require $child_class;";
        }
        my $err = $@;
        if ($err) {
            $printer->("$err\n", "$err\n");
            next;
        }
        my $offset = 0;
        my $term = $term_arg->{term} || {};
        my $args = $term_arg->{args};
        while (1) {
            $args->{offset} = $offset;
            $args->{limit} = 50;
            my @objects = $class->load($term, $args);
            last unless @objects;
            $offset += scalar @objects;
            for my $object (@objects) {
                next if ($class eq 'MT::Author') && exists($author_ids_seen{$object->id});
                $bytes += $printer->($object->to_xml(undef, $args) . "\n", 
                    MT->translate('[_1]#[_2] has been backed up.', $class, $object->id) . "\n")
                        if $object->to_backup;
                if ($size && ($bytes >= $size)) {
                    $splitter->(++$counter);
                    $bytes = 0;
                }
                if ($class eq 'MT::Author') {
                    # MT::Author may be duplicated because of how terms and args are created.
                    $author_ids_seen{$object->id} = 1;
                } elsif ($class eq 'MT::Asset') {
                    $files->{$object->id} = [$object->url, $object->file_path, $object->file_name];
                }
            }
        }
    }
}

sub restore_file {
    my $class = shift;
    my ($fh, $errormsg, $callback) = @_;

    my $objects = {};
    my $deferred = {};
    my $errors = [];

    $class->restore_process_single_file(
        $fh, $objects, $deferred, $errors, $callback
    );
    $$errormsg = join('; ', @$errors);
    $deferred;
}
 
sub restore_process_single_file {
    my $class = shift;
    my ($fh, $objects, $deferred, $errors, $callback) = @_;

    require XML::SAX;
    require MT::BackupRestore::BackupFileHandler;
    my $handler = MT::BackupRestore::BackupFileHandler->new(
        callback => $callback,
        objects => $objects,
        deferred => $deferred,
        errors => $errors,
    );

    my $parser = XML::SAX::ParserFactory->parser(
        Handler => $handler,
    );
    my $e;
    eval { $parser->parse_file($fh); };
    $e = $@ if $@;
    if ($e) {
        push @$errors, $e;
        $callback->($e);
    }
    1;
}

sub restore_directory {
    my $class = shift;
    my ($dir, $errors, $error_assets, $callback) = @_;

    my $manifest;
    my @files;
    opendir my $dh, $dir or push(@$errors, MT->translate("Can't open directory '[_1]': [_2]", $dir, "$!")), return undef;
    for my $f (readdir $dh) {
        next if $f !~ /^.+\.manifest$/i;
        $manifest = File::Spec->catfile($dir, $f);
        last;
    }
    closedir $dh;
    unless ($manifest) {
        push @$errors, MT->translate("No manifest file could be found in your import directory [_1].", $dir);
        return undef;
    }

    my $fh = gensym;
    open $fh, "<$manifest" or push(@$errors, MT->translate("Can't open [_1].", $manifest)), return 0;
    my $backups = __PACKAGE__->process_manifest($fh);
    close $fh;
    unless($backups) {
        push @$errors, MT->translate("Manifest file [_1] was not a valid Movable Type backup manifest file.", $manifest);
        return undef;
    }

    $callback->(MT->translate("Manifest file: [_1]\n", $manifest));

    my %objects;
    my $deferred = {};

    my $files = $backups->{files};
    for my $file (@$files) {
        my $fh = gensym;
        my $filepath = File::Spec->catfile($dir, $file);
        open $fh, "<$filepath" or push @$errors, MT->translate("Can't open [_1]."), next;

        my $result = __PACKAGE__->restore_process_single_file(
            $fh, \%objects, $deferred, $errors, $callback);

        close $fh;
    }
    
     _restore_assets($dir, $backups, \%objects, $error_assets, $callback) if defined($backups->{assets});
    $deferred;
}

sub process_manifest {
    my $class = shift;
    my ($stream) = @_;

    if ((ref($stream) eq 'Fh') || (ref($stream) eq 'GLOB')){
        seek($stream, 0, 0) or return undef;
        require XML::SAX;
        require MT::BackupRestore::ManifestFileHandler;
        my $handler = MT::BackupRestore::ManifestFileHandler->new();

        my $parser = XML::SAX::ParserFactory->parser(
            Handler => $handler,
        );
        eval { $parser->parse_file($stream); };
        if (my $e = $@) {
            die $e;
        }
        return $handler->{backups};
    }
    return undef;
}

sub restore_asset {
    my $class = shift;
    my ($tmp, $asset_element, $objects, $errors, $callback) = @_;

    my $id = $asset_element->{asset_id};
    if (!defined($id)) {
        $callback->(MT->translate('ID for the asset was not set.'));
        return 0;
    }
    my $asset = $objects->{"MT::Asset#$id"};
    unless (defined($asset)) {
        $callback->(MT->translate('The asset ([_1]) was not restored.', $id));
        return 0;
    }
    my $path = $asset->file_path;
    unless (defined($path)) {
        $callback->(MT->translate('Path was not found for the asset ([_1]).', $id));
        return 0;
    }
    my ($vol, $dir, $fn) = File::Spec->splitpath($path);
    if (!-w "$vol$dir") {
        my $voldir =  "$vol$dir";
        # we do need utf8_off here
        $errors->{$id} = MT->translate('[_1] is not writable.', MT::I18N::utf8_off($voldir));
    } else {
        my $filename = "$id-" . $asset_element->{name};
        $callback->(MT->translate("Copying [_1] to [_2]...", $filename, $path));
        my $file;
        if (defined($tmp)) {
            $file = File::Spec->catfile($tmp, $filename) if defined($tmp);
        } else {
            $file = $asset_element->{fh};
        }
        copy($file, $path)
            or $errors->{$id} = $!;
    }
    $callback->(exists($errors->{$id}) ?
        MT->translate('Failed: ') . $errors->{$id} :
        MT->translate("Done.")
    );
    $callback->("\n");
}

sub _restore_assets {
    my ($tmp, $backups, $objects, $errors, $callback) = @_;
    my $assets = $backups->{assets};
    return 0 if !defined($assets);
    use File::Copy;
    require File::Spec;
    for my $asset_element (@$assets) {
        __PACKAGE__->restore_asset($tmp, $asset_element, $objects, $errors, $callback);
    }
    1;
}

package MT::Object;

sub _is_element {
    my $obj = shift;
    my ($def) = @_;
    return (('text' eq $def->{type}) || (('string' eq $def->{type}) && (255 < $def->{size}))) ? 1 : 0;
}

sub to_backup { 1; }

sub children_to_xml {
    my $obj = shift;
    my ($namespace, $args) = @_;

    my $t = {};
    if (defined($args)) {
        my $j = $args->{'join'};
        $t = $j->[2] if defined($j);
    }

    my $children = $obj->children_names;
    my @children_classes = values %$children;
    my $xml = '';

    for my $child_class (@children_classes) {
        eval "require $child_class";
        my $err = $@;
        return $err if defined($err) && $err;

        my $terms = { 
            $obj->datasource . '_id' => $obj->id,
            %$t,
        };
        
        my $offset = 0;
        while (1) {
            my @objects = $child_class->load(
                $terms,
                { offset => $offset, limit => 50, }
            );
            last unless @objects;
            $offset += scalar @objects;
            for my $object (@objects) {
                $xml .= $object->to_xml($namespace) . "\n" if $object->to_backup;
            }
        }
    }
    $xml;
}

sub to_xml {
    my $obj = shift;
    my ($namespace, $args) = @_;

    my $coldefs = $obj->column_defs;
    my $colnames = $obj->column_names;
    my $xml;

    $xml = '<' . $obj->datasource;
    $xml .= " xmlns='$namespace'" if defined($namespace) && $namespace;

    my @elements;
    for my $name (@$colnames) {
        if ($obj->column($name) || (defined($obj->column($name)) && ('0' eq $obj->column($name)))) {
            if ($obj->_is_element($coldefs->{$name})) {
                push @elements, $name;
                next;
            }
            $xml .= " $name='" . MT::Util::encode_xml($obj->column($name), 1) . "'";
        }
    }
    $xml .= '>';
    $xml .= "<$_>" . MT::Util::encode_xml($obj->column($_), 1) . "</$_>" foreach @elements;
    $xml .= '</' . $obj->datasource . '>';
    $xml;
}

sub children_names {
    my $obj = shift;
    {};
}

sub parent_names {
    my $obj = shift;
    {};
}

sub restore_parent_ids {
    my $obj = shift;
    my ($data, $objects) = @_;

    my $parent_names = $obj->parent_names;

    my $done = 0;
    for my $parent_element_name (keys %$parent_names) {
        if (!exists($data->{$parent_element_name . '_id'})) {
            $done++;
            next;
        }
        my $parent_class_name = $parent_names->{$parent_element_name};
        my $old_id = $data->{$parent_element_name . '_id'};
        my $new_obj = $objects->{"$parent_class_name#$old_id"};
        next if !(defined($new_obj) && $new_obj);
        $data->{$parent_element_name . '_id'} = $new_obj->id;
        $done++;
    }
    (scalar(keys(%$parent_names)) == $done) ? 1 : 0;   
}

package MT::Asset;

sub children_to_xml {
    my $obj = shift;
    my ($namespace, $args) = @_;
    my $xml = '';

    require MT::ObjectTag;
    my $offset = 0;
    while (1) {
        my @objecttags = MT::ObjectTag->load(
            { object_id => $obj->id, object_datasource => $obj->datasource },
            { offset => $offset, limit => 50, }
        );
        last unless @objecttags;
        $offset += scalar @objecttags;
        for my $objecttag (@objecttags) {
            $xml .= $objecttag->to_xml($namespace, $args) . "\n" if $objecttag->to_backup;
        }
    }
    
    $xml;
}

sub children_names {
    my $obj = shift;
    my $children = {
        objecttag => 'MT::ObjectTag',
    };
    $children;
}

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
    };
    $parents;
}

package MT::Association;

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
        author => 'MT::Author',
        role => 'MT::Role',
    };
    $parents;
}

package MT::Author;

sub children_names {
    my $obj = shift;
    my $children = {
        permission => 'MT::Permission',
        association => 'MT::Association',
        #entry => 'MT::Entry',       ## An author is a parent of a category/entry
        #category => 'MT::Category', ## but a category/entry is not a child of an author
                                     ## otherwise they duplicate in restore operation.
                                     ## Also, <author> must come before <category> and
                                     ## <entry> in the backup file.
    };
    $children;
}

package MT::Blog;

sub children_names {
    my $obj = shift;
    my $children = {
        placement => 'MT::Placement',
        permission => 'MT::Permission',
        notification => 'MT::Notification',
        association => 'MT::Association',
    	fileinfo => 'MT::FileInfo',
        #template => 'MT::Template',
        #entry => 'MT::Entry',  ## A blog is a parent of an entry/a template but 
				## they are not a child of a blog
                                ## otherwise they duplicate in restore operation.
                                ## Also, <blog> must come before <entry> and <template>.
    };
    $children;
}

package MT::Category;

#sub to_backup {
#    $_[0]->parent ? 0 : 1;
#}

sub children_to_xml {
    my $obj = shift;
    my ($namespace, $args) = @_;
    my $xml = '';

    #require MT::Trackback;
    #my $tb = MT::Trackback->load({ category_id => $obj->id });
    #if ($tb) {
    #    require MT::TBPing;
    #    my $offset = 0;
    #    while (1) {
    #        my @pings = MT::TBPing->load(
    #            { tb_id => $tb->id, },
    #            { offset => $offset, limit => 50, }
    #        );
    #        last unless @pings;
    #        $offset += scalar @pings;
    #        for my $ping (@pings) {
    #            $xml .= $ping->to_xml($namespace, $args) . "\n" if $ping->to_backup;
    #        }
    #    }
    #}

    my $offset = 0;
    while (1) {
        my @placements = MT::Placement->load(
            { 'category_id' => $obj->id, },
            { offset => $offset, limit => 50, }
        );
        last unless @placements;
        $offset += scalar @placements;
        for my $placement (@placements) {
            $xml .= $placement->to_xml($namespace, $args) . "\n" if $placement->to_backup;
        }
    }

    my @children = $obj->children_categories;
    return $xml unless @children;
    for my $child (@children) {
        $xml .= $child->to_xml($namespace, $args) . "\n";
    }
    $xml;
}

sub children_names {
    my $obj = shift;
    my $children = {
        #tbping => 'MT::TBPing',
        category => 'MT::Category',
        placement => 'MT::Placement',
        fileinfo => 'MT::FileInfo',
    };
    $children;
}

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
        author => 'MT::Author',
    };
    $parents;
}

sub restore_parent_ids {
    my $obj = shift;
    my ($data, $objects) = @_;

    my $parent_names = $obj->parent_names;

    my $done = -1;
    for my $parent_element_name (keys %$parent_names) {
        my $parent_class_name = $parent_names->{$parent_element_name};
        my $old_id = $data->{$parent_element_name . '_id'};
        my $new_obj = $objects->{"$parent_class_name#$old_id"};
        next if !(defined($new_obj) && $new_obj);
        $data->{$parent_element_name . '_id'} = $new_obj->id;
        $done++;
    }
    my $old_id = $data->{'parent'};
    if (defined($old_id) && ($old_id > 0)) {
        my $new_obj = $objects->{"MT::Category#$old_id"};
        if (defined($new_obj) && $new_obj) {
            $data->{'parent'} = $new_obj->id;
            $done++;
        }
    } else {
        $done++;
    }
    (scalar(keys(%$parent_names)) == $done) ? 1 : 0;   
}

package MT::Comment;

## To avoid duplicates...
#sub children_names {
#    my $obj = shift;
#    my $children = {
#        author -> 'MT::Author',
#    };
#    $children;
#}

sub parent_names {
    my $obj = shift;
    my $parents = {
        entry => 'MT::Entry',
        blog => 'MT::Blog',
    };
    $parents;
}

sub restore_parent_ids {
    my $obj = shift;
    my ($data, $objects) = @_;

    my $parent_names = $obj->parent_names;

    my $done = -1;
    for my $parent_element_name (keys %$parent_names) {
        my $parent_class_name = $parent_names->{$parent_element_name};
        my $old_id = $data->{$parent_element_name . '_id'};
        my $new_obj = $objects->{"$parent_class_name#$old_id"};
        next if !(defined($new_obj) && $new_obj);
        $data->{$parent_element_name . '_id'} = $new_obj->id;
        $done++;
    }
    my $old_id = $data->{'commenter_id'};
    if (defined($old_id) && ($old_id > 0)) {
        my $new_obj = $objects->{"MT::Author#$old_id"};
        if (defined($new_obj) && $new_obj) {
            $data->{'commenter_id'} = $new_obj->id;
            $done++;
        }
    } else {
        $done++;
    }
    (scalar(keys(%$parent_names)) == $done) ? 1 : 0;   
}

package MT::Entry;

sub children_to_xml {
    my $obj = shift;
    my ($namespace, $args) = @_;

    my $xml = '';

    $xml .= $obj->_entry_child_to_xml('MT::Placement');

    require MT::ObjectTag;
    my $offset = 0;
    while (1) {
        my @objecttags = MT::ObjectTag->load(
            { object_id => $obj->id, object_datasource => $obj->datasource },
            { offset => $offset, limit => 50, }
        );
        last unless @objecttags;
        $offset += scalar @objecttags;
        for my $objecttag (@objecttags) {
            $xml .= $objecttag->to_xml($namespace, $args) . "\n" if $objecttag->to_backup;
        }
    }
    
    #require MT::Trackback;
    #my $tb = MT::Trackback->load({ entry_id => $obj->id });
    #if ($tb) {
    #    require MT::TBPing;
    #    my $offset = 0;
    #    while (1) {
    #        my @pings = MT::TBPing->load(
    #            { tb_id => $tb->id, },
    #            { offset => $offset, limit => 50, }
    #        );
    #        last unless @pings;
    #        $offset += scalar @pings;
    #        for my $ping (@pings) {
    #            $xml .= $ping->to_xml($namespace, $args) . "\n" if $ping->to_backup;
    #        }
    #    }
    #}
    
    $xml .= $obj->_entry_child_to_xml('MT::FileInfo', $namespace, $args);
    
    $xml;
}

sub _entry_child_to_xml {
    my $obj = shift;
    my ($child_class, $namespace, $args) = @_;
    my $xml = '';
    
    eval "require $child_class";
    my $err = $@;
    return $err if defined($err) && $err;

    my $offset = 0;
    while (1) {
        my @objects = $child_class->load(
            { entry_id => $obj->id, },
            { offset => $offset, limit => 50, }
        );
        last unless @objects;
        $offset += scalar @objects;
        for my $object (@objects) {
            $xml .= $object->to_xml($namespace, $args) . "\n" if $object->to_backup;
        }
    }
    $xml;
}

sub children_names {
    my $obj = shift;
    my $children = {
        objecttag => 'MT::ObjectTag',
        placement => 'MT::Placement',
        fileinfo => 'MT::FileInfo',
    };
    $children;
}

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
        author => 'MT::Author',
    };
    $parents;
}

package MT::Notification;

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
    };
    $parents;
}

package MT::ObjectTag;

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
        tag => 'MT::Tag',
        entry => 'MT::Entry',
        asset => 'MT::Asset',
    };
    $parents;
}

sub restore_parent_ids {
    my $obj = shift;
    my ($data, $objects) = @_;

    my $parent_names = $obj->parent_names;

    my $done = 1;
    for my $parent_element_name (keys %$parent_names) {
        my $parent_class_name = $parent_names->{$parent_element_name};
        my $old_id = $data->{$parent_element_name . '_id'};
        my $new_obj = $objects->{"$parent_class_name#$old_id"};
        next if !(defined($new_obj) && $new_obj);
        $data->{$parent_element_name . '_id'} = $new_obj->id;
        $done++;
    }
    my $old_id = $data->{'object_id'};
    if (defined($old_id) && ($old_id > 0)) {
        my $class = $parent_names->{$data->{'object_datasource'}};
        my $new_obj = $objects->{"$class#$old_id"};
        if (defined($new_obj) && $new_obj) {
            $data->{'object_id'} = $new_obj->id;
            $done++;
        }
    } else {
        $done++;
    }
    (scalar(keys(%$parent_names)) == $done) ? 1 : 0;   
}

package MT::Permission;

sub parent_names {
    my $obj = shift;
    my $parents = {
        author => 'MT::Author',
        blog => 'MT::Blog'
    };
    $parents;
}

package MT::Placement;

sub parent_names {
    my $obj = shift;
    my $parents = {
        category => 'MT::Category',
        blog => 'MT::Blog',
        entry => 'MT::Entry',
    };
    $parents;
}

package MT::Role;

sub children_names {
    my $obj = shift;
    my $children = {
        association => 'MT::Association',
    };
    $children;
}

package MT::Tag;

sub children_names {
    my $obj = shift;
    my $children = {
        objecttag => 'MT::ObjectTag',
    };
    $children;
}

package MT::TBPing;

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
    };
    $parents;
}

sub restore_parent_ids {
    my $obj = shift;
    my ($data, $objects) = @_;

    my $parent_names = $obj->parent_names;

    my $done = -1;
    for my $parent_element_name (keys %$parent_names) {
        my $parent_class_name = $parent_names->{$parent_element_name};
        my $old_id = $data->{$parent_element_name . '_id'};
        my $new_obj = $objects->{"$parent_class_name#$old_id"};
        next if !(defined($new_obj) && $new_obj);
        $data->{$parent_element_name . '_id'} = $new_obj->id;
        $done++;
    }
    my $old_tb_id = $data->{'tb_id'};
    my $new_tb;
    require MT::Trackback;
    my $tb = MT::Trackback->load($old_tb_id);
    if (my $cid = $tb->category_id) {
        my $new_obj = $objects->{"MT::Category#" . $cid};
        if (defined($new_obj) && $new_obj) {
            $new_tb = MT::Trackback->load({ category_id => $new_obj->id });
            return 0 if (!defined($new_tb) || !$new_tb);
        }   
    } elsif (my $eid = $tb->entry_id) {
        my $new_obj = $objects->{"MT::Entry#" . $eid};
        if (defined($new_obj) && $new_obj) {
            $new_tb = MT::Trackback->load({ entry_id => $new_obj->id });
            return 0 if (!defined($new_tb) || !$new_tb);
        }
    }
    if (defined($new_tb) && $new_tb) {
        $data->{'tb_id'} = $new_tb->id;
        $done++;
    }
    (scalar(keys(%$parent_names)) == $done) ? 1 : 0;   
}

package MT::Template;

sub children_names {
    my $obj = shift;
    my $children = {
        fileinfo => 'MT::FileInfo',
        templatemap => 'MT::TemplateMap',
    };
    $children;
}

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
    };
    $parents;
}

package MT::TemplateMap;

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
        template => 'MT::Template',
    };
    $parents;
}

package MT::Trackback;

sub children_names {
    my $obj = shift;
    my $children = {
        tbping => 'MT::TBPing',
    };
    $children;
}

sub children_to_xml {
    my $obj = shift;
    my ($namespace, $args) = @_;

    my $t = {};
    if (defined($args)) {
        my $j = $args->{'join'};
        $t = $j->[2] if defined($j);
    }

    my $xml = '';

    my $terms = { 
        'tb_id' => $obj->id,
        %$t,
    };
    
    my $offset = 0;
    while (1) {
        my @objects = MT::TBPing->load(
            $terms,
            { offset => $offset, limit => 50, }
        );
        last unless @objects;
        $offset += scalar @objects;
        for my $object (@objects) {
            $xml .= $object->to_xml($namespace) . "\n" if $object->to_backup;
        }
    }
    $xml;
}

sub parent_names {
    my $obj = shift;
    my $parents = {
        entry => 'MT::Entry',
        category => 'MT::Category',
    };
    $parents;
}

sub restore_parent_ids {
    my $obj = shift;
    my ($data, $objects) = @_;

    my $result = 0;
    my $new_blog = $objects->{'MT::Blog#' . $data->{blog_id}};
    if ($new_blog) {
        $data->{blog_id} = $new_blog->id;
    } else {
        return 0;
    }                            
    if ($data->{category_id}) {
        my $new_obj = $objects->{'MT::Category#' . $data->{category_id}};
        if ($new_obj) {
            $data->{category_id} = $new_obj->id;
            $result = 1;
        }
    } elsif ($data->{entry_id}) {
        my $new_obj = $objects->{'MT::Entry#' . $data->{entry_id}};
        if ($new_obj) {
            $data->{entry_id} = $new_obj->id;
            $result = 1;
        }
    }
    $result;
}

package MT::FileInfo;

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
        template => 'MT::Template',
        templatemap => 'MT::TemplateMap',
        category => 'MT::Category',
        entry => 'MT::Entry',
    };
    $parents;
}

1;
__END__

=head1 NAME

MT::BackupRestore

=head1 METHODS

=head2 backup

TODO Backup I<MT::Tag>, I<MT::Author>, I<MT::Blog>, I<MT::Role>, 
I<MT::Category>, I<MT::Asset>, and I<MT::Entry>.  Each object will
be back up by MT::Object#to_xml call, which will do the actual
Object ==>> XML serialization.

=head2 restore_file

TODO Restore MT system from an XML file which contains MT backup
information (created by backup subroutine).

=head2 restore_process_single_file

TODO A method which will do the actual heavy lifting of the
process to restore objects from an XML file.

=head2 restore_directory

TODO A method which reads specified directory, find a manifest file,
and do the multi-file restore operation directed by the manifest file.

=head2 restore_asset

TODO A method which restores the assets' actual files to the
specified directory.

=head2 process_manifest

TODO A method which is called from MT::App::CMS to process an uploaded
manifest file which is to be the source of the multi-file restore
operation in the MT::App::CMS.

=head1 Callbacks

For plugins which uses MT::Object-derived types, backup and restore
operation call callbacks for plugins to inject XMLs so they are
also backup, and read XML to restore objects so they are also restored.

Callbacks called by the package are as follows:

=over 4

=item Backup
    
Calling convention is:

    callback($cb, $blog_ids)

The callback is used for MT::Object-derived types used by plugins
to be backup.  The callback must return the object's XML representation
in a string, or 1 for nothing.  $blog_ids has an ARRAY reference to
blog_ids which indicates what weblog a user chose to backup.  It may
be an empty array if a user chose Everything.

If a plugin has an MT::Object derived type, the plugin will register 
a callback to Backup callback, and Backup process will call the callbacks
to give plugins a chance to add their own data to the backup file.

=item Restore

Restore callbacks are called in convention like below:

    callback($cb, $data, $objects, $deferred, $callback);

Where $data is a parameter which was passed to XML::SAX::Base's 
start_element callback method.

$objects is an hash reference which contains all the restored objects
in the restore session.  The hash keys are stored in the format
MT::ObjectClassName#old_id, and hash values are object reference
of the actually restored objects (with new id).  Old ids are ids
which are stored in the XML files, while new ids are ids which
are restored.

$deferred is an hash reference which contains information about
restore-deferred objects.  Deferred objects are those objects
which appeared in the XMl file but could not be restored because
any parent objects are missing.  The hash keys are stored in
the format MT::ObjectClassName#old_id and hash values are 1.

$callback is a code reference which will print out the passed paramter.
Callback method can use this to communicate with users.

If a plugin has an MT::Object derived type, the plugin will register 
a callback to Restore.<element_name>:<xmlnamespace> callback, 
so later the restore operation will call the callback function with 
parameters described above.  XML Namespace is required to be registered, 
so an xml node can be resolved into what plugins to be called back, 
and can be distinguished the same element name with each other.

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
