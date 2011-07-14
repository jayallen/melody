# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::Image;

use strict;
use MT;
use base qw( MT::ErrorHandler );

sub new {
    my $class = shift;
    $class .= "::" . MT->config->ImageDriver;
    my $image = bless {}, $class;
    $image->load_driver or return $class->error( $image->errstr );
    if (@_) {
        $image->init(@_) or return $class->error( $image->errstr );
    }
    $image;
}

sub get_dimensions {
    my $image = shift;
    my %param = @_;
    my ( $w, $h ) = ( $image->{width}, $image->{height} );
    if ( my $pct = $param{Scale} ) {
        ( $w, $h ) = ( int( $w * $pct / 100 ), int( $h * $pct / 100 ) );
    }
    else {
        if ( $param{Width} && $param{Height} ) {
            ( $w, $h ) = ( $param{Width}, $param{Height} );
        }
        else {
            my $x = $param{Width}  || $w;
            my $y = $param{Height} || $h;
            my $w_pct = $x / $w;
            my $h_pct = $y / $h;
            my $pct   = $param{Width} ? $w_pct : $h_pct;
            ( $w, $h ) = ( int( $w * $pct ), int( $h * $pct ) );
        }
    }
    ( $w, $h );
} ## end sub get_dimensions

sub inscribe_square {
    my $class  = shift;
    my %params = @_;
    my ( $w, $h ) = @params{qw( Width Height )};

    my ( $dim, $x, $y );

    if ( $w > $h ) {
        $dim = $h;
        $x   = int( ( $w - $dim ) / 2 );
        $y   = 0;
    }
    else {
        $dim = $w;
        $x   = 0;
        $y   = int( ( $h - $dim ) / 2 );
    }

    return ( Size => $dim, X => $x, Y => $y );
} ## end sub inscribe_square

sub make_square {
    my $image = shift;
    my %square =
      $image->inscribe_square( Width  => $image->{width},
                               Height => $image->{height}, );
    $image->crop(%square);
}

sub check_upload {
    my $class      = shift;
    my %params     = @_;
    my $fh         = $params{Fh};
    my $ext        = $params{ext};
    my $local_base = $params{LocalBase};
    my $local      = $params{Local};

    ###
    #
    # Function to evaluate content of an image file to see if it contains HTML
    # or JavaScript content in the first 1K bytes.  Image files that contain
    # embedded HTML or JavaScript are prohibited in order to prevent a known
    # IE 6 and 7 content-sniffing vulnerability.
    #
    # This code based on the ImageValidate plugin written by Six Apart.
    #
    ###

    if ( $ext =~ m/(jpe?g|png|gif|bmp|tiff?|ico)/i ) {

        my %sig_args = $fh ? ( fh => $fh ) : $local ? ( path => $local ) : ();
        die 'No filehandle or path provided' unless keys %sig_args;

        my $has_html = $class->has_html_signature(%sig_args);
        $has_html and return $class->errtrans("Invalid upload file");

        unless ( defined($has_html) ) {
            return
              $class->errtrans( 'Error reading image [_1]: [_2]',
                                $local_base, $class->errstr );
        }
    }

    ## Use Image::Size to check if the uploaded file is an image, and if so,
    ## record additional image info (width, height). We first rewind the
    ## filehandle $fh, then pass it in to imgsize.
    seek $fh, 0, 0;
    eval { require Image::Size; };
    $@
      and return $class->errtrans(
                           "Perl module Image::Size is required to determine "
                             . "width and height of uploaded images." );

    my ( $w, $h, $id ) = Image::Size::imgsize($fh);

    my $write_file = sub {
        $params{Fmgr}->put( $fh, $params{Local}, 'upload' );
    };

    ## Check file size?
    my $file_size;
    if ( $params{Max} ) {
        ## Seek to the end of the handle to find the size.
        seek $fh, 0, 2;    # wind to end
        $file_size = tell $fh;
        seek $fh, 0, 0;
    }

    ## If the image exceeds the dimension limit, resize it before writing.
    if ( my $max_dim = $params{MaxDim} ) {
        if (    defined($w)
             && defined($h)
             && ( $w > $max_dim || $h > $max_dim ) )
        {
            my $uploaded_data = eval { local $/; <$fh> };
            my $img = $class->new( Data => $uploaded_data )
              or return $class->error( $class->errstr );

            if ( $params{Square} ) {
                ( undef, $w, $h ) = $img->make_square()
                  or return $class->error( $img->errstr );
            }
            ( my ($resized_data), $w, $h )
              = $img->scale(
                            ( ( $w > $h ) ? 'Width' : 'Height' ) => $max_dim )
              or return $class->error( $img->errstr );

            $write_file = sub {
                $params{Fmgr}
                  ->put_data( $resized_data, $params{Local}, 'upload' );
            };
            $file_size = length $resized_data;
        } ## end if ( defined($w) && defined...)
    } ## end if ( my $max_dim = $params...)

    if ( my $max_size = $params{Max} ) {
        if ( $max_size < $file_size ) {
            return
              $class->error(
                         MT->translate(
                             "File size exceeds maximum allowed: [_1] > [_2]",
                             $file_size, $max_size
                         )
              );
        }
    }

    ( $w, $h, $id, $write_file );
} ## end sub check_upload

sub has_html_signature {
    my $class = shift;
    my %args  = @_;
    my ( $fh, $data, $path ) = @args{ 'fh', 'data', 'path' };

    unless ( $data || $fh || $path ) {
        return $class->errtrans(
                "No valid arguments passed to MT::Image::has_html_signature");
    }

    # Convert path to filehandle if provided
    if ( defined $path ) {
        use Symbol;
        $fh = gensym();
        open $fh, $path
          or return $class->errtrans("Could not open $path for reading: $!");
        binmode($fh);
    }

    die "No valid arguments passed to MT::Image::has_html_signature"
      unless $data
          or $fh;

    my @patterns = (

        # NOTE: The following patterns will be matched against a string
        # with all whitespace stripped to simplify HTML matching.
        qr{
            \A       # Start of string
            <        # Opening angle bracket = HTML tag?
            (        # First item below matches doctype and/or PHP
                [!?]|frameset|iframe|link|base|style|div|p|font|
                applet|meta|center|form|isindex|h[123456]|b|br
            )
        }ix, qr{<(html|script|title|body|head|plaintext|table|img|pre|a)}i,
        qr{text/html}i,
    );

    # Anonymous subroutine that reads N bytes from either the string in
    # $data or the filehandle in $fh.
    my $buffer_read;
    my $read_buffer = sub {
        my $buffer = shift;
        defined $data and return substr( $data, 0, $buffer );
        my $str;
        seek( $fh, 0, 0 );
        defined( $buffer_read = read( $fh, $str, $buffer ) )
          || die "Could not read filehandle: $!";

        # print STDERR "read_buffer: $buffer, buffer_read: $buffer_read\n";
        seek( $fh, 0, 0 );
        return $str;
    };

    # Get 1024 bytes of whitespace-free content
    my $buffer = 1024;
    my $test_string;
    while ( !defined $test_string ) {
        my $str = $read_buffer->($buffer);
        $str =~ s{\s}{}g;    # Strip whitespace,

        # If result string is long enough, trim down to 1024 and assign
        # to $test_string which will terminate the while loop
        if ( length $str >= 1024 ) {
            $test_string = substr( $str, 0, 1024 );
        }

        # File is shorter than our buffer
        elsif ( $buffer_read < 1024 ) {
            $test_string = $str;
        }

        # Otherwise, increase the buffer size by 1024 and repeat
        else {
            $buffer += 1024;
        }
    } ## end while ( !defined $test_string)

    return scalar grep { $test_string =~ $_ } @patterns;

} ## end sub has_html_signature

package MT::Image::ImageMagick;
@MT::Image::ImageMagick::ISA = qw( MT::Image );

sub load_driver {
    my $image = shift;
    eval { require Image::Magick };
    if ( my $err = $@ ) {
        return $image->error(
                    MT->translate( "Can't load Image::Magick: [_1]", $err ) );
    }
    1;
}

sub init {
    my $image = shift;
    my %param = @_;
    my %arg   = ();
    if ( my $type = $param{Type} ) {
        %arg = ( magick => lc($type) );
    }
    elsif ( my $file = $param{Filename} ) {
        ( my $ext = $file ) =~ s/.*\.//;
        %arg = ( magick => lc($ext) );
    }
    my $magick = $image->{magick} = Image::Magick->new(%arg);
    if ( my $file = $param{Filename} ) {
        my $x = $magick->Read($file);
        return $image->error(
              MT->translate( "Reading file '[_1]' failed: [_2]", $file, $x ) )
          if $x;
        ( $image->{width}, $image->{height} )
          = $magick->Get( 'width', 'height' );
    }
    elsif ( $param{Data} ) {
        my $x = $magick->BlobToImage( $param{Data} );
        return $image->error(
                           MT->translate( "Reading image failed: [_1]", $x ) )
          if $x;
        ( $image->{width}, $image->{height} )
          = $magick->Get( 'width', 'height' );
    }
    $image;
} ## end sub init

sub scale {
    my $image = shift;
    my ( $w, $h ) = $image->get_dimensions(@_);
    my $magick = $image->{magick};
    my $err
      = $magick->can('Resize')
      ? $magick->Resize( width => $w, height => $h )
      : $magick->Scale( width => $w, height => $h );
    return $image->error(
          MT->translate( "Scaling to [_1]x[_2] failed: [_3]", $w, $h, $err ) )
      if $err;
    $magick->Profile("*") if $magick->can('Profile');
    ( $image->{width}, $image->{height} ) = ( $w, $h );
    wantarray ? ( $magick->ImageToBlob, $w, $h ) : $magick->ImageToBlob;
}

sub crop {
    my $image = shift;
    my %param = @_;
    my ( $size, $x, $y ) = @param{qw( Size X Y )};
    my $magick = $image->{magick};

    my $err
      = $magick->Crop( width => $size, height => $size, x => $x, y => $y );
    return
      $image->error(
           MT->translate(
                      "Cropping a [_1]x[_1] square at [_2],[_3] failed: [_4]",
                      $size, $x, $y, $err
           )
      ) if $err;

    ## Remove page offsets from the original image, per this thread:
    ## http://studio.imagemagick.org/pipermail/magick-users/2003-September/010803.html
    $magick->Set( page => '+0+0' );

    ( $image->{width}, $image->{height} ) = ( $size, $size );
    wantarray ? ( $magick->ImageToBlob, $size, $size ) : $magick->ImageToBlob;
} ## end sub crop

sub convert {
    my $image = shift;
    my %param = @_;
    my $type  = $param{Type};

    my $magick = $image->{magick};
    my $err = $magick->Set( magick => uc $type );
    return $image->error(
         MT->translate( "Converting image to [_1] failed: [_2]", $type, $err )
    ) if $err;

    $magick->ImageToBlob;
}

package MT::Image::NetPBM;
@MT::Image::NetPBM::ISA = qw( MT::Image );

sub load_driver {
    my $image = shift;
    eval { require IPC::Run };
    if ( my $err = $@ ) {
        return $image->error(
                         MT->translate( "Can't load IPC::Run: [_1]", $err ) );
    }
    my $pbm = $image->_find_pbm or return;
    1;
}

sub init {
    my $image = shift;
    my %param = @_;
    if ( my $file = $param{Filename} ) {
        $image->{file} = $file;
        if ( !defined $param{Type} ) {
            ( my $ext = $file ) =~ s/.*\.//;
            $param{Type} = uc $ext;
        }
    }
    elsif ( my $blob = $param{Data} ) {
        $image->{data} = $blob;
    }
    my %Types
      = ( jpg => 'jpeg', jpeg => 'jpeg', gif => 'gif', 'png' => 'png' );
    my $type = $image->{type} = $Types{ lc $param{Type} };
    if ( !$type ) {
        return $image->error(
                MT->translate( "Unsupported image file type: [_1]", $type ) );
    }
    my ( $out, $err );
    my $pbm = $image->_find_pbm or return;
    my @in = ( "$pbm${type}topnm", ( $image->{file} ? $image->{file} : () ) );
    my @out = ( "${pbm}pnmfile", '-allimages' );
    IPC::Run::run( \@in, '<', ( $image->{file} ? \undef : \$image->{data} ),
                   '|', \@out, \$out, \$err )
      or return $image->error(
                        MT->translate( "Reading image failed: [_1]", $err ) );
    ( $image->{width}, $image->{height} ) = $out =~ /(\d+)\s+by\s+(\d+)/;
    $image;
} ## end sub init

sub scale {
    my $image = shift;
    my ( $w, $h ) = $image->get_dimensions(@_);
    my $type = $image->{type};
    my ( $out, $err );
    my $pbm = $image->_find_pbm or return;
    my @in = (
               "$pbm${type}topnm",
               ( $image->{data} ? () : $image->{file} ? $image->{file} : () )
    );
    my @scale = ( "${pbm}pnmscale", '-width', $w, '-height', $h );
    my @out;

    for my $try (qw( ppm pnm )) {
        my $prog = "${pbm}${try}to$type";
        @out = ($prog), last if -x $prog;
    }
    my (@quant);
    if ( $type eq 'gif' ) {
        push @quant, ( [ "${pbm}ppmquant", 256 ], '|' );
    }
    IPC::Run::run( \@in, '<', ( $image->{data} ? \$image->{data} : \undef ),
                   '|', \@scale, '|', @quant, \@out, \$out, \$err )
      or return $image->error(
         MT->translate( "Scaling to [_1]x[_2] failed: [_3]", $w, $h, $err ) );
    ( $image->{width}, $image->{height}, $image->{data} ) = ( $w, $h, $out );
    wantarray ? ( $out, $w, $h ) : $out;
} ## end sub scale

sub crop {
    my $image = shift;
    my %param = @_;
    my ( $size, $x, $y ) = @param{qw( Size X Y )};

    my ( $w, $h ) = $image->get_dimensions(@_);
    my $type = $image->{type};
    my ( $out, $err );
    my $pbm = $image->_find_pbm or return;
    my @in = (
               "$pbm${type}topnm",
               ( $image->{data} ? () : $image->{file} ? $image->{file} : () )
    );

    my @crop = ( "${pbm}pnmcut", $x, $y, $size, $size );
    my @out;
    for my $try (qw( ppm pnm )) {
        my $prog = "${pbm}${try}to$type";
        @out = ($prog), last if -x $prog;
    }
    my (@quant);
    if ( $type eq 'gif' ) {
        push @quant, ( [ "${pbm}ppmquant", 256 ], '|' );
    }
    IPC::Run::run( \@in, '<', ( $image->{data} ? \$image->{data} : \undef ),
                   '|', \@crop, '|', @quant, \@out, \$out, \$err )
      or return $image->error(
         MT->translate( "Cropping to [_1]x[_1] failed: [_2]", $size, $err ) );
    ( $image->{width}, $image->{height}, $image->{data} ) = ( $w, $h, $out );
    wantarray ? ( $out, $w, $h ) : $out;
} ## end sub crop

sub convert {
    my $image = shift;
    my %param = @_;

    my $type    = $image->{type};
    my $outtype = lc $param{Type};

    my ( $out, $err );
    my $pbm = $image->_find_pbm or return;
    my @in = (
               "$pbm${type}topnm",
               ( $image->{data} ? () : $image->{file} ? $image->{file} : () )
    );

    my @out;
    for my $try (qw( ppm pnm )) {
        my $prog = "${pbm}${try}to$outtype";
        @out = ($prog), last if -x $prog;
    }
    my (@quant);
    if ( $type eq 'gif' ) {
        push @quant, ( [ "${pbm}ppmquant", 256 ], '|' );
    }
    IPC::Run::run( \@in, '<', ( $image->{data} ? \$image->{data} : \undef ),
                   '|', @quant, \@out, \$out, \$err )
      or return $image->error(
            MT->translate( "Converting to [_1] failed: [_2]", $type, $err ) );
    $image->{data} = $out;
    $out;
} ## end sub convert

sub _find_pbm {
    my $image = shift;
    return $image->{__pbm_path} if $image->{__pbm_path};
    my @NetPBM = qw( /usr/local/netpbm/bin /usr/local/bin /usr/bin );
    my $pbm;
    for my $path ( MT->config->NetPBMPath, @NetPBM ) {
        next unless $path;
        $path .= '/' unless $path =~ m!/$!;
        $pbm = $path, last if -x "${path}pnmscale";
    }
    return
      $image->error(
        MT->translate(
            "You do not have a valid path to the NetPBM tools on your machine."
        )
      ) unless $pbm;
    $image->{__pbm_path} = $pbm;
}

package MT::Image::GD;
@MT::Image::GD::ISA = qw( MT::Image );

sub load_driver {
    my $image = shift;
    eval { require GD };
    if ( my $err = $@ ) {
        return $image->error( MT->translate( "Can't load GD: [_1]", $err ) );
    }
    1;
}

sub init {
    my $image = shift;
    my %param = @_;

    if ( ( !defined $param{Type} ) && ( my $file = $param{Filename} ) ) {
        ( my $ext = $file ) =~ s/.*\.//;
        $param{Type} = lc $ext;
    }
    my %Types
      = ( jpg => 'jpeg', jpeg => 'jpeg', gif => 'gif', 'png' => 'png' );
    $image->{type} = $Types{ lc $param{Type} }
      or return $image->error(
         MT->translate( "Unsupported image file type: [_1]", $param{Type} ) );

    if ( my $file = $param{Filename} ) {
        $image->{gd} = GD::Image->new($file)
          or return $image->error(
             MT->translate( "Reading file '[_1]' failed: [_2]", $file, $@ ) );
    }
    elsif ( my $blob = $param{Data} ) {
        $image->{gd} = GD::Image->new($blob)
          or return $image->error(
                          MT->translate( "Reading image failed: [_1]", $@ ) );
    }
    ( $image->{width}, $image->{height} ) = $image->{gd}->getBounds();
    $image;
} ## end sub init

sub blob {
    my $image = shift;
    my $type  = $image->{type};
    $image->{gd}->$type;
}

sub scale {
    my $image = shift;
    my ( $w, $h ) = $image->get_dimensions(@_);
    my $src = $image->{gd};
    my $gd = GD::Image->new( $w, $h, 1 );    # True color image (24 bit)
    $gd->copyResampled( $src, 0, 0, 0, 0, $w, $h, $image->{width},
                        $image->{height} );
    ( $image->{gd}, $image->{width}, $image->{height} ) = ( $gd, $w, $h );
    wantarray ? ( $image->blob, $w, $h ) : $image->blob;
}

sub crop {
    my $image = shift;
    my %param = @_;
    my ( $size, $x, $y ) = @param{qw( Size X Y )};
    my $src = $image->{gd};
    my $gd = GD::Image->new( $size, $size, 1 );    # True color image (24 bit)
    $gd->copy( $src, 0, 0, $x, $y, $size, $size );
    ( $image->{gd}, $image->{width}, $image->{height} )
      = ( $gd, $size, $size );
    wantarray ? ( $image->blob, $size, $size ) : $image->blob;
}

sub convert {
    my $image = shift;
    my %param = @_;
    $image->{type} = lc $param{Type};
    $image->blob;
}

package MT::Image::Imager;
@MT::Image::Imager::ISA = qw(MT::Image);

sub load_driver {
    my $image = shift;

    eval { require Imager };
    if ( my $err = $@ ) {
        return $image->error(
                           MT->translate( "Can't load Imager: [_1]", $err ) );
    }
    1;
}

sub init {
    my $image = shift;
    my %param = @_;

    if ( ( !defined $param{Type} ) && ( my $file = $param{Filename} ) ) {
        ( my $ext = $file ) =~ s/.*\.//;
        $param{Type} = lc $ext;
    }

    my %Types = map { $_ => $_ } Imager->read_types;
    $Types{jpg} = 'jpeg' if $Types{jpeg};

    $image->{type} = $Types{ lc $param{Type} }
      or return $image->error(
         MT->translate( "Unsupported image file type: [_1]", $param{Type} ) );

    my $imager = Imager->new;
    if ( my $file = $param{Filename} ) {
        $imager->read( file => $file, type => $image->{type} )
          or return
          $image->error(
                         MT->translate(
                                    "Reading file '[_1]' failed: [_2]", $file,
                                    $imager->errstr
                         )
          );
    }
    elsif ( my $blob = $param{Data} ) {
        $imager->read( data => $blob, type => $image->{type} )
          or return $image->error(
             MT->translate( "Reading image failed: [_1]", $imager->errstr ) );
    }

    $image->{imager} = $imager;
    $image->{width}  = $image->{imager}->getwidth;
    $image->{height} = $image->{imager}->getheight;

    $image;
} ## end sub init

sub blob {
    my $image = shift;

    my $blob;
    $image->{imager}->write( data => \$blob, type => $image->{type} );

    $blob;
}

sub scale {
    my $image = shift;
    my ( $w, $h ) = $image->get_dimensions(@_);

    $image->{imager} = $image->{imager}
      ->scale( xpixels => $w, ypixels => $h, type => 'nonprop' );
    @$image{qw/width height/} = ( $w, $h );

    wantarray ? ( $image->blob, $w, $h ) : $image->blob;
}

sub crop {
    my $image = shift;
    my %param = @_;
    my ( $size, $x, $y ) = @param{qw( Size X Y )};

    $image->{imager} = $image->{imager}
      ->crop( left => $x, top => $y, width => $size, height => $size );
    $image->{width} = $image->{height} = $size;

    wantarray ? ( $image->blob, $size, $size ) : $image->blob;
}

sub convert {
    my $image = shift;
    my %param = @_;
    $image->{type} = lc $param{Type};
    $image->blob;
}

1;
__END__

=head1 NAME

MT::Image - Movable Type image manipulation routines

=head1 SYNOPSIS

    use MT::Image;
    my $img = MT::Image->new( Filename => '/path/to/image.jpg' );
    my($blob, $w, $h) = $img->scale( Width => 100 );

    open FH, ">thumb.jpg" or die $!;
    binmode FH;
    print FH $blob;
    close FH;

=head1 DESCRIPTION

I<MT::Image> contains image manipulation routines using either the
I<NetPBM> tools, the I<ImageMagick> and I<Image::Magick> Perl module,
or the I<GD> and I<GD> Perl module.

The backend framework used (NetPBM, ImageMagick, GD) depends on the value of
the I<ImageDriver> setting in the F<config.cgi> file (or, correspondingly, set
on an instance of the I<MT::ConfigMgr> class).

Currently all this is used for is to create thumbnails from uploaded images.

=head1 CONFIGURATION

To change the image manipulation library used for generating thumbnails in
your system, edit your C<config.cgi> file and edit or edit the 
C<ImageDriver> configuration directive. The system supports the following
values for this directive:

=over 4

=item * B<GD>

A driver that provides specific support for Thomas Boutell's gd graphics 
library, commonly found on *nix systems. Advantages of using the GD libary
is performance. It has been shown to out-perform ImageMagick by 50-150%.
The disadvantages of this library have to do with underlying capabilities. 
Plugins for example the provide more advanced image manipulation capabilities
may not work with GD.

=item * B<NetBPM>

Advantages of using this driver includes ease of installation as it does
not require any additional software. Disadvantage however lies in poor image
quality.

=item * B<ImageMagick>

This is the default value of C<ImageDriver>. It produces excellent quality images
but does require the ImageMagick and ImageMagick libraries for Perl to be installed,
also known as PerlMagick. This can be difficult to install depending upon your system.

=item * B<Imager>

This driver is specially designed for generating 24-bit images.

=back

=head1 USAGE

=head2 MT::Image->new( %arg )

Constructs a new I<MT::Image> object. Returns the new object on success; on
error, returns C<undef>, and the error message is in C<MT::Image-E<gt>errstr>.

I<%arg> can contain:

=over 4

=item * Filename

The path to an image to load.

=item * Data

The actual contents of an image, already loaded from a file, a database,
etc.

=item * Type

The image format of the data in I<Data>. This should be either I<JPG> or
I<GIF>.

=back

=head2 $img->scale( %arg )

Creates a thumbnail from the image represented by I<$img>; on success, returns
a list containing the binary contents of the thumbnail image, the width of the
scaled image, and the height of the scaled image. On error, returns C<undef>,
and the error message is in C<$img-E<gt>errstr>.

I<%arg> can contain:

=over 4

=item * Width

=item * Height

The width and height of the final image, respectively. If you provide only one
of these arguments, the other dimension will be scaled appropriately. If you
provide neither, the image will be scaled to C<100%> of the original (that is,
the same size). If you provide both, the image will likely look rather
distorted.

=item * Scale

To be used instead of I<Width> and I<Height>; the value should be a percentage
(ie C<100> to return the original image without resizing) by which both the
width and height will be scaled equally.

=back

=head2 MT::Image->inscribe_square( %arg )

Calculates a square of dimensions that are capable of holding an image
of the height and width indicated. This method receives I<%arg>, which
may contain:

=over 4

=item * Height

=item * Width

=back

The square will be the smaller value of the Height and Width parameter.

The method returns a hash containing the following information:

=over 4

=item * Size

The size of the calculated square, in pixels.

=item * X

The horizontal space to crop from the image, in pixels.

=item * Y

The vertical space to crop from the image, in pixels.

=back

This information is suited for the L<crop> method.

=head2 $img->make_square()

Takes an image which may or may not be a square in dimension and forces
it into a square shape (trimming the longer side, as necesary).

=head2 $img->get_dimensions(%arg)

This utility method returns a width and height value pair after applying
the given arguments. Valid arguments are the same as the L<scale> method.
If 'Width' is given, a proportionate height will be calculated. If a
'Height' is given, the width will be calculated. If 'Scale' is given
the height and width will be calculated based on that scale (a value
between 1 to 100).

=head2 MT::Image->check_upload( %arg )

Utility method used to handle image upload and storage, along with some
constraining factors. The I<%arg> hash may contain the following elements:

=over 4

=item * Fh

A filehandle for the uploaded file.

=item * Fmgr

A handle to a L<MT::FileMgr> object that will be used for writing the
file into place.

=item * Local

A path and filename for the location to write the uploaded file.

=item * Max (optional)

A number that specifies the maximum physical file size for the uploaded
image (specified in bytes).

=item * MaxDim (optional)

A number that specifies the maximum dimension allowed for the uploaded
image (specified in pixels).

=back

If the uploaded image is valid and passes the file size and image
dimension requirements (assuming those parameters are given),
the return value is a list consisting of the following elements:

=over 4

=item * $width

The width of the uploaded image, in pixels.

=item * $height

The height of the uploaded image, in pixels.

=item * $id

A string identifying the type of image file (returned by L<Image::Size>,
so typically "GIF", "JPG", "PNG").

=item * $write_coderef

A Perl coderef that, when invoked writes the image to the specified
location.

=back

If any error occurs from this routine, it will return 'undef', and
assign the error message, accessible using the L<errstr> class method.

=head2 MT::Image->has_html_signature( %param )

This function looks at the first kilobyte (1024 bytes) of whitespace-stripped 
data to see if it contains patterns indicative of embedded HTML.  This is used 
by C<MT::Image::check_upload()> and C<MT::App::validate_upload> to test 
whether an uploaded file's content has a malicious payload.

The data to inspect is specified by the function's hash argument with keys:

=over 4

=item * C<data>

This key indicates the value is a scalar data string.

=item * C<fh>

This key indicates the value is a filehandle to the file to be tested.

=item * C<path>

This key specifies the absolute path to the file to be tested.

=back

The function returns true or false and dies on any errors.

=head1 AUTHOR & COPYRIGHT

Please see the I<MT> manpage for author, copyright, and license information.

=cut
