package Archive::Extract;

use strict;

use Cwd                         qw[cwd];
use Carp                        qw[carp];
use IPC::Cmd                    qw[run can_run];
use FileHandle;
use File::Path                  qw[mkpath];
use File::Spec;
use File::Basename              qw[dirname basename];
use Params::Check               qw[check];
use Module::Load::Conditional   qw[can_load check_install];
use Locale::Maketext::Simple    Style => 'gettext';

### solaris has silly /bin/tar output ###
use constant ON_SOLARIS     => $^O eq 'solaris' ? 1 : 0;
use constant FILE_EXISTS    => sub { -e $_[0] ? 1 : 0 };

use constant TGZ            => 'tgz';
use constant TAR            => 'tar';
use constant GZ             => 'gz';
use constant ZIP            => 'zip';

use vars qw[$VERSION $PREFER_BIN $PROGRAMS $WARN $DEBUG];

$VERSION        = '0.08';
$PREFER_BIN     = 0;
$WARN           = 1;
$DEBUG          = 0;

local $Params::Check::VERBOSE = $Params::Check::VERBOSE = 1;

=pod

=head1 NAME

Archive::Extract -- A generic archive extracting mechanism

=head1 SYNOPSIS

    use Archive::Extract;

    ### build an Archive::Extract object ###
    my $ae = Archive::Extract->new( archive => 'foo.tgz' );

    ### extract to cwd() ###
    my $ok = $ae->extract;

    ### extract to /tmp ###
    my $ok = $ae->extract( to => '/tmp' );

    ### what if something went wrong?
    my $ok = $ae->extract or die $ae->error;

    ### files from the archive ###
    my $files   = $ae->files;

    ### dir that was extracted to ###
    my $outdir  = $ae->extract_path;


    ### quick check methods ###
    $ae->is_tar     # is it a .tar file?
    $ae->is_tgz     # is it a .tar.gz or .tgz file?
    $ae->is_gz;     # is it a .gz file?
    $ae->is_zip;    # is it a .zip file?

    ### absolute path to the archive you provided ###
    $ae->archive;

    ### commandline tools, if found ###
    $ae->bin_tar    # path to /bin/tar, if found
    $ae->bin_gzip   # path to /bin/gzip, if found
    $ae->bin_unzip  # path to /bin/unzip, if found

=head1 DESCRIPTION

Archive::Extract is a generic archive extraction mechanism.

It allows you to extract any archive file of the type .tar, .tar.gz,
.gz or .zip without having to worry how it does so, or use different
interfaces for each type by using either perl modules, or commandline
tools on your system.

See the C<HOW IT WORKS> section further down for details.

=cut


### see what /bin/programs are available ###
$PROGRAMS = {};
for my $pgm (qw[tar unzip gzip]) {
    $PROGRAMS->{$pgm} = can_run($pgm);
}

### mapping from types to extractor methods ###
my $Mapping = {
    is_tgz  => '_untar',
    is_tar  => '_untar',
    is_gz   => '_gunzip',
    is_zip  => '_unzip',
};

{
    my $tmpl = {
        archive => { required => 1, allow => FILE_EXISTS },
        type    => { default => '', allow => [qw|tgz tar zip gz|] },
    };

    ### build accesssors ###
    for my $method( keys %$tmpl,
                    qw[_extractor _gunzip_to files extract_path]
    ) {
        no strict 'refs';
        *$method = sub {
                        my $self = shift;
                        $self->{$method} = $_[0] if @_;
                        return $self->{$method};
                    }
    }

=head1 METHODS

=head2 $ae = Archive::Extract->new(archive => '/path/to/archive',[type => TYPE])

Creates a new C<Archive::Extract> object based on the archive file you
passed it. Automatically determines the type of archive based on the
extension, but you can override that by explicitly providing the
C<type> argument.

Valid values for C<type> are:

=over 4

=item tar

Standard tar files, as produced by, for example, C</bin/tar>.
Corresponds to a C<.tar> suffix.

=item tgz

Gzip compressed tar files, as produced by, for example C</bin/tar -z>.
Corresponds to a C<.tgz> or C<.tar.gz> suffix.

=item gz

Gzip compressed file, as produced by, for example C</bin/gzip>.
Corresponds to a C<.gz> suffix.

=item zip

Zip compressed file, as produced by, for example C</bin/zip>.
Corresponds to a C<.zip>, C<.jar> or C<.par> suffix.

=back

Returns a C<Archive::Extract> object on success, or false on failure.

=cut

    ### constructor ###
    sub new {
        my $class   = shift;
        my %hash    = @_;

        my $parsed = check( $tmpl, \%hash ) or return;

        ### make sure we have an absolute path ###
        my $ar = $parsed->{archive} = File::Spec->rel2abs( $parsed->{archive} );

        ### figure out the type, if it wasn't already specified ###
        unless ( $parsed->{type} ) {
            $parsed->{type} =
                $ar =~ /.+?\.(?:tar\.gz)|tgz$/i ? TGZ   :
                $ar =~ /.+?\.gz$/i              ? GZ    :
                $ar =~ /.+?\.tar$/i             ? TAR   :
                $ar =~ /.+?\.(zip|jar|par)$/i   ? ZIP   :
                '';

        }

        ### don't know what type of file it is ###
        return __PACKAGE__->_error(loc("Cannot determine file type for '%1'",
                                $parsed->{archive} )) unless $parsed->{type};

        return bless $parsed, $class;
    }
}

=head2 $ae->extract( [to => '/output/path'] )

Extracts the archive represented by the C<Archive::Extract> object to
the path of your choice as specified by the C<to> argument. Defaults to
C<cwd()>.

Since C<.gz> files never hold a directory, but only a single file; if 
the C<to> argument is an existing directory, the file is extracted 
there, with it's C<.gz> suffix stripped. 
If the C<to> argument is not an existing directory, the C<to> argument 
is understood to be a filename, if the archive type is C<gz>. 
In the case that you did not specify a C<to> argument, the output
file will be the name of the archive file, stripped from it's C<.gz>
suffix, in the current working directory.

C<extract> will try a pure perl solution first, and then fall back to
commandline tools if they are available. See the C<GLOBAL VARIABLES>
section below on how to alter this behaviour.

It will return true on success, and false on failure.

On success, it will also set the follow attributes in the object:

=over 4

=item $ae->extract_path

This is the directory that the files where extracted to.

=item $ae->files

This is an array ref with the paths of all the files in the archive,
relative to the C<to> argument you specified.
To get the full path to an extracted file, you would use:

    File::Spec->catfile( $to, $ae->files->[0] );

Note that all files from a tar archive will be in unix format, as per
the tar specification.

=back

=cut

sub extract {
    my $self = shift;
    my %hash = @_;

    my $to;
    my $tmpl = {
        to  => { default => '.', store => \$to }
    };

    check( $tmpl, \%hash ) or return;

    ### so 'to' could be a file or a dir, depending on whether it's a .gz 
    ### file, or basically anything else.
    ### so, check that, then act accordingly.
    ### set an accessor specifically so _gunzip can know what file to extract
    ### to.
    my $dir;
    {   ### a foo.gz file
        if( $self->is_gz ) {
    
            my $cp = $self->archive; $cp =~ s/\.gz$//i;
        
            ### to is a dir?
            if ( -d $to ) {
                $dir = $to; 
                $self->_gunzip_to( basename($cp) );

            ### then it's a filename
            } else {
                $dir = dirname($to);
                $self->_gunzip_to( basename($to) );
            }

        ### not a foo.gz file
        } else {
            $dir = $to;
        }
    }

    ### make the dir if it doesn't exist ###
    unless( -d $dir ) {
        eval { mkpath( $dir ) };

        return $self->_error(loc("Could not create path '%1': %2", $dir, $@))
            if $@;
    }

    ### get the current dir, to restore later ###
    my $cwd = cwd();

    my $ok = 1;
    EXTRACT: {

        ### chdir to the target dir ###
        unless( chdir $dir ) {
            $self->_error(loc("Could not chdir to '%1': %2", $dir, $!));
            $ok = 0; last EXTRACT;
        }

        ### find what extractor method to use ###
        while( my($type,$method) = each %$Mapping ) {

            ### call the corresponding method if the type is OK ###
            if( $self->$type) {
                $ok = $self->$method();
            }
        }

        ### warn something went wrong if we didn't get an OK ###
        $self->_error(loc("Extract failed, no extractor found"))
            unless $ok;

    }

    ### and chdir back ###
    unless( chdir $cwd ) {
        $self->_error(loc("Could not chdir back to start dir '%1': %2'",
                            $cwd, $!));
    }

    return $ok;
}

=pod

=head1 ACCESSORS

=head2 $ae->error([BOOL])

Returns the last encountered error as string.
Pass it a true value to get the C<Carp::longmess()> output instead.

=head2 $ae->extract_path

This is the directory the archive got extracted to.
See C<extract()> for details.

=head2 $ae->files

This is an array ref holding all the paths from the archive.
See C<extract()> for details.

=head2 $ae->archive

This is the full path to the archive file represented by this
C<Archive::Extract> object.

=head2 $ae->type

This is the type of archive represented by this C<Archive::Extract>
object. See accessors below for an easier way to use this.
See the C<new()> method for details.

=head2 $ae->is_tgz

Returns true if the file is of type C<.tar.gz>.
See the C<new()> method for details.

=head2 $ae->is_tar

Returns true if the file is of type C<.tar>.
See the C<new()> method for details.

=head2 $ae->is_gz

Returns true if the file is of type C<.gz>.
See the C<new()> method for details.

=head2 $ae->is_zip

Returns true if the file is of type C<.zip>.
See the C<new()> method for details.

=cut

### quick check methods ###
sub is_tgz  { return $_[0]->type eq TGZ }
sub is_tar  { return $_[0]->type eq TAR }
sub is_gz   { return $_[0]->type eq GZ  }
sub is_zip  { return $_[0]->type eq ZIP }

=pod

=head2 $ae->bin_tar

Returns the full path to your tar binary, if found.

=head2 $ae->bin_gzip

Returns the full path to your gzip binary, if found

=head2 $ae->bin_unzip

Returns the full path to your unzip binary, if found

=cut

### paths to commandline tools ###
sub bin_gzip    { return $PROGRAMS->{'gzip'}    if $PROGRAMS->{'gzip'}  }
sub bin_unzip   { return $PROGRAMS->{'unzip'}   if $PROGRAMS->{'unzip'} }
sub bin_tar     { return $PROGRAMS->{'tar'}     if $PROGRAMS->{'tar'}   }


#################################
#
# Untar code
#
#################################


### untar wrapper... goes to either Archive::Tar or /bin/tar
### depending on $PREFER_BIN
sub _untar {
    my $self = shift;

    my @methods = qw[_untar_at _untar_bin];
       @methods = reverse @methods if $PREFER_BIN;

    for my $method (@methods) {
        $self->_extractor($method) && return 1 if $self->$method();
    }

    return $self->_error(loc("Unable to untar file '%1'", $self->archive));
}

### use /bin/tar to extract ###
sub _untar_bin {
    my $self = shift;

    ### check for /bin/tar ###
    return $self->_error(loc("No '%1' program found", '/bin/tar'))
        unless $self->bin_tar;

    ### check for /bin/gzip if we need it ###
    return $self->_error(loc("No '%1' program found", '/bin/gzip'))
        if $self->is_tgz && !$self->bin_gzip;

    ### XXX figure out how to make IPC::Run do this in one call --
    ### currently i don't know how to get output of a command after a pipe
    ### trapped in a scalar. Mailed barries about this 5th of june 2004.



    ### see what command we should run, based on whether
    ### it's a .tgz or .tar

    ### XXX solaris tar and bsdtar are having different outputs
    ### depending whether you run with -x or -t
    ### compensate for this insanity by running -t first, then -x
    {    my $cmd = $self->is_tgz
            ? [$self->bin_gzip, '-cdf', $self->archive, '|',
               $self->bin_tar, '-tf', '-']
            : [$self->bin_tar, '-tf', $self->archive];

        ### run the command ###
        my $buffer = '';
        unless( scalar run( command => $cmd,
                            buffer  => \$buffer,
                            verbose => $DEBUG )
        ) {
            return $self->_error(loc(
                            "Error listing contents of archive '%1': %2",
                            $self->archive, $buffer ));
        }

        unless( $buffer ) {
            $self->_error(loc("No buffer captured, unable to tell ".
                              "extracted files or extraction dir for '%1'",
                              $self->archive));
        } else {
            ### if we're on solaris we /might/ be using /bin/tar, which has
            ### a weird output format... we might also be using
            ### /usr/local/bin/tar, which is gnu tar, which is perfectly
            ### fine... so we have to do some guessing here =/
            my @files = map { chomp;
                          !ON_SOLARIS ? $_
                                      : (m|^ x \s+  # 'xtract' -- sigh
                                            (.+?),  # the actual file name
                                            \s+ [\d,.]+ \s bytes,
                                            \s+ [\d,.]+ \s tape \s blocks
                                        |x ? $1 : $_);

                    } split $/, $buffer;

            ### store the files that are in the archive ###
            $self->files(\@files);
        }
    }

    ### now actually extract it ###
    {   my $cmd = $self->is_tgz
            ? [$self->bin_gzip, '-cdf', $self->archive, '|',
               $self->bin_tar, '-xf', '-']
            : [$self->bin_tar, '-xf', $self->archive];

        my $buffer = '';
        unless( scalar run( command => $cmd,
                            buffer  => \$buffer,
                            verbose => $DEBUG )
        ) {
            return $self->_error(loc("Error extracting archive '%1': %2",
                            $self->archive, $buffer ));
        }

        ### we might not have them, due to lack of buffers
        if( $self->files ) {
            ### now that we've extracted, figure out where we extracted to
            my $dir = $self->__get_extract_dir( $self->files );
    
            ### store the extraction dir ###
            $self->extract_path( $dir );
        }
    }

    ### we got here, no error happened
    return 1;
}

### use archive::tar to extract ###
sub _untar_at {
    my $self = shift;

    ### we definitely need A::T, so load that first
    {   my $use_list = { 'Archive::Tar' => '0.0' };

        unless( can_load( modules => $use_list ) ) {

            return $self->_error(loc("You do not have '%1' installed - " .
                                 "Please install it as soon as possible.",
                                 'Archive::Tar'));
        }
    }

    ### we will need Compress::Zlib too, if it's a tgz... and IO::Zlib
    ### if A::T's version is 0.99 or higher
    if( $self->is_tgz ) {
        my $use_list = { 'Compress::Zlib' => '0.0' };
           $use_list->{ 'IO::Zlib' } = '0.0'
                if $Archive::Tar::VERSION >= '0.99';

        unless( can_load( modules => $use_list ) ) {
            my $which = join '/', sort keys %$use_list;

            return $self->_error(loc(
                                "You do not have '%1' installed - Please ".
                                "install it as soon as possible.", $which));

        }
    }

    my $tar = Archive::Tar->new();

    unless( $tar->read( $self->archive, $self->is_tgz ) ) {
        return $self->_error(loc("Unable to read '%1': %2", $self->archive,
                                    $Archive::Tar::error));
    }

    ### workaround to prevent Archive::Tar from setting uid, which
    ### is a potential security hole. -autrijus
    ### have to do it here, since A::T needs to be /loaded/ first ###
    {   no strict 'refs'; local $^W;

        ### older versions of archive::tar <= 0.23
        *Archive::Tar::chown = sub {};
    }

    ### for version of archive::tar > 1.04
    local $Archive::Tar::Constant::CHOWN = 0;

    {   local $^W;  # quell 'splice() offset past end of array' warnings
                    # on older versions of A::T

        ### older archive::tar always returns $self, return value slightly
        ### fux0r3d because of it.
        $tar->extract()
            or return $self->_error(loc("Unable to extract '%1': %2",
                                    $self->archive, $Archive::Tar::error ));
    }

    my @files   = $tar->list_files;
    my $dir     = $self->__get_extract_dir( \@files );

    ### store the files that are in the archive ###
    $self->files(\@files);

    ### store the extraction dir ###
    $self->extract_path( $dir );

    ### check if the dir actually appeared ###
    return 1 if -d $self->extract_path;

    ### no dir, we failed ###
    return $self->_error(loc("Unable to extract '%1': %2",
                                $self->archive, $Archive::Tar::error ));
}

#################################
#
# Gunzip code
#
#################################

### gunzip wrapper... goes to either Compress::Zlib or /bin/gzip
### depending on $PREFER_BIN
sub _gunzip {
    my $self = shift;

    my @methods = qw[_gunzip_cz _gunzip_bin];
       @methods = reverse @methods if $PREFER_BIN;

    for my $method (@methods) {
        $self->_extractor($method) && return 1 if $self->$method();
    }

    return $self->_error(loc("Unable to gunzip file '%1'", $self->archive));
}

sub _gunzip_bin {
    my $self = shift;

    ### check for /bin/gzip -- we need it ###
    return $self->_error(loc("No '%1' program found", '/bin/gzip'))
        unless $self->bin_gzip;


    my $fh = FileHandle->new('>'. $self->_gunzip_to) or
        return $self->_error(loc("Could not open '%1' for writing: %2",
                            $self->_gunzip_to, $! ));

    my $cmd = [ $self->bin_gzip, '-cdf', $self->archive ];

    my $buffer;
    unless( scalar run( command => $cmd,
                        verbose => $DEBUG,
                        buffer  => \$buffer )
    ) {
        return $self->_error(loc("Unable to gunzip '%1': %2",
                                    $self->archive, $buffer));
    }

    unless( $buffer ) {
        $self->_error(loc("No buffer captured, unable to get content for '%1'",
                          $self->archive));
    }

    print $fh $buffer if defined $buffer;

    close $fh;

    ### set what files where extract, and where they went ###
    $self->files( [$self->_gunzip_to] );
    $self->extract_path( File::Spec->rel2abs(cwd()) );

    return 1;
}

sub _gunzip_cz {
    my $self = shift;

    my $use_list = { 'Compress::Zlib' => '0.0' };
    unless( can_load( modules => $use_list ) ) {
        return $self->_error(loc("You do not have '%1' installed - Please " .
                        "install it as soon as possible.", 'Compress::Zlib'));
    }

    my $gz = Compress::Zlib::gzopen( $self->archive, "rb" ) or
                return $self->_error(loc("Unable to open '%1': %2",
                            $self->archive, $Compress::Zlib::gzerrno));

    my $fh = FileHandle->new('>'. $self->_gunzip_to) or
        return $self->_error(loc("Could not open '%1' for writing: %2",
                            $self->_gunzip_to, $! ));

    my $buffer;
    $fh->print($buffer) while $gz->gzread($buffer) > 0;
    $fh->close;

    ### set what files where extract, and where they went ###
    $self->files( [$self->_gunzip_to] );
    $self->extract_path( File::Spec->rel2abs(cwd()) );

    return 1;
}

#################################
#
# Unzip code
#
#################################

### unzip wrapper... goes to either Archive::Zip or /bin/unzip
### depending on $PREFER_BIN
sub _unzip {
    my $self = shift;

    my @methods = qw[_unzip_az _unzip_bin];
       @methods = reverse @methods if $PREFER_BIN;

    for my $method (@methods) {
        $self->_extractor($method) && return 1 if $self->$method();
    }

    return $self->_error(loc("Unable to gunzip file '%1'", $self->archive));
}

sub _unzip_bin {
    my $self = shift;

    ### check for /bin/gzip if we need it ###
    return $self->_error(loc("No '%1' program found", '/bin/unzip'))
        unless $self->bin_unzip;


    ### first, get the files.. it must be 2 different commands with 'unzip' :(
    {   my $cmd = [ $self->bin_unzip, '-Z', '-1', $self->archive ];

        my $buffer;
        unless( scalar run( command => $cmd,
                            verbose => $DEBUG,
                            buffer  => \$buffer )
        ) {
            return $self->_error(loc("Unable to unzip '%1': %2",
                                        $self->archive, $buffer));
        }

        unless( $buffer ) {
            $self->_error(loc("No buffer captured, unable to tell extracted ".
                              "files or extraction dir for '%1'",
                              $self->archive));

        } else {
            $self->files( [split $/, $buffer] );
        }
    }

    ### now, extract the archive ###
    {   my $cmd = [ $self->bin_unzip, '-qq', $self->archive ];

        my $buffer;
        unless( scalar run( command => $cmd,
                            verbose => $DEBUG,
                            buffer  => \$buffer )
        ) {
            return $self->_error(loc("Unable to unzip '%1': %2",
                                        $self->archive, $buffer));
        }

        if( scalar @{$self->files} ) {
            my $files   = $self->files;
            my $dir     = $self->__get_extract_dir( $files );

            $self->extract_path( $dir );
        }
    }

    return 1;
}

sub _unzip_az {
    my $self = shift;

    my $use_list = { 'Archive::Zip' => '0.0' };
    unless( can_load( modules => $use_list ) ) {
        return $self->_error(loc("You do not have '%1' installed - Please " .
                        "install it as soon as possible.", 'Archive::Zip'));
    }

    my $zip = Archive::Zip->new();

    unless( $zip->read( $self->archive ) == &Archive::Zip::AZ_OK ) {
        return $self->_error(loc("Unable to read '%1'", $self->archive));
    }

    my @files;
    ### have to extract every memeber individually ###
    for my $member ($zip->members) {
        push @files, $member->{fileName};

        unless( $zip->extractMember($member) == &Archive::Zip::AZ_OK ) {
            return $self->_error(loc("Extraction of '%1' from '%2' failed",
                        $member->{fileName}, $self->archive ));
        }
    }

    my $dir = $self->__get_extract_dir( \@files );

    ### set what files where extract, and where they went ###
    $self->files( \@files );
    $self->extract_path( File::Spec->rel2abs($dir) );

    return 1;
}

sub __get_extract_dir {
    my $self    = shift;
    my $files   = shift or return;

    my($dir1, $dir2);
    for my $aref ( [ \$dir1, 0 ], [ \$dir2, -1 ] ) {
        my($dir,$pos) = @$aref;

        ### add a catdir(), so that any trailing slashes get
        ### take care of (removed)
        my $res = -d $files->[$pos]
                    ? File::Spec->catdir( $files->[$pos], '' )
                    : dirname( $files->[$pos] );

        $$dir = $res;
    }

    ### if the first and last dir don't match, make sure the 
    ### dirname is not set wrongly
    my $dir;
 
    ### dirs are the same, so we know for sure what the extract dir is
    if( $dir1 eq $dir2 ) {
        $dir = $dir1;
    
    ### dirs are different.. do they share the base dir?
    ### if so, use that, if not, fall back to '.'
    } else {
        my $base1 = [ File::Spec->splitdir( $dir1 ) ]->[0];
        my $base2 = [ File::Spec->splitdir( $dir2 ) ]->[0];
        
        $dir = File::Spec->rel2abs( $base1 eq $base2 ? $base1 : '.' ); 
    }        

    return File::Spec->rel2abs( $dir );
}


#################################
#
# Error code
#
#################################

### Error handling, the way Archive::Tar does it ###
{
    my $error       = '';
    my $longmess    = '';

    sub _error {
        my $self    = shift;
        $error      = shift;
        $longmess   = Carp::longmess($error);

        ### set Archive::Tar::WARN to 0 to disable printing
        ### of errors
        if( $WARN ) {
            carp $DEBUG ? $longmess : $error;
        }

        return;
    }

    sub error {
        my $self = shift;
        return shift() ? $longmess : $error;
    }
}

1;

=pod

=head1 HOW IT WORKS

C<Archive::Extract> tries first to determine what type of archive you
are passing it, by inspecting its suffix. It does not do this by using
Mime magic, or something related. See C<CAVEATS> below.

Once it has determined the file type, it knows which extraction methods
it can use on the archive. It will try a perl solution first, then fall
back to a commandline tool if that fails. If that also fails, it will
return false, indicating it was unable to extract the archive.
See the section on C<GLOBAL VARIABLES> to see how to alter this order.

=head1 CAVEATS

C<Archive::Extract> trusts on the extension of the archive to determine
what type it is, and what extractor methods therefore can be used. If
your archives do not have any of the extensions as described in the
C<new()> method, you will have to specify the type explicitly, or
C<Archive::Extract> will not be able to extract the archive for you.

=head1 GLOBAL VARIABLES

=head2 $Archive::Extract::DEBUG

Set this variable to C<true> to have all calls to command line tools
be printed out, including all their output.
This also enables C<Carp::longmess> errors, instead of the regular
C<carp> errors.

Good for tracking down why things don't work with your particular
setup.

Defaults to C<false>.

=head2 $Archive::Extract::WARN

This variable controls whether errors encountered internally by
C<Archive::Extract> should be C<carp>'d or not.

Set to false to silence warnings. Inspect the output of the C<error()>
method manually to see what went wrong.

Defaults to C<true>.

=head2 $Archive::Extract::PREFER_BIN

This variables controls whether C<Archive::Extract> should prefer the
use of perl modules, or commandline tools to extract archives.

Set to C<true> to have C<Archive::Extract> prefer commandline tools.

Defaults to C<false>.

=head1 TODO

=over 4

=item bzip2 support

Right now, bzip2 (.bz2/tar.bz2/tbz) files are completely unsupported.

=item Mime magic support

Maybe this module should use something like C<File::Type> to determine
the type, rather than blindly trust the suffix.

=head1 AUTHORS

This module by
Jos Boumans E<lt>kane@cpan.orgE<gt>.

=head1 COPYRIGHT

This module is
copyright (c) 2004 Jos Boumans E<lt>kane@cpan.orgE<gt>.
All rights reserved.

This library is free software;
you may redistribute and/or modify it under the same
terms as Perl itself.

=cut

# Local variables:
# c-indentation-style: bsd
# c-basic-offset: 4
# indent-tabs-mode: nil
# End:
# vim: expandtab shiftwidth=4:

