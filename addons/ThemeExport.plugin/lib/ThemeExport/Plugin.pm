package ThemeExport::Plugin;

use strict;
use MT::Theme::Exporter;
use File::Copy;
use MT::Util qw( format_ts epoch2ts caturl );

sub export {
    my $app  = shift;
    my $q    = $app->{query};
    my $blog = $app->blog;

    $| = 1;
    $app->{no_print_body} = 1;
    $app->send_http_header('text/plain');

    my $temp_dir = $app->config('TempDir');
    require File::Temp;
    my $basedir
      = File::Temp::tempdir( 'mt-theme-export-XXXX', DIR => $temp_dir );
    my $fmgr = MT::FileMgr->new('Local');
    my $options = {
                    verbose          => 1,
                    zip              => 1,
                    logger           => sub { $app->print( $_[0] ); },
                    fmgr             => $fmgr,
                    pack_name        => $q->param('theme_name') || '',
                    pack_description => $q->param('theme_description') || '',
                    pack_version     => $q->param('theme_version') || '',
                    author_name      => $q->param('designer_name') || '',
                    author_link      => $q->param('designer_link') || '',
                    outdir           => $basedir
    };
    my $exporter = MT::Theme::Exporter->new($options);

    $exporter->export(
                  { blog_id => $blog->id, name => $q->param('theme_name') } );
    $exporter->write_config();

    my ( $support_dir, $target_path, $target_url );
    $support_dir = File::Spec->catdir(
                                       'support',
                                       'theme-export',
                                       $blog->id,
                                       format_ts(
                                           "%Y-%m-%d", epoch2ts( undef, time )
                                       )
    );
    $target_path = File::Spec->catdir( $app->static_file_path, $support_dir );

    unless ( $fmgr->exists($target_path) ) {
        $fmgr->mkpath($target_path);
    }
    my ($zipfilename) = ( $exporter->{'zipfilepath'} =~ /([^\/]*)$/ );

    $target_path = File::Spec->catfile( $target_path, $zipfilename );
    $target_url = caturl( $app->static_path, $support_dir, $zipfilename );

    move( $exporter->{'zipfilepath'}, $target_path );

    File::Path::rmtree($basedir);

    return
      $app->print(
         'JSON:'
           . MT::Util::to_json(
             { 'download_url' => $target_url, 'zipfilename' => $zipfilename, }
           )
      );
} ## end sub export

sub export_start {
    my $app  = shift;
    my $q    = $app->{query};
    my $blog = $app->blog;
    my $tmpl = $app->load_tmpl('dialog_export.tmpl');
    $tmpl->param( blog_id    => $blog->id );
    $tmpl->param( theme_name => $blog->name . ' Theme' );
    $tmpl->param( theme_description =>
                  "Theme created by the Theme Export Plugin by Endevver." );
    $tmpl->param( theme_version => '1.0' );
    $tmpl->param( designer_name => $app->user->nickname );
    $tmpl->param( designer_url  => $app->user->url );
    return $app->build_page($tmpl);
}

1;
__END__
