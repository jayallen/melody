# AtomPub #

AtomPub provides an improved Atom Publishing Protocol API for Movable Type and Melody services.


## Installation ##

To install the plugin:

1. Create a `plugins/AtomPub` directory in your MT/Melody directory.
2. Unpack the plugin into that directory.


## Usage ##

To use the plugin, reconfigure your AtomPub client to use the plugin's `mt-atom.cgi` path. For example, if your MT/Melody site is at:

    http://www.example.com/mt/mt.cgi

the regular AtomPub endpoint is at:

    http://www.example.com/mt/mt-atom.cgi/1.0

To use the AtomPub plugin's improved interface, instead use the URL:

    http://www.example.com/mt/plugins/AtomPub/mt-atom.cgi/1.0


## AtomPub protocol ##

When posting, use the Atom Publishing Protocol as defined in [RFC 5023][].

[RFC 5023]: http://tools.ietf.org/html/rfc5023

### Authentication ###

Use [HTTP Basic authentication][] with the username and **Web Services password** for an author account in your MT/Melody site. You'll find the field for setting your account's Web Services password in the "Edit Profile" screen of the MT/Melody application.

HTTP Basic authentication should only be used when the application is secured with HTTPS. To use WSSE authentication instead, set the `AtomAppAuthentication` configuration directive:

    AtomAppAuthentication AtomPub::Authen::WSSE

Developers can also create authenticators for other authentication protocols. Write an `AtomPub::Authen` subclass that implements the `authenticate()` method and specify that class in the `AtomAppAuthentication` directive.

[HTTP Basic authentication]: http://tools.ietf.org/html/rfc2617

### Service documents ###

To retrieve the service document for the AtomPub endpoint, perform an HTTP `GET` on the root URL:

    http://www.example.com/mt/plugins/AtomPub/mt-atom.cgi/1.0

The blogs you're authorized to post in will be listed as collections.

### Uploading files and images ###

To add a new file or image to the MT site, `POST` the file as a Media Resource (as in AtomPub section 9.6) to the blog's resource. A Media Link Entry is created and returned as the response:

    POST /mt/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1
    Host: www.example.com
    Content-Type: image/jpeg
    Slug: a-beautiful-day.jpeg
    Authorization: Basic ZGFmZnk6c2VjZXJldA==
    Content-Length: nnn
    
    ... image/jpeg data ...

    HTTP/1.1 201 Created
    Date: Fri, 7 Oct 2005 17:17:11 GMT
    Content-Length: nnn
    Content-Type: application/atom+xml;type=entry
    Location: http://www.example.com/mt/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1/asset_id=1
    
    <?xml version="1.0"?>
    <entry ...
        <content type="image/jpeg"
                 src="http://www.example.com/blog/a-beautiful-day.jpeg"/>
        ...

The uploaded image is available at the URL given as the `src` attribute of the Media Link Entry's `content` element.

As the AtomPub plugin does not provide the ability to replace the file for an existing Asset, the Media Link Entry will not include an `edit-media` link.

### Associating images with blog entries ###

Blog entries are created in a similar way, by `POST` to the blog's resource. MT/Melody templates can access the media associated with entries using the `<mt:Assets>` tag in the entry context. To associate a media item with the post, make sure the HTML content of the post includes a link to the media's content URL, as either an `<a href>` or `<img src>`. Associated media are provided in response entries as `<link rel="related">` links to their Media Link Entries.

    POST /mt/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1
    Host: www.example.com
    Content-Type: application/atom+xml
    Slug: a-beautiful-day
    Authorization: Basic ZGFmZnk6c2VjZXJldA==
    Content-Length: nnn
    
    <?xml version="1.0"?>
    <entry ...
        <content type="html">
            &lt;img src="http://www.example.com/blog/a-beautiful-day.jpeg"&gt;
        </content>
        ...

    HTTP/1.1 201 Created
    Date: Fri, 7 Oct 2005 17:17:11 GMT
    Content-Length: nnn
    Content-Type: application/atom+xml;type=entry
    Location: http://www.example.com/.../1.0/blog_id=1/entry_id=1
    
    <?xml version="1.0"?>
    <entry ...
        <content type="html">
            &lt;img src="http://www.example.com/blog/a-beautiful-day.jpeg"&gt;
        </content>
        <link rel="related" type="application/atom+xml"
            href="http://www.example.com/.../1.0/blog_id=1/asset_id=1"/>
        ...

You can also associate media without linking to it in the post content by providing it yourself as a `<link rel="related">` link.

    POST /mt/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1
    Host: www.example.com
    Content-Type: application/atom+xml
    Slug: a-beautiful-day
    Authorization: Basic ZGFmZnk6c2VjZXJldA==
    Content-Length: nnn
    
    <?xml version="1.0"?>
    <entry ...
        <content type="html">
            &lt;p&gt;Such a beautiful day!&lt;/p&gt;
        </content>
        <link rel="related" type="application/atom+xml"
            href="http://www.example.com/.../1.0/blog_id=1/asset_id=1"/>
        ...

Such media is not automatically linked from or embedded in your entry's content, so the entry will contain only the HTML specified in your `<content>` element. Adding media in this way is useful if your blog theme uses such associated media some other way.

As there is no `<link rel="unrelated">`, media associated with an entry cannot be disassociated through the AtomPub interface. Media can be removed from your entries by editing them in the MT/Melody application.

### Using custom fields ###

With the Custom Fields plugin, Movable Type allows site administrators to provide new data fields for the entry object. The AtomPub plugin provides the values of text Custom Fields when retrieving entries as elements in the `http://sixapart.com/atom/typepad#` namespace.

To set Custom Field values, provide them as `http://sixapart.com/atom/typepad#` namespace elements when you `POST` or `PUT` an entry. Use the Custom Field's basename as the node name of the element.

    PUT /mt/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1/entry_id=1
    Host: www.example.com
    Content-Type: application/atom+xml
    Authorization: Basic ZGFmZnk6c2VjZXJldA==
    Content-Length: nnn
    
    <?xml version="1.0"?>
    <entry ...
        <content type="html">
            &lt;p&gt;Such a beautiful day!&lt;/p&gt;
        </content>
        <weather xmlns="http://sixapart.com/atom/typepad#">beautiful</weather>
        ...

    HTTP/1.1 200 OK
    Date: Fri, 7 Oct 2005 17:17:11 GMT
    Content-Length: nnn
    Content-Type: application/atom+xml;type=entry
    
    <?xml version="1.0"?>
    <entry ...
        <content type="html">
            &lt;p&gt;Such a beautiful day!&lt;/p&gt;
        </content>
        <weather xmlns="http://sixapart.com/atom/typepad#">beautiful</weather>
        ...

The AtomPub plugin supports Entry Custom Fields on Entry Resources, but does not provide Asset Custom Fields on Media Link Entries.
