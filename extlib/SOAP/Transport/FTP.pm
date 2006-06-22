# ======================================================================
#
# Copyright (C) 2000-2001 Paul Kulchenko (paulclinger@yahoo.com)
# SOAP::Lite is free software; you can redistribute it
# and/or modify it under the same terms as Perl itself.
#
# $Id: FTP.pm,v 1.3 2004/11/14 19:30:50 byrnereese Exp $
#
# ======================================================================

package SOAP::Transport::FTP;

use strict;
use vars qw($VERSION);
#$VERSION = sprintf("%d.%s", map {s/_//g; $_} q$Name:  $ =~ /-(\d+)_([\d_]+)/);
$VERSION = $SOAP::Lite::VERSION;

use Net::FTP;
use IO::File;
use URI; 

# ======================================================================

package SOAP::Transport::FTP::Client;

use vars qw(@ISA);
@ISA = qw(SOAP::Client);

sub new { 
  my $self = shift;
  my $class = ref($self) || $self;

  unless (ref $self) {
    my $class = ref($self) || $self;
    my(@params, @methods);
    while (@_) { $class->can($_[0]) ? push(@methods, shift() => shift) : push(@params, shift) }
    $self = bless {@params} => $class;
    while (@methods) { my($method, $params) = splice(@methods,0,2);
      $self->$method(ref $params eq 'ARRAY' ? @$params : $params) 
    }
  }
  return $self;
}

sub send_receive {
  my($self, %parameters) = @_;
  my($envelope, $endpoint, $action) = 
    @parameters{qw(envelope endpoint action)};

  $endpoint ||= $self->endpoint; # ftp://login:password@ftp.something/dir/file

  my $uri = URI->new($endpoint);
  my($server, $auth) = reverse split /@/, $uri->authority;
  my $dir = substr($uri->path, 1, rindex($uri->path, '/'));
  my $file = substr($uri->path, rindex($uri->path, '/')+1);

  eval {
    my $ftp = Net::FTP->new($server, %$self) or die "Can't connect to $server: $@\n";
    $ftp->login(split /:/, $auth)            or die "Couldn't login\n";
    $dir and ($ftp->cwd($dir) or
              $ftp->mkdir($dir, 'recurse') and $ftp->cwd($dir) or die "Couldn't change directory to '$dir'\n");
  
    my $FH = IO::File->new_tmpfile; print $FH $envelope; $FH->flush; $FH->seek(0,0);
    $ftp->put($FH => $file)                  or die "Couldn't put file '$file'\n";
    $ftp->quit;
  };

  (my $code = $@) =~ s/\n$//;

  $self->code($code);
  $self->message($code);
  $self->is_success(!defined $code || $code eq '');
  $self->status($code);

  return;
}

# ======================================================================

1;

__END__
