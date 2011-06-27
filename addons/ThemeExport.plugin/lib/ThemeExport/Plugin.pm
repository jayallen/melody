package ThemeExport::Plugin;

use strict;
use MT::Theme::Exporter;
use File::Copy;
use MT::Util qw( format_ts epoch2ts caturl );

sub export {
    my $app  = shift;
    my $q    = $app->query;
    my $blog = $app->blog;

    $| = 1;
    $app->{no_print_body} = 1;
    $app->send_http_header('text/plain');

    my $temp_dir = $app->config('TempDir');
    require File::Temp;
    my $basedir =
      File::Temp::tempdir( 'mt-theme-export-XXXX', DIR => $temp_dir );
    my $fmgr    = MT::FileMgr->new('Local');
    my $options = {
        verbose          => 1,
        zip              => 1,
        logger           => sub { $app->print( $_[0] ); },
        fmgr             => $fmgr,
        pack_name        => $q->param('theme_name') || '',
        pack_description => $q->param('theme_description') || '',
        pack_version     => $q->param('theme_version') || '',
        system_cf        => $q->param('system_cf') || '',
        system_fd        => $q->param('system_fd') || '',
        author_name      => $q->param('designer_name') || '',
        author_link      => $q->param('designer_link') || '',
        outdir           => $basedir
    };

    my $exporter = MT::Theme::Exporter->new($options);

    $exporter->export( {
            blog_id => $blog->id,
            name    => $q->param('theme_name')
        }
    );
    $exporter->write_config();

    my ( $support_dir, $target_path, $target_url );
    $support_dir =
      File::Spec->catdir( 'support', 'theme-export', 'blog_id_'.$blog->id,
        format_ts( "%Y-%m-%d", epoch2ts( undef, time ) ) );
    $target_path = File::Spec->catdir( $app->static_file_path, $support_dir );
    unless ( $fmgr->exists($target_path) ) {
        $fmgr->mkpath($target_path);
    }
    my ($zipfilename) = ( $exporter->{'zipfilepath'} =~ /([^\/]*)$/ );

    $target_path = File::Spec->catfile( $target_path, $zipfilename );
    $target_url = caturl( $app->static_path, $support_dir, $zipfilename );

    # $fmgr can't always be used to move the zip file because it may not have 
    # permission to move a file created by a different user. That is, in 
    # MT::Theme::Exporter::write, the zip is created by the system.
    #$fmgr->rename( $exporter->{'zipfilepath'}, $target_path )
    move( $exporter->{'zipfilepath'}, $target_path )
        or die $app->print(
            'JSON:'
              . MT::Util::to_json( {
                    'error' => "The destination $target_path could not be "
                        . "written. Check permissions before retrying.",
                }
              )
        );

    # The zip file has been moved to $target_path now, so go ahead and delete
    # the temporary files.
    File::Path::rmtree($basedir);

    return $app->print(
        'JSON:'
          . MT::Util::to_json( {
                'download_url' => $target_url,
                'zipfilename'  => $zipfilename,
            }
          )
    );
}

sub export_start {
    my $app  = shift;
    my $q    = $app->query;
    my $blog = $app->blog;
    my $tmpl = $app->load_tmpl('dialog_export.tmpl');
    $tmpl->param( blog_id    => $blog->id );
    $tmpl->param( theme_name => $blog->name . ' Theme' );
    $tmpl->param( theme_description =>
          "Theme created by the Theme Export Plugin by Endevver." );
    $tmpl->param( theme_version => '1.0' );
    $tmpl->param( designer_name => $app->user->nickname );
    $tmpl->param( designer_url  => $app->user->url );

    # If there are any system-level custom fields, give the user the option to
    # export them.
    if ( MT->component('Commercial')
        && MT->model('field')->load({ blog_id => '0' })
    ) {
        $tmpl->param( system_cf => '1' );
    }

    # If there are any system-level Field Day fields, giv ethe user the option
    # to export them.
    if ( MT->component('FieldDay')
        && MT->model('fdsetting')->load({ object_type => ['blog','system','user'] }) 
    ) {
        $tmpl->param( system_fd => 1 );
    }
    
    return $app->build_page($tmpl);
}

1;
__END__
