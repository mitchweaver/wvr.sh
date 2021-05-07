#!/bin/sh -e

mkpage() {
    if  [ -f "$1"          ] &&
        [ -f src/header.md ] && 
        [ -f src/footer.md ] && 
        [ -d out           ] ; then

        cat src/header.md "$1" src/footer.md > /tmp/$$.md
        outfile=${1%md}html
        topdir=${1%%/*}
        outfile=out/${outfile#$topdir/}
        mkdir -p "${outfile%/*.html}"

        printf '[Converting page]: %s -> %s\n' "$1" "$outfile"
        ghmd2html /tmp/$$.md > "$outfile"

        rm /tmp/$$.md

    fi
}

if [ "$1" ] ; then
    mkpage "$1"
fi
