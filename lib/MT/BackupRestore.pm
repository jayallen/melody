# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
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
    my ($blog_ids, $printer, $splitter, $finisher, $callback, $number, $enc) = @_;
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
        push @$obj_to_backup, {'MT::Role' => {
            term => undef,
            args => { 'join' => 
                [ 'MT::Association', 'role_id', { blog_id => $blog_ids }, undef ]
            }}};
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
    } else {
        push @$obj_to_backup, {'MT::Tag' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Author' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Blog' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Role' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Category' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Asset' => { term => undef, args => undef }};
        push @$obj_to_backup, {'MT::Entry' => { term => undef, args => undef }};
    }

    my $header .= "<movabletype xmlns='" . NS_MOVABLETYPE . "'>\n";
    $header = "<?xml version='1.0' encoding='$enc'?>\n$header" if $enc !~ m/utf-?8/i;
    $printer->($header);

    my $files = {};
    _loop_through_objects(
        $printer, $splitter, $finisher, $callback, $number, $obj_to_backup, $files);

    $printer->('</movabletype>');
    $finisher->($files);
}

sub _loop_through_objects {
    my ($printer, $splitter, $finisher, $callback, $number, $obj_to_backup, $files) = @_;

    my $counter = 0;
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
            $printer->("$err\n");
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
                $counter++;
                if ($number && ($counter % $number == 0)) {
                    $splitter->(int($counter / $number + 1));
                }
                $printer->($object->to_xml($args) . "\n") if $object->to_backup;
                if ($class eq 'MT::Author') {
                    # MT::Author may be duplicated because of how terms and args are created.
                    $author_ids_seen{$object->id} = 1;
                } elsif ($class eq 'MT::Asset') {
                    $files->{$object->id} = [$object->url, $object->file_path, $object->file_name];
                }
                my $xml = $callback->($object)
                    or $printer->(MT->errstr());
                $printer->($xml . "\n") if $xml ne '1';
            }
        }
    }
}

sub restore_file {
    my $class = shift;
    my ($fh, $errormsg, $callback) = @_;

    my $xp = _process_backup_header($fh);
    if (!defined($xp)) {
        $$errormsg = MT->translate('Uploaded file was not a valid Movable Type backup file.');
        return undef;
    }

    my @obj_to_restore = (    ## Beware the order of keys is important.
        {tag => 'MT::Tag'},
        {author => 'MT::Author'},
        {blog => 'MT::Blog'},
        {role => 'MT::Role'},
        {category => 'MT::Category'},
        {asset => 'MT::Asset'},
        {entry => 'MT::Entry'},
    );
    my %objects;
    my $deferred = {};
    my $error;

    my $result = __PACKAGE__->restore_process_single_file(
        $fh, \@obj_to_restore, \%objects, $deferred, \$error, $callback);

    $deferred;
}

sub _process_backup_header {
    my ($fh) = @_;

    if ((ref($fh) eq 'Fh') || (ref($fh) eq 'GLOB')){
        seek($fh, 0, 0) or return undef;
        require XML::XPath;
        my $xp = XML::XPath->new($fh) or return undef;
        my $root;
        eval {
            $root = $xp->find("/*[local-name()='movabletype'][1]");
        };
        return undef if $@;
        if ($root && ('movabletype' eq $root->get_node(1)->getLocalName)) {
            return $xp;
        }
    }
    return undef;

}

sub restore_process_single_file {
    my $class = shift;
    my ($fh, $obj_to_restore, $objects, $deferred, $error, $callback) = @_;
    
    my $xp = _process_backup_header($fh);
    if (!defined($xp)) {
        $$error = MT->translate('Uploaded file was not a valid Movable Type backup file.');
        return 0;
    }
    
    my $root_path = "/*[local-name()='movabletype']";
    for my $name_hash (@$obj_to_restore) {
        my @keys = keys %$name_hash;
        my $name = $keys[0];
        my $nodeset = $xp->find("$root_path/*[local-name()='$name']");
        for my $index (1..$nodeset->size()) {
            my $node = $nodeset->get_node($index);
            next if !($node->isa('XML::XPath::Node::Element'));

            my $class = $name_hash->{$node->getLocalName};
            eval "require $class;";
            $class->from_xml(
                XPath => $xp,
                XmlNode => $node, 
                Objects => $objects, 
                Deferred => $deferred,
                Error => $error, 
                Callback => $callback
            );
        }
    }
}

sub restore_directory {
    my $class = shift;
    my ($dir, $error, $error_assets, $callback) = @_;

    my $manifest;
    my @files;
    opendir my $dh, $dir or $$error = MT->translate("Can't open directory '[_1]': [_2]", $dir, "$!"), return undef;
    for my $f (readdir $dh) {
        next if $f !~ /^.+\.manifest$/i;
        $manifest = File::Spec->catfile($dir, $f);
        last;
    }
    closedir $dh;
    unless ($manifest) {
        $$error = MT->translate("No manifest file could be found in your import directory [_1].", $dir);
        return 0;
    }

    my $fh = gensym;
    open $fh, "<$manifest" or $$error = MT->translate('[_1] cannot open.'), return 0;
    my $backups = _process_manifest($fh);
    close $fh;
    unless($backups) {
        $$error = MT->translate("Manifest file [_1] was not a valid Movable Type backup manifest file.", $manifest);
        return undef;
    }

    $callback->(MT->translate("Manifest file: [_1]\n", $manifest));

    my @obj_to_restore = (    ## Beware the order of keys is important.
        {tag => 'MT::Tag'},
        {author => 'MT::Author'},
        {blog => 'MT::Blog'},
        {role => 'MT::Role'},
        {category => 'MT::Category'},
        {asset => 'MT::Asset'},
        {entry => 'MT::Entry'},
    );
    my %objects;
    my $deferred = {};

    my $files = $backups->{files};
    for my $file (@$files) {
        my $fh = gensym;
        my $filepath = File::Spec->catfile($dir, $file);
        open $fh, "<$filepath" or $$error = MT->translate('[_1] cannot open.'), return undef;
        my $xp = _process_backup_header($fh);
        if (!defined($xp)) {
            $$error = MT->translate('The file [_1] was not a valid Movable Type backup file.', $filepath);
            return undef;
        }

        my $result = __PACKAGE__->restore_process_single_file(
            $fh, \@obj_to_restore, \%objects, $deferred, $error, $callback);

        close $fh;
    }
    
    $error_assets = _restore_assets($dir, $backups, \%objects, $callback) if defined($backups->{assets});
    $deferred;
}

sub _process_manifest {
    my ($stream) = @_;

    if ((ref($stream) eq 'Fh') || (ref($stream) eq 'GLOB')){
        seek($stream, 0, 0) or return undef;
        require XML::XPath;
        my $xp = XML::XPath->new($stream) or return undef;
        my $root;
        eval {
            $root = $xp->find("/*[local-name()='manifest'][1]");
        };
        return undef if $@;
        if ($root && ('manifest' eq $root->get_node(1)->getLocalName)) {
            my $backups = {
                files => [],
                assets => [],
            };
            my $nodeset = $xp->find("*", $root->get_node(1));
            for my $index (1..$nodeset->size()) {
                my $node = $nodeset->get_node($index);
                next if !($node->isa('XML::XPath::Node::Element'));
                if ('backup' eq $node->getAttribute('type')) {
                    push @{$backups->{files}}, $node->getAttribute('name');
                } elsif ('asset' eq $node->getAttribute('type')) {
                    push @{$backups->{assets}}, { 
                        name => $node->getAttribute('name'),
                        asset_id => $node->getAttribute('asset_id'),
                    };
                }
            }
            return $backups;
        }
        return undef;
    }
    return undef;
}

sub restore_asset {
    my $class = shift;
    my ($tmp, $asset_element, $objects, $errors, $callback) = @_;

    my $id = $asset_element->{asset_id};
    next if !defined($id);
    next if !(exists $objects->{"MT::Asset#$id"});
    my $asset = $objects->{"MT::Asset#$id"};
    my $path = $asset->file_path;
    next if !defined($path);
    my ($vol, $dir, $fn) = File::Spec->splitpath($path);
    if (!-w "$vol$dir") {
        $errors->{$id} = MT->translate('[_1] is not writable.', "$vol$dir");
        next;
    }
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
    $callback->(exists($errors->{$id}) ?
        MT->translate("Failed: [_1]\n", $errors->{$id}) :
        MT->translate("Done.\n")
    );
}

sub _restore_assets {
    my ($tmp, $backups, $objects, $callback) = @_;
    my $assets = $backups->{assets};
    my $errors = {};
    return $errors if !defined($assets);
    use File::Copy;
    require File::Spec;
    for my $asset_element (@$assets) {
        __PACKAGE__->restore_asset($tmp, $asset_element, $objects, $errors, $callback);
    }
    $errors;
}

sub restore_upload_manifest {
    my $class = shift;
    my ($fh, $param) = @_;

    my $backups = _process_manifest($fh);
    return MT->translate("Uploaded file was not a valid Movable Type backup manifest file.") if !defined($backups);

    my $files = $backups->{files};
    my $assets = $backups->{assets};
    my $file_next = shift @$files if defined($files) && scalar(@$files);
    my $assets_json;

    if (!defined($file_next)) {
        if (scalar(@$assets)) {
            my $asset = shift @$assets;
            $file_next = $asset->{name};
            $param->{is_asset} = 1;
        }
    }
    require JSON;
    require MT::Util;
    $assets_json = MT::Util::encode_html(JSON::objToJson($assets)) if scalar(@$assets);
    $param->{files} = join(',', @$files);
    $param->{assets} = $assets_json;
    $param->{filename} = $file_next;
    return q();
}

1;
__END__

=head1 NAME

MT::BackupRestore

=head1 METHODS

=head2 backup_everything

TODO backup I<users>, I<roles>, ...

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
