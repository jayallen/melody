# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id: AtomServer.pm 5144 2010-01-06 05:49:46Z takayama $

package AtomPub::Server::Comments;
use strict;

use base qw( AtomPub::Server::Weblog );
use MT::I18N qw( encode_text );

sub script { $_[0]->{cfg}->AtomScript . '/comments' }

sub handle_request {
    my $app = shift;
    $app->authenticate || return;
    if (my $svc = $app->{param}{svc}) {
        if ($svc eq 'upload') {
            return $app->handle_upload;
        } elsif ($svc eq 'categories') {
            return $app->get_categories;
        }
    }
    my $method = $app->request_method;
    if ($method eq 'POST') {
#        return $app->new_comment;
    } elsif ($method eq 'PUT') {
#        return $app->edit_comment;
    } elsif ($method eq 'DELETE') {
#        return $app->delete_comment;
    } elsif ($method eq 'GET') {
        if ($app->{param}{comment_id}) {
            return $app->get_comment;
        } elsif ($app->{param}{entry_id}) {
            return $app->get_comments;
        } else {
            return $app->get_blog_comments;
        }
    }
}

sub new_with_comment {
    my $app = shift;
    my ($comment) = @_;
    my $atom = AtomPub::Atom::Entry->new_with_comment( $comment, Version => 1.0 );

    my $mo = AtomPub::Atom::Entry::_create_issued(
        $comment->modified_on || $comment->created_on, $comment->blog);
    $atom->set(AtomPub::Server::Weblog::NS_APP(), 'edited', $mo);

    $atom;
}

sub get_comment {
    my $app = shift;
    my $blog = $app->{blog};
    my $comment_id = $app->{param}{comment_id}
        or return $app->error(400, "No comment_id");
    my $comment = MT::Comment->load($comment_id)
        or return $app->error(400, "Invalid comment_id");
    my $entry = $comment->entry;
    my $uri = $app->base . $app->uri . '/blog_id=' . $blog->id;
    my $c = $app->new_with_comment($comment);
    $c->add_link({ rel => 'self', type => $app->atom_x_content_type,
                   href => $uri . '/comment_id=' . $comment->id });
    # feed/updated should be added before entries
    # so we postpone adding them until later
    $c->set('http://purl.org/syndication/thread/1.0', 'in-reply-to',
        undef,
        { ref => $entry->atom_id,
            type => 'text/html',
            href => $entry->permalink } );
    $app->run_callbacks( 'get_comment', $c, $comment );
    $app->response_content_type($app->atom_content_type);
    $c->as_xml;
}

sub get_blog_comments {
    my $app = shift;
    my $blog = $app->{blog};
    my %terms = (blog_id => $blog->id, visible => 1);
    my %arg = (sort => $app->get_posts_order_field, direction => 'descend');
    $arg{limit}  = $app->{param}{limit}  || 21;
    $arg{offset} = $app->{param}{offset} || 0;

    my $feed = $app->new_feed();
    my $uri = $app->base . $app->uri . '/blog_id=' . $blog->id;
    my $blogname = encode_text($blog->name, undef, 'utf-8');
    $feed->add_link({ rel => 'alternate', type => 'text/html',
                      href => $blog->site_url });
    $feed->add_link({ rel => 'self', type => $app->atom_x_content_type,
                      href => $uri });
    $feed->title($blogname);

    require URI;
    my $site_uri = URI->new($blog->site_url);
    if ( $site_uri ) {
        my $blog_created = MT::Util::format_ts('%Y-%m-%d', $blog->created_on, $blog, 'en', 0);
        my $id = 'tag:'.$site_uri->host.','.$blog_created.':'.$site_uri->path.'/'.$blog->id;
        $feed->id($id);
    }
    $app->_comments_in_atom($feed, \%terms, \%arg);
    $app->run_callbacks( 'get_blog_comments', $feed, $blog );
    ## xxx add next/prev links
    $app->response_content_type($app->atom_content_type);
    $feed->as_xml;
}

sub get_comments {
    my $app = shift;
    my $blog = $app->{blog};
    my $entry_id = $app->{param}{entry_id}
        or return $app->error(400, "No entry_id");
    my $entry = MT::Entry->load($entry_id)
        or return $app->error(400, "Invalid entry_id");
    my %terms = (blog_id => $blog->id, entry_id => $entry->id, visible => 1);
    my %arg = (sort => $app->get_posts_order_field, direction => 'descend');
    $arg{limit}  = $app->{param}{limit}  || 21;
    $arg{offset} = $app->{param}{offset} || 0;

    my $feed = $app->new_feed();
    my $uri = $app->base . $app->uri . '/blog_id=' . $blog->id;
    my $blogname = encode_text($blog->name, undef, 'utf-8');
    $feed->add_link({ rel => 'alternate', type => 'text/html',
                      href => $entry->permalink });
    $feed->add_link({ rel => 'self', type => $app->atom_x_content_type,
                      href => $uri . '/entry_id=' . $entry->id });
    $feed->title($entry->title);
    $feed->id($entry->atom_id . '/comments');
    $app->_comments_in_atom($feed, \%terms, \%arg);
    $app->run_callbacks( 'get_comments', $feed, $entry );
    ## xxx add next/prev links
    $app->response_content_type($app->atom_content_type);
    $feed->as_xml;
}

sub _comments_in_atom {
    my $app = shift;
    my ( $feed, $terms, $args ) = @_;
    require MT::Comment;
    my $iter = MT::Comment->load_iter($terms, $args);
    my $latest_date = 0;
    my @comments;
    while (my $comment = $iter->()) {
        my $c = $app->new_with_comment($comment);
        # feed/updated should be added before entries
        # so we postpone adding them until later
        my $entry = $comment->entry;
        $c->set('http://purl.org/syndication/thread/1.0', 'in-reply-to',
            undef,
            { ref => $entry->atom_id,
              type => 'text/html',
              href => $entry->permalink } );
        push @comments, $c;
        my $date = $comment->modified_on || $comment->created_on;
        if ( $latest_date < $date ) {
            $latest_date = $date;
            $feed->updated( $c->updated );
        }
    }
    $feed->add_entry($_) foreach @comments;
    $feed;
}


1;
