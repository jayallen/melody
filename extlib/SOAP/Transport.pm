# ======================================================================
#
# Copyright (C) 2000-2003 Paul Kulchenko (paulclinger@yahoo.com)
# SOAP::Lite is free software; you can redistribute it
# and/or modify it under the same terms as Perl itself.
#
# $Id: Transport.pm,v 1.3 2004/10/22 22:23:44 byrnereese Exp $
#
# ======================================================================

=pod

=head1 NAME

SOAP::Transport - an abstract class extended by more specialized transport modules

=head1 DESCRIPTION

Objects of the SOAP::Transport class manage two roles: they manage both the parameters related to transport as set through the containing SOAP::Lite object, and they abstract the selection and loading of an appropriate transport module. This is done with an AUTOLOAD function within the class that intercepts all methods beyond the two defined next and reroutes them to the underlying transport implementation code. 

=head1 METHODS

=over

=item new

    $trans = SOAP::Transport->new;

This is the constructor, which isn't usually called by an application directly. An application can use this to create a fresh new SOAP::Transport object, which may be installed using the SOAP::Lite->transport method defined earlier. No arguments are recognized.

=item proxy(optional URL string)

    $trans->proxy('http://www.blackperl.com/SOAP');

Gets or sets the proxy (endpoint). This method must be called before any other methods are called. The proper transport code is loaded based on the scheme specified by the URL itself (http, jabber, etc.). Until this method is called the first time with a URL string, the underlying code has yet to be loaded, and the methods aren't available. When getting the current proxy (calling with no parameters), the returned value is a reference to the client object created from the protocol class that matched the endpoint, not the endpoint itself.

=back

=head1 SOAP Transport Sub-Classes

Because the bulk of the work is done within the C<SOAP::Lite> module itself, many of the transport-level modules are very simple in their implementations. Transport modules are expected to define both client and server classes within their files. If a module defines only one of the types, it is assumed that the transport protocol itself supports only that side of the conversation. An example is L<SOAP::Transport::FTP>, which provides only a C<SOAP::Transport::FTP::Client> class. 

L</"SOAP::Transport::FTP"> - Client class only

L</"SOAP::Transport::HTTP"> - Client, and server classes for CGI, FCGI, Daemon and mod_perl

L</"SOAP::Transport::IO"> - Server class only

L</"SOAP::Transport::JABBER"> - Server and Client classes

L</"SOAP::Transport::LOCAL"> - Client class only

L</"SOAP::Transport::MAILTO"> - Client class only

L</"SOAP::Transport::MQ"> - Server and Client classes

L</"SOAP::Transport::POP3"> - Server class only

L</"SOAP::Transport::TCP"> - Server and Client classes

=head2 METHODS

Each SOAP::Transport sub-class is expected to define (or inherit, if it is subclassing another transport class) at least two methods. Any newly developed transport classes are also expected to adhere to this interface. Clients are expected to implement the C<new> and C<send_receive> methods, and servers are expected to implement the C<new> and C<handle> methods. Here they are: 

=over

=item new(optional key/value pairs)

    $object = $class->new(%params);

Creates a new object instance and returns it. Like the constructors for both C<SOAP::Lite> and L<SOAP::Server> classes, all arguments passed in are treated as key/value pairs, where the key is expected to be one of the methods the class supports, and the value is the argument (or list reference of arguments) to the method.

=item send_receive(key/value pairs)

    $client->send_recieve(%hash_table);

(Required for client classes only) When the SOAP::Lite objects attempt to send out requests, the means for doing so is to attempt to call this method on the object held within the SOAP::Transport object contained within the client itself. All clients are expected to provide this, and the call to this method always passes four values for the hash keys:

=over 

=item action

The URI specifying the action being performed, usually the result from the on_action hook on the client object.

=item encoding

The URI of the encoding scheme that governs the message being sent.

=item endpoint

The URI specifying the endpoint to which the message is being sent.

=item envelope

The XML content of the message to be sent. It is generally the return value of the envelope method from the L<SOAP::Serializer> object instance that the client object maintains.

=item parts

Attachments to add to the request. Currently this only supports an array of MIME::Entity objects, but in theory could support attachments of any format.

=back

=item handle

    $server->handle;

(Required for server classes only.) This method is the central point for the various server classes to provide an interface to handling requests. The exact set and nature of parameters generally varies based on the classes themselves.

=back

=head2 SOAP::Transport::FTP

The SOAP::Transport::FTP module is automatically loaded by the SOAP::Transport portion of the client structure. It is brought in when an endpoint is specified via the proxy method that starts with the characters, ftp://. This module provides only a client class. 

=head3 SOAP::Transport::FTP::Client

Inherits from: L<SOAP::Client>. 

Support is provided for clients to connect to FTP servers using SOAP. The methods defined within the class are just the basic new and send_receive. 

=head2 SOAP::Transport::HTTP

The most commonly used transport module is the HTTP implementation. This is loaded whenever an endpoint is given that starts with the characters, http:// or https://. This is also the most involved of the transport modules, defining not only a client class but several different server classes as well. 

=head3 HTTP PROXY SETTINGS

Because C<SOAP::Client> inherits from C<LWP::UserAgent>, you can use any of C<LWP::UserAgent>'s proxy settings. For example:

   SOAP::Lite->proxy("http://endpoint.server/", 
                     proxy => ["http" => "http://my.proxy.server"]);

or

   $soap->transport->proxy("http" => "http://my.proxy.server");

The above code samples should specify a proxy server for you. And should you use C<HTTP_proxy_user> 
and C<HTTP_proxy_pass> for proxy authorization, C<SOAP::Lite> will handle it properly.

=head3 HTTP BASIC AUTHENTICATION

HTTP Basic authentication is accomplished by overriding the get_basic_credentials suboutine in C<LWP::UserAgent> (which C<SOAP::Transport::HTTP::Client> is a subclass):

  BEGIN {
    sub SOAP::Transport::HTTP::Client::get_basic_credentials { 
      return 'username' => 'password';
    }
  }

=head3 COOKIE-BASED AUTHENTICATION

    use HTTP::Cookies;
    my $cookies = HTTP::Cookies->new(ignore_discard => 1);
    # you may also add 'file' if you want to keep them between sessions
    my $soap = SOAP::Lite->proxy('http://localhost/');
    $soap->transport->cookie_jar($cookies);

Or, alternatively, you can do the above on a single line:

  $soap->proxy('http://localhost/', 
               cookie_jar => HTTP::Cookies->new(ignore_discard => 1));

Cookies will be taken from the response and provided to the request. You may access and manipulate cookies received, as well as add cookies of your own by using the C<HTTP::Cookies> interfaces.

=head3 SSL CERTIFICATE AUTHENTICATION

To get certificate authentication working you need to set three environment variables: C<HTTPS_CERT_FILE>, C<HTTPS_KEY_FILE>, and optionally C<HTTPS_CERT_PASS>. This can be done either through the command line, or directly within your Perl script using the C<$ENV> variable:

  $ENV{HTTPS_CERT_FILE} = 'client-cert.pem';
  $ENV{HTTPS_KEY_FILE}  = 'client-key.pem';

These settings are referrenced by C<Crypt::SSLeay>, the module SOAP::Lite used for HTTPS support. Other options (e.g. CA peer verification) can be specified in a similar way. See L<Crypt::SSLeay> documentation for more information.

Those who would like to use encrypted keys may find the following thread in the SOAP::Lite newsgroup helpful:

http://groups.yahoo.com/group/soaplite/message/729

=head3 COMPRESSION

SOAP::Lite provides you with the option for enabling compression over the wire using HTTP I<only> in both the server and client contexts, provided that you have L<Compress::Zlib> installed. Compression and decompression is done transparantly to your application.

A server will respond with an encoded/compressed message only if the client has asserted that it can accept it (indicated by client sending an C<Accept-Encoding> HTTP header with a 'deflate' or '*' value). 

C<SOAP::Lite> clients all have fallback logic implemented so that if a server doesn't understand the specified encoding (i.e. "Content-Encoding: deflate") and returns the proper HTTP status code (415 NOT ACCEPTABLE), the client will repeat the request without using encoding/compression. The client will then store this server in a per-session cache, so that all subsequent requests to that server will be transmitted without encoding.

Compression is enabled on the client side by specifying the C<compress_threshold> option, and if the size of the current request exceeds that threshold.

B<Client Code Sample>

  print SOAP::Lite
    ->uri('http://localhost/My/Parameters')
    ->proxy('http://localhost/', options => {compress_threshold => 10000})
    ->echo(1 x 10000)
    ->result;

Servers will respond with a compressed message if the C<compress_threshold> option has been specified, if the size of the current response exceeds that threshold, and if the calling client transmitted the proper C<Accept-Encoding> HTTP Header.

B<Server Code Sample>

  my $server = SOAP::Transport::HTTP::CGI
    ->dispatch_to('My::Parameters')
    ->options({compress_threshold => 10000})
    ->handle;

See also: L<Compress::Zlib>

=head3 SOAP::Transport::HTTP::Client

Inherits from: L<SOAP::Client>, L<LWP::UserAgent> (from the LWP package). 

With this class, clients are able to use HTTP for sending messages. This class provides just the basic new and send_receive methods. Objects of this class understand the compress_threshold option and use it if the server being communicated to also understands it. 

=head4 CHANGING THE DEFAULT USERAGENT CLASS

By default, C<SOAP::Transport::HTTP::Client> extends C<LWP::UserAgent>.
But under some circumstances, a user may wish to change the default 
UserAgent class with their in order to better handle persist connections, or
to C<LWP::UserAgent::ProxyAny>, for example, which has better Win32/Internet
Explorer interoperability.

One can use the code below as an example of how to change the default UserAgent class.

  use SOAP::Lite;
  use SOAP::Transport::HTTP;
  $SOAP::Transport::HTTP::Client::USERAGENT_CLASS = "My::UserAgent";
  my $client = SOAP::Lite->proxy(..)->uri(..);
  my $som = $client->myMethod();

There is one caveat, however. The UserAgent class you use, I<MUST> also be a subclass of C<LWP::UserAgent>. If it is not, then C<SOAP::Lite> will issue the following error: "Could not load UserAgent class <USERAGENT CLASS>."

=head4 HTTP-KEEP-ALIVE, TIMEOUTS, AND MORE

Because C<SOAP::Transport::HTTP::Client> extends C<LWP::UserAgent>, all methods available C<LWP::UserAgent> are also available to your SOAP Clients. For example, using C<LWP::UserAgent> HTTP keep alive's are accomplished using the following code:

  my $ua = LWP::UserAgent->new(
        keep_alive => 1,
        timeout    => 30
  );

Therefore, the same initialization parameters you would pass to C<LWP::UserAgent> can also be passed to your SOAP::Lite client's C<proxy> subroutine like so:

    my $soap = SOAP::Lite
       ->uri($uri)
       ->proxy($proxyUrl,
           timeout => 30,
           keep_alive => 1,
         );

This is true for all initialization parameters and methods of C<LWP::UserAgent>.

=head4 METHODS

=over

=item http_request

This method gives you acess to the HTTP Request object that will be, or was transmitted to a SOAP Server. It returns a L<HTTP::Request> object.

=item http_response

This method gives you acess to the HTTP Response object that will be, or was transmitted to a SOAP Server. It returns a L<HTTP::Response> object.

=back

=head3 SOAP::Transport::HTTP::Server

Inherits from: L<SOAP::Server>. 

This is the most basic of the HTTP server implementations. It provides the basic methods, new and handle. The handle method's behavior is defined here, along with other methods specific to this class. The role of this class is primarily to act as a superclass for the other HTTP-based server classes. 

=over

=item handle

    $server->handle;

Expects the request method to have been used to associate a HTTP::Request object with the server object prior to being called. This method retrieves that object reference to get at the request being handled.

=item request(I<optional value>)

    $server->request($req_object)

Gets or sets the HTTP::Request object reference that the server will process within the handle method.

=item response(I<optional value>)

    $server->response(HTTP::Response->new(...));

Gets or sets the HTTP::Response object reference that the server has prepared for sending back to the client.

=item make_response(I<code>, I<body>)

    $server->make_response(200, $body_xml);

Constructs and returns an object of the HTTP::Response class, using the response code and content provided.

=item make_fault(I<fault arguments>)

    $server->response($server->make_fault(@data));

Creates a HTTP::Response object reference using a predefined HTTP response code to signify that a fault has occurred. The arguments are the same as those for the make_fault method of the SOAP::Server class.

=item product_tokens

This method takes no arguments and simply returns a string identifying the elements of the server class itself. It is similar to the product_tokens methods in the HTTP::Daemon and Apache classes.

=back

=head3 SOAP::Transport::HTTP::CGI

Inherits from: L<SOAP::Transport::HTTP::Server>. 

This class is a direct subclass of SOAP::Transport::HTTP::Server and defines no additional methods. It includes logic in its implementation of the handle method that deals with the request headers and parameters specific to a CGI environment. 

=head4 EXAMPLE CGI

The following code sample is a CGI based Web Service that converts celcius to fahrenheit:

    #!/usr/bin/perl
    use SOAP::Transport::HTTP;
    SOAP::Transport::HTTP::CGI
      ->dispatch_to('C2FService')
      ->handle;
    BEGIN {
      package C2FService;
      use vars qw(@ISA);
      @ISA = qw(Exporter SOAP::Server::Parameters);
      use SOAP::Lite;
      sub c2f {
        my $self = shift;
        my $envelope = pop;
        my $temp = $envelope->dataof("//c2f/temperature");
        return SOAP::Data->name('convertedTemp' => (((9/5)*($temp->value)) + 32));
      }
    }

=head4 EXAMPLE APACHE::REGISTRY USAGE

Using a strictly CGI based Web Service has certain performance drawbacks. Running the same CGI under the Apache::Registery system has certain performance gains.

B<httpd.conf>

  Alias /mod_perl/ "/Your/Path/To/Deployed/Modules"
  <Location /mod_perl>
    SetHandler perl-script
    PerlHandler Apache::Registry
    PerlSendHeader On
    Options +ExecCGI
  </Location>

B<soap.cgi>

  use SOAP::Transport::HTTP;

  SOAP::Transport::HTTP::CGI
    ->dispatch_to('/Your/Path/To/Deployed/Modules', 'Module::Name', 'Module::method') 
    ->handle;

I<WARNING: Dynamic deployments with C<Apache::Registry> will fail because the module will be only loaded dynamically the first time. Subsequent calls will produce "denied access" errors because once the module is already in memory C<SOAP::Lite> will bypass dynamic deployment. To work around this, simply specify both the full PATH and MODULE name in C<dispatch_to()> and the module will be loaded dynamically, but will then work as if under static deployment. See F<examples/server/soap.mod_cgi> as an example.>

=head3 SOAP::Transport::HTTP::Daemon

Inherits from: L<SOAP::Transport::HTTP::Server>. 

The SOAP::Transport::HTTP::Daemon class encapsulates a reference to an object of the HTTP::Daemon class (from the LWP package). The class catches methods that aren't provided locally or by the superclass and attempts to call them on the HTTP::Daemon object. Thus, all methods defined in the documentation for that class are available to this class as well. Any that conflict with methods in SOAP::Transport::HTTP::Server (such as product_tokens) go to the superclass. Additionally, the behavior of the handle method is specific to this class: 

=over

=item handle

When invoked, this method enters into the typical accept loop in which it waits for a request on the socket that the daemon object maintains and deals with the content of the request. When all requests from the connection returned by the accept method of the HTTP::Daemon object have been processed, this method returns.

=back

=head4 REUSING SOCKETS ON RESTART

Often when implementing an HTTP daemon, sockets will get tied up when you try to restart the daemon server. This prevents the server from restarting. Often users will see an error like "Cannot start server: port already in use." To circumvent this, instruct SOAP::Lite to reuse open sockets using C<< Reuse => 1 >>:

  my $daemon = SOAP::Transport::HTTP::Daemon
                  -> new (LocalPort => 80000, Reuse => 1)

=head4 EXAMPLE DAEMON SERVER

  use SOAP::Transport::HTTP;
  # change LocalPort to 81 if you want to test it with soapmark.pl
  my $daemon = SOAP::Transport::HTTP::Daemon
    -> new (LocalAddr => 'localhost', LocalPort => 80)
    # specify list of objects-by-reference here 
    -> objects_by_reference(qw(My::PersistentIterator My::SessionIterator My::Chat))
    # specify path to My/Examples.pm here
    -> dispatch_to('/Your/Path/To/Deployed/Modules', 'Module::Name', 'Module::method') 
  ;
  print "Contact to SOAP server at ", $daemon->url, "\n";
  $daemon->handle;

=head3 SOAP::Transport::HTTP::Apache

Inherits from: L<SOAP::Transport::HTTP::Server>. 

This class provides an integration of the SOAP::Server base class with the mod_perl extension for Apache. To work as a location handler, the package provides a method called handler, for which handle is made an alias. The new method isn't functionally different from the superclass. Here are the other methods provided by this class: 

=over 

=item handler(I<Apache request>)

    $server->handler($r)

Defines the basis for a location handler in the mod_perl fashion. The method expects an Apache request object as the parameter, from which it pulls the body of the request and calls the superclass handle method.

Note that in this class, the local method named handle is aliased to this method.

=item configure(I<Apache request>)

    $server->configure(Apache->request);

Per-location configuration information can be provided to the server object using the Apache DirConfig directive and calling this method on the object itself. When invoked, the method reads the directory configuration information from Apache and looks for lines of the form:

    method => param

Each line that matches the pattern is regarded as a potential method to call on the server object, with the remaining token taken as the parameter to the method. Methods that take hash references as arguments may be specified as:

    method => key => param, key => param

The key/value pairs will be made into a hash reference on demand. If the server object doesn't recognize the named method as valid, it ignores the line.

=back

=head4 EXAMPLE APACHE MOD_PERL SERVER

See F<examples/server/Apache.pm> and L<Apache::SOAP> for more information.

B<httpd.conf>

  <Location /soap>
    SetHandler perl-script
    PerlHandler SOAP::Apache
    PerlSetVar options "compress_threshold => 10000"
  </Location>

B<SOAP::Apache.pm>

  package SOAP::Apache;
  use SOAP::Transport::HTTP;
  my $server = SOAP::Transport::HTTP::Apache
    ->dispatch_to('/Your/Path/To/Deployed/Modules', 'Module::Name', 'Module::method'); 
  sub handler { $server->handler(@_) }
  1;

See also L<Apache::SOAP>.

=head3 SOAP::Transport::HTTP::FCGI

Inherits from: L<SOAP::Transport::HTTP::CGI>. 

This is an extension of the SOAP::Transport::HTTP::CGI that implements the differences needed for the FastCGI protocol. None of the methods are functionally different. 

=head2 SOAP::Transport::IO

The SOAP::Transport::IO-based class allows for a sort of I/O proxying by allowing the application to configure what files or filehandles are used. This module supplies only a server class. 

=head3 SOAP::Transport::IO::Server

Inherits from: L<SOAP::Server>. 

The server class defined here inherits all methods from SOAP::Server, and adds two additional methods specific to the nature of the class: 

=over

=item in

    $server->in(IO::File->new($file));

Gets or sets the current filehandle being used as the input source.

=item out

    $server->out(\*STDERR);

Gets or sets the filehandle being used as the output destination.

=back

=head2 SOAP::Transport::JABBER

This class uses the Net::Jabber classes to abstract the Jabber protocol away from the direct notice of the application. Besides maintaining any needed objects internally, the package also uses a separate class as a proxy between communication layers, SOAP::Transport::JABBER::Query. The Jabber support provides both client and server classes. 

=head3 SOAP::Transport::JABBER::Client

Inherits from: L<SOAP::Client>, L<Net::Jabber::Client>. 
This class provides localized implementations for both the new and send_receive methods, neither of which are changed in terms of interface. The only difference is that the send_receive method doesn't directly use the action hash key on the input it receives. In addition to these two basic methods, the server class overrides the endpoint
method it would otherwise inherit from SOAP::Client: 

=over

=item endpoint

In the general sense, this still acts as a basic accessor method, with the same get value/set value behavior used consistently through the SOAP::Lite module. The difference between this version and most others is that when the endpoint is initially set or is changed, the client object makes the connection to the Jabber endpoint, sending the proper authentication credentials and setting up the conversation mechanism using the SOAP::Transport::JABBER::Query class as a delegate. It then calls the superclass endpoint method to ensure that all other related elements are taken care of.

=back

=head3 SOAP::Transport::JABBER::Server

Inherits from: L<SOAP::Server>. 

The server class provided for Jabber support defines a slightly different interface to the constructor. The server manages the Jabber communication by means of an internal Net::Jabber::Client instance. In a fashion similar to that used by SOAP::Transport::HTTP::Daemon, the server class catches methods that are meant for the Jabber client and treats them as if the class inherits directly from that class, without actually doing so. In doing so, the handle method is implemented as a frontend to the Process method of the Jabber client class. The difference in the interface to the constructor is: 

=over

=item new(I<URI>, I<optional server key/value options>)

    $srv = SOAP::Transport::JABBER::Server-> new($uri);

The constructor for the class expects that the first argument will be a Jabber-style URI, followed by the standard set of optional key/value pairs of method names and their parameters. All the method/parameter
pairs are delegated to the superclass constructor; only the Jabber URI is handled locally. It's used to set up the Net::Jabber::Client instance that manages the actual communications.

=back

=head2 SOAP::Transport::LOCAL

The SOAP::Transport::LOCAL module is designed to provide a no-transport client class for tracing and debugging communications traffic. It links SOAP::Client and SOAP::Server so that the same object that "sends" the request also "receives" it. 

=head3 SOAP::Transport::LOCAL::Client

Inherits from: L<SOAP::Client>, L<SOAP::Server>. 
The implementations of the new and send_receive methods aren't noticeably different in their interface. Their behavior warrants description, however: 

=over

=item new

When the constructor creates a new object of this class, it sets up a few things beyond the usual SOAP::Client layout. The is_success method is set to a default value of 1. The dispatch_to method inherited from SOAP::Server is called with the current value of the global array @INC, allowing the client to call any methods that can be found in the  current valid search path. And as with most of the constructors in this module, the optional key/value pairs are treated as method names and parameters.

=item send_receive

The implementation of this method simply passes the envelope portion of the input data to the handle method of SOAP::Server. While no network traffic results (directly) from this, it allows for debug signals to be sent through the SOAP::Trace facility.

=back

=head2 SOAP::Transport::MAILTO

This transport class manages SMTP-based sending of messages from a client perspective. It doesn't provide a server class. The class gets selected when a client object passes a URI to proxy or endpoint that starts with the characters, mailto:. 

=head3 SOAP::Transport::MAILTO::Client

Inherits from: L<SOAP::Client>. 

The client class for this protocol doesn't define any new methods. The constructor functions in the same style as the others class constructors. The functionality of the send_receive method is slightly different from other classes, however.

When invoked, the send_receive method uses the MIME::Lite package to encapsulate and transmit the message. Because mail messages are one-way communications (the reply being a separate process), there is no response message to be returned by the method. Instead, all the status-related attributes (code, message, status, is_success) are set, and no value is explicitly returned. 

=head2 SOAP::Transport::MQ

This class provides implementations of both client and server frameworks built on IBM's Message Queue set of classes. The SOAP objects encapsulate additional objects from these classes, creating and using them behind the scenes as needed. 

=head3 SOAP::Transport::MQ::Client

Inherits from: L<SOAP::Client>. 

The client class provides two methods specific to it, as well as specialized versions of the endpoint and send_receive methods. It also provides a localized new method, but the interface isn't changed from the superclass method. The new methods are: 

=over 

=item requestqueue

    $client->requestqueue->Put(message => $request);

Manages the MQSeries::Queue object the client uses for enqueuing requests to the server. In general, an application shouldn't need to directly access this attribute, let alone set it. If setting it, the new value should be an object of (or derived from) the MQSeries::Queue class.

=item replyqueue

    $client->replyqueue(MQSeries::Queue->new(%args));

Manages the queue object used for receiving messages back from the designated server (endpoint). It is also primarily for internal use, though if the application needs to set it explicitly, the new value should be an object of (or derived from) the MQSeries::Queue class.

=back

The two previous methods are mainly used by the localized versions of the methods: 

=over

=item endpoint

This accessor method has the same interface as other similar classes but is worth noting for the internal actions that take place. When the endpoint is set or changed, the method creates a queue-manager object (from the MQSeries::QueueManager class) and references this object when creating queues for replies and requests using the methods described earlier. The URI structure used with these classes (strings beginning with the characters mq://user@host:port) contains the information needed for these operations.

=item send_receive

This method uses the same interface as other classes, but makes use of only the endpoint and envelope keys in the hash-table input data. The endpoint key is needed only if the client wishes to switch endpoints prior to sending the message. The message (the value of the envelope key) is inserted into the queue stored in the requestqueue attribute. The client then waits for a reply to the message to appear in the queue stored in the replyqueue attribute.

=back

=head3 SOAP::Transport::MQ::Server

Inherits from: L<SOAP::Server>. 

The server class also defines requestqueue and replyqueue methods under the same terms as the client class. Of course, the server reads from the request queue and writes to the reply queue, the opposite of the client's behavior.
The methods whose functionality are worth noting are: 

=over

=item new(URI, optional parameters)

When called, the constructor creates the MQSeries::QueueManager object and the two MQSeries::Queue objects, similar to what the client does inside its endpoint method. Like the Jabber server described earlier, the first argument to this constructor is expected to be the URI that describes the server itself. The remainder of the arguments are treated as key/value pairs, as with other class constructors previously described.

=item handle

When this method is called, it attempts to read a pending message from the request-queue stored on the requestqueue attribute. The message itself is passed to the handle method of the superclass, and the result from that operation is enqueued to the replyqueue object. This process loops until no more messages are present in the request queue. The return value is the number of messages processed. The reads from the request queue are done in a nonblocking fashion, so if there is no message pending, the method immediately returns with a value of zero.

=back

=head2 SOAP::Transport::POP3

POP3 support is limited to a server implementation. Just as the MAILTO class detailed earlier operates by sending requests without expecting to process a response, the server described here accepts request messages and dispatches them without regard for sending a response other than that which POP3 defines for successful delivery of a message.

=head3 SOAP::Transport::POP3::Server

Inherits from: L<SOAP::Server>. 

The new method of this class creates an object of the Net::POP3 class to use internally for polling a specified POP3 server for incoming messages. When an object of this class is created, it expects an endpoint to be specified with a URI that begins with the characters pop:// and includes user ID and password information as well as the hostname itself. 

The handle method takes the messages present in the remote mailbox and passes them (one at a time) to the superclass handle method. Each message is deleted after being routed. All messages in the POP3 mailbox are presumed to be SOAP messages.

Methods for the Net::POP3 object are detected and properly routed, allowing operations such as $server->ping( ).

This means that the endpoint string doesn't need to provide the user ID and password because the login method from the POP3 API may be used directly. 

=head2 SOAP::Transport::TCP

The classes provided by this module implement direct TCP/IP communications methods for both clients and servers.

The connections don't use HTTP or any other higher-level protocol. These classes are selected when the client or server object being created uses an endpoint URI that starts with tcp://. Both client and server classes support using Secure Socket Layer if it is available. If any of the parameters to a new method from either of the classes begins with SSL_ (such as SSL_server in place of Server), the class attempts to load the IO::Socket::SSL package and use it to create socket objects. 

Both of the following classes catch methods that are intended for the socket objects and pass them along, allowing calls such as $client->accept( ) without including the socket class in the inheritance tree. 

=head3 SOAP::Transport::TCP::Client

Inherits from: L<SOAP::Client>. 

The TCP client class defines only two relevant methods beyond new and send_receive. These methods are: 

=over

=item SSL(I<optional new boolean value>)

    if ($client->SSL) # Execute only if in SSL mode

Reflects the attribute that denotes whether the client object is using SSL sockets for communications.

=item io_socket_class

    ($client->io_socket_class)->new(%options);

Returns the name of the class to use when creating socket objects for internal use in communications. As implemented, it returns one of IO::Socket::INET or IO::Socket::SSL, depending on the return value of the previous SSL method.

=back

If an application creates a subclass that inherits from this client class, either method is a likely target for overloading.

The new method behaves identically to most other classes, except that it detects the presence of SSL-targeted values in the parameter list and sets the SSL method appropriately if they are present. 

The send_receive method creates a socket of the appropriate class and connects to the configured endpoint. It then sets the socket to nonblocking I/O, sends the message, shuts down the client end of the connection (preventing further writing), and reads the response back from the server. The socket object is discarded after the response and
appropriate status codes are set on the client object.

=head3 SOAP::Transport::TCP::Server

Inherits from: L<SOAP::Server>. 

The server class also defines the same two additional methods as in the client class: 

=over

=item SSL(I<optional new boolean value>)

    if ($client->SSL) # Execute only if in SSL mode

Reflects the attribute that denotes whether the client object is using SSL sockets for communications.

=item io_socket_class

    ($client->io_socket_class)->new(%options);

Returns the name of the class to use when creating socket objects for internal use in communications. As implemented, it returns one of IO::Socket::INET or IO::Socket::SSL, depending on the return value of the previous SSL method. The new method also manages the automatic selection of SSL in the same fashion as the client class does. 

The handle method in this server implementation isn't designed to be called once with each new request. Rather, it is called with no arguments, at which time it enters into an infinite loop of waiting for a connection, reading the request, routing the request and sending back the serialized response. This continues until the process itself is interrupted by an untrapped signal or similar means. 

=back

=head1 ACKNOWLEDGEMENTS

Special thanks to O'Reilly publishing which has graciously allowed SOAP::Lite to republish and redistribute large excerpts from I<Programming Web Services with Perl>, mainly the SOAP::Lite reference found in Appendix B.

=head1 COPYRIGHT

Copyright (C) 2000-2004 Paul Kulchenko. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHORS

Paul Kulchenko (paulclinger@yahoo.com)

Randy J. Ray (rjray@blackperl.com)

Byrne Reese (byrne@majordojo.com)

=cut
