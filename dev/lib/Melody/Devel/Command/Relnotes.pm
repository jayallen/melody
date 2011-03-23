package Melody::Devel::Command::Relnotes;
use Melody::Devel -command;

use strict;
use warnings;
use Git;
use File::Basename qw( basename dirname );
use File::Spec;
use Cwd qw( realpath );
use Term::ReadLine;
use Data::Dumper;
use Gravatar::URL qw( gravatar_url );

my $DEBUG = 0;

sub opt_spec {
    return (
        [ 
            "start|s=s",
            "refspec for starting commit (usually the last release tag)"
        ],
        [ "end|e=s", "refspec for the ending tag, defaults to HEAD"   ],
        [ "melody_dir|m=s", "The path to the Melody directory"        ],
        [ "output|o=s", "Output filename" ],
    );
}

sub options {
    my $self = shift;
    if ( @_ ) {
        $self->{options} = shift;
    }
    return wantarray ? %{ $self->{options} } : $self->{options};
}

sub option {
    my $self = shift;
    my $opt  = $self->{options} || {};
    my $key  = shift;
    my $val  = shift;
    return defined $val                         ? ( $opt->{key} = $val )
         : defined $key and exists $opt->{$key} ? $opt->{$key}
                                                : undef;
}

sub fh {
    my $self = shift;
    if ( @_ ) {
        my $out = shift;
        require FileHandle;
        my $fh  = FileHandle->new( $out, 'w' );
        die "Error opening ".$out.": $!" unless defined $fh;
        select( $fh );
        return $self->{fh} = $fh;
    }
    $self->{fh};
}

sub debug {
    my $self = shift;
    return unless $DEBUG;
    if ( $self->fh and $self->fh ne *STDOUT ) {
        print STDOUT @_;
    }
    else {
        print STDERR @_;
    }
}

sub out {
    my $self = shift;
    print join("\n", @_);
}

sub verify_git_directory {
    my ($self, $dir ) = @_;
    my @loc = grep { defined }
        ( $dir,  '.', dirname("$0/.."), $ENV{MT_HOME} );
    my $repo;
    foreach my $loc ( @loc ) {
        # $self->debug( "Testing $loc\n" );
        my $path = realpath( $loc );
        next unless $path and -d $path;
        if ( $repo = Git->repository( Directory => $path )) {
            $dir = $path;
            last;
        }
    }
    $repo;
}

sub validate_args { 
    my $self      = shift;
    my $opt       = shift;
    my $args      = shift;
    $opt->{end} ||= 'master';

    # no args allowed but options!
    $self->usage_error("No args allowed") if $args and @$args;

    # Check that we're in the Melody directory
    $self->{repo} = $self->verify_git_directory( $opt->{melody_dir} )
        or return $self->usage_error("Couldn't find repo");

    $self->fh( $opt->{output} ) if $opt->{output};

    # Check start refspec
    # Ask for display name for start refspec
    # Check end refspec
    # Ask for display name for end refspec
    my $term = Term::ReadLine->new(__PACKAGE__);
    foreach my $ref (qw( start end )) {
print STDERR 'show-ref', $opt->{$ref}."\n";

        return $self->usage_error("Invalid refspec: ".$opt->{$ref})
            unless $self->{repo}->command( 'show-ref', $opt->{$ref} );
        my $prompt = sprintf( "Choose a display name to use for release %s: ",
                                $opt->{$ref});
        my $OUT = $term->OUT || \*STDOUT;
        defined( my $resp = $term->readline($prompt) )
            or return $self->usage_error("Aborting");
        $term->addhistory( $opt->{$ref.'_label'} = $resp );
    }
    $self->{arguments} = $args;
    $self->options( $opt );
}

sub run {
    my $self = shift;
    my $repo = $self->{repo};
    my $opt  = $self->options();
    $self->out( $self->boilerplate );
    my ($fh, $c) = $repo->command_output_pipe(
        'log',
        '--abbrev-commit',
        '--no-merges',
        '--topo-order',
        '--reverse',
        '--date=iso',
        q(--format=START commit %H
SHA             = %h
Tree            = %t
Parents         = %p
Author Name     = %aN
Author Email    = %aE
Author Date     = %ad
Committer Name  = %cN
Committer Email = %cE
Committer Date  = %cd
Subject         = %s
Message         = %-b
Note            = %N
END commit),
        join('..', $opt->{start}, $opt->{end})
    );
    # %n: newline
    my ( @log, %buffer );
    while ( my $lastrev = <$fh> ) {
        chomp $lastrev;
        if ( $lastrev =~ m{^START commit (\w+)} ) {
            $self->debug( "FOUND $lastrev\n" );
            %buffer = ( commit => $1 );
        }
        elsif ( $lastrev =~ m{^END commit} ) {
            $self->debug( "FOUND $lastrev\n" );
            delete $buffer{multiline_key};
            $self->out( $self->format_commit( \%buffer ));
            push( @log, { %buffer } );
            %buffer = ();
            next;
        }
        elsif ( $lastrev =~ m{^(Note|Message)\s+= (.*)}) {
            my ( $key, $val )      = ( lc($1), $2 );
            $buffer{multiline_key} = $key;
            $buffer{$key}          = $val;
            $self->debug( "Set $key to $val\n" );
        }
        else {
            my ( $key, $val );
            if ( $key = $buffer{multiline_key} ) {
                $buffer{$key} .= "\n".$lastrev;
                $self->debug( "Added to $key: $lastrev\n" );
            }
            else {
                ( $key, $val ) = split(/\s+=\s+/, $lastrev, 2 );
                my @keys = split(/\s+/, lc($key) );
                if ( @keys == 1 ) {
                    $buffer{$keys[0]} = $val;
                }
                else {
                    ($key, (my $subkey)) = @keys;
                    $buffer{$key}{$subkey} = $val;
                }
                $self->debug( "Set @keys to $val\n" );
            }
        }
    }
    $repo->command_close_pipe($fh, $c);
    # $self->out( Dumper(\@log) );
#  | perl -lape '
#         if ( ! m{^\[[a-z0-9]{6}} ) {
#             s{^\s+$}{}g;
#             s{^([^\[\s])}{   $1};
#             s{\[#(\d+)}{\[[#$1](https://openmelody.lighthouseapp.com/projects/26604/tickets/$1)}g;
}

sub boilerplate {
    my $self            = shift;
    my $opt             = $self->options;
    my $prev_name       = $opt->{start_label};
    my $prev_refspec    = $opt->{start};
    my $release_name    = $opt->{end_label};
    my $release_refspec = $opt->{end};
    return <<"EOF";
# Release Notes for $release_name #

_The following are notable changes introduced since [the release of $prev_name][]. You can view the [all $release_name milestone tickets](https://openmelody.lighthouseapp.com/projects/26604/milestones/EDIT_ME_PLEASE) in Lighthouse._

[The release of $prev_name]: https://github.com/openmelody/melody/wiki/release-$prev_refspec
[All $release_name milestone tickets]: https://openmelody.lighthouseapp.com/projects/26604/milestones/EDIT_ME_PLEASE

* This is the first item in a list of notable items addressed by this release, followed by a link to the Lighthouse ticket. You should expect that most people will stop reading at the end of this list and never go through the whole changelog. Plan your words accordingly here and please add other links to related information when approrpriate
 ([#9999999](http://openmelody.lighthouseapp.com/projects/26604/tickets/9999999))

* This is a second notable item. They are listed in order of importance to the users and usually that means those who are upgrading. Any new, changed or removed config directives or template tags should be high on this list and very explicitly called out. ([#9999999](http://openmelody.lighthouseapp.com/projects/26604/tickets/9999999))

* This is a third notable item. Hopefully, you're not just copy/pasting from below.  These items should be crafted to be **more** understandable to the end user than the developer's commit note, which, honestly, shouldn't be too hard... ([#9999999](http://openmelody.lighthouseapp.com/projects/26604/tickets/9999999))

## Changelog ##

The following are the raw commits introduced in $release_name, listed in the order in which they were introduced into the [openmelody/melody master repo](http://github.com/openmelody/melody).

EOF
    
}

sub format_commit {
    my $self    = shift;
    my $buffer  = shift;
    my $gh_base = 'http://github.com/openmelody/melody/commit';
    my $lh_base
        = 'http://openmelody.lighthouseapp.com/projects/26604-melody/tickets';

    my $sha        = delete $buffer->{sha}             || '';
    my $date       = delete $buffer->{committer}{date} || '';
    my $author     = delete $buffer->{author}{name}    || '';
    my $author_img = gravatar_url(
        email => delete $buffer->{author}{email}, 
        size => 30
    );
    my $author_url = $self->author_url_lookup( $author ) || '';
    my $subject    = delete $buffer->{subject}         || '';
    my $note       = delete $buffer->{note}            || '';
    my $msg        = delete $buffer->{message}         || '';
    my $tree       = delete $buffer->{tree}            || '';
    $subject    =~ s{\[\#(\d+)(\s*state:.*?)?\]}{[Case \#$1]($lh_base/$1) - }g;
    $subject  = "\n\n> $subject";
    foreach my $k ( $msg, $note ) {
        next unless defined $k and $k ne '';
        $k =~ s{^([^>])}{> $1}gsm;
        $subject = join( "\n>\n", $subject, $k );
    }
    my $output_fmt = <<EOF;

**[<img src="$author_img" width="30" /> $author]($author_url) &#8212; [$date &#8212; $sha]($gh_base/$sha)** ([tree]($gh_base/$tree)) $subject
EOF
    $output_fmt =~ s{[\s\n]+\Z}{}gsm;
    return $output_fmt."\n\n";
}

sub author_url_lookup {
    my $self   = shift;
    my $name = shift;
    my $url    = 'http://github.com/';
    my %authors = (
        'Jay Allen'      => 'jayallen',
        'Byrne Reese'    => 'byrnereese',
        'Dan Wolfgang'   => 'danwolfgang',
        'Mike Thomsen'   => 'mikert',
        'Timothy Appnel' => 'tima',
        'David Phillips' => 'dphillips',
        'Sabine'         => 'sabine',
    );
    $url .= $authors{$name} ? $authors{$name}
                            : 'UNKNOWN';
}

1;
