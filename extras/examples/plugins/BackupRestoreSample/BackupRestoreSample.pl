# Copyright 2005-2007 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.
#
# $Id$

package MT::Plugin::BackupRestoreSample;

use strict;
use base 'MT::Plugin';
use vars qw($VERSION);
$VERSION = '0.1';

use BackupRestoreSample::Object;

my $plugin;
my $ns = 'urn:sixapart.com:ns:pluginsample';
$plugin = MT::Plugin::BackupRestoreSample->new({
    name => "BackupRestoreSample",
    version => $VERSION,
    description => "<MT_TRANS phrase=\"This plugin is to test out the backup restore callback.\">",
    author_name => "Fumiaki Yoshimatsu",
    author_link => "http://www.sixapart.com/",
    #l10n_class => 'BackupRestore::L10N',
    object_classes => [
        'BackupRestoreSample::Object'
    ],
    schema_version => '0.1',
});
MT->add_plugin($plugin);
MT->add_callback('Backup.role', 9, $plugin, \&backup);
MT->add_callback('Backup.blog', 9, $plugin, \&backup);
MT->add_callback('Backup.else', 9, $plugin, \&backup_else);
MT->add_callback("Restore.role:$ns", 9, $plugin, \&restore);
MT->add_callback("Restore.blog:$ns", 9, $plugin, \&restore);
MT->add_callback("Restore.else:$ns", 9, $plugin, \&restore_else);

sub backup {
    my ($cb, $obj) =@_;
    my $class = ref $obj;
    my $xml;
    my $terms = {};
    
    $terms->{blog_id} = $obj->id if 'MT::Blog' eq ref($obj);
    $terms->{role_id} = $obj->id if 'MT::Role' eq ref($obj);
    my @objects = BackupRestoreSample::Object->load($terms);
    for my $object (@objects) {
        $xml .= $object->to_xml($ns);
    }
    return $xml;
}

sub backup_else {
    my ($cb) = @_;
    return "<foo xmlns='$ns'>barbaz</foo>";
}

sub restore {
    my ($cb, $xp, $xml_node, $parent, $objects, $deferred, $printer) = @_;
    return 0 if !($xml_node->isa('XML::XPath::Node::Element'));
    my $namespace_node = $xml_node->getNamespace($xml_node->getPrefix);
    return 0 if $ns ne $namespace_node->getExpanded;
    my $error = '';
    my $obj = BackupRestoreSample::Object->from_xml(
        XPath => $xp,
        XmlNode => $xml_node,
        Objects => $objects,
        Deferred => $deferred,
        Callback => $printer,
        Namespace => $ns,
    );
    1;
}

sub restore_else {
    my ($cb, $xp, $xml_node, $objects, $deferred, $printer) = @_;
    return 0 if !($xml_node->isa('XML::XPath::Node::Element'));
    my $namespace_node = $xml_node->getNamespace($xml_node->getPrefix);
    return 0 if $ns ne $namespace_node->getExpanded;
    $printer->('restore_else has been called: ' . $xml_node->toString);
    1;
}
