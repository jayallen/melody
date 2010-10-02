#!/usr/bin/env bash
#
# This is a script used for creating the previously hand-crafted download
# packages we post to http://github.com/openmelody/melody/downloads/ each time
# we release a new version.
#
# Run with no arguments to see usage...

if [[ "$1" == "-v" ]]
    then VERBOSE=1; shift
    else unset VERBOSE
fi

usage() {
    [[ -n "$*" ]] && echo "$*"
    echo "USAGE: ./build/melody-make_download.sh [-v] FORMAT" >/dev/stderr
    echo "   -v         Verbose updates"
    echo "   FORMAT     The archive format to use. Valid choices: tar and zip"
    exit
}

die_on_error() {
    echo "ERROR: $@" >/dev/stderr
    exit 1;
}

get_latest_tag() {
    echo $(git describe --abbrev=0)
}

create_git_archive() {
    local filefmt="$1"
    local tag="${2:-$(get_latest_tag)}"
    local formats=$(git archive -l)

    if [[ -z "$filefmt" ]]; then
        usage "Please provide an archive format argument:" $(echo "$formats" | paste -s -d',' - | sed -e 's/,/, /g')  > /dev/stderr
    fi

    if [[ -z "$tag" ]]; then
        echo "No tag specified and we could not derive one using 'git describe --abbrev=0':" > /dev/stderr
        [ $VERBOSE ] && git describe --abbrev=0 > /dev/stderr
    fi

    local basefile="melody-$tag"
    local outfile="$TMPDIR/$basefile.$filefmt"
    [ $VERBOSE ] && local volume='--verbose'
    local gitcmd="git archive --prefix=$basefile/ --format=$filefmt --output=$outfile $volume"

    [ $VERBOSE ] && echo "Running: $gitcmd" >/dev/stderr
    echo -n "Creating Git archive... " > /dev/stderr

    if [ $VERBOSE ]; then fh="/dev/stderr"; else fh="/dev/null"; fi

    $gitcmd "$tag" > "$fh"

    if [[ $filefmt == 'tar' ]]; then
        gzip "$outfile"
        outfile="$outfile.gz"
    fi

    mv -i $outfile .

    if [[ -e "$outfile" ]]; then
        local newarchive="$outfile"
    elif [[ -e "$(pwd)/$(basename $outfile)" ]]; then
        local newarchive="$(pwd)/$(basename $outfile)"
    else
        die_on_error "ERROR: Archive not created. Not sure why"
    fi

    echo -n "DONE -> "
    echo "$newarchive"
}




if [[ -z "$(git ls-files 2>/dev/null)" ]]; then
    git ls-files
    die_on_error "I don't think this is a git repository"
fi

create_git_archive $@
exit;

######### NOTES #########
#
# cd openmelody
# git archive --format=zip --prefix=melody-$tag/ $tag | gzip > /Users/jay/melody-$tag/melody-$tag.tar.gz
# 
# tar tvfz melody-$tag.tar.gz 
# 
# Directories/files to remove:
#     t
#     build 
#     Makefile.PL 
#     MANIFEST.SKIP 
#     Makefile.PL 
#     .gitignore 
#     .perltidyrc 
# 
#     find . -name .exists -delete
#     find . -name .DS_Store
# 
# tar cvfz melody-$tag.tar.gz melody-$tag
# zip -r melody-$tag.zip melody-$tag
# 
# 
# mkdir melody-$tag; git archive --format=tar --prefix=melody-$tag/ $tag | gzip > melody-$tag/melody-$tag.tar.gz
# 
#  [5109] CoffeeIsBad  [openmelody(master)]  $ tag="$(git describe --abbrev=0)"; mkdir melody-$tag; git archive --format=tar --prefix=melody-$tag/ $tag | gzip > melody-$tag/melody-$tag.tar.gz
#  
# tag="$(git describe --abbrev=0)";
# mkdir /tmp/melody-$tag;
# git archive --format=$fmt --prefix=melody-$tag/ $tag | gzip > /tmp/melody-$tag/melody-$tag.tar.gz;
# echo "New archive created at /tmp/melody-$tag/melody-$tag.tar.gz"
