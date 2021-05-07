#!/bin/sh -e
#
# convert my vim wiki from md to html
#

wiki=${HOME}/files/wiki

checks() {
    if [ ! -d ./out ] || [ ! -d "$wiki" ] ; then
        exit 1
    fi

    if [ ! -x bin/mkpage.sh ] ; then
        exit 1
    fi
}

mkdirs() {
    # make needed directories
    find "$wiki" -type d | \
    while read -r line ; do
        mkdir -p "./out/wiki/${line#$wiki}"
    done
}

convert_all() {
    find ./wiki -type f -name '*.md' | \
    while read -r line ; do
        mkpage "$line"

        # sed here to change all the relational links from poiting
        # ".md" to the correct ".html"
        #
        # This allows navigation both from within vimwiki and the website.
        outfile=${line#./wiki}
        outfile=./out/wiki/${outfile%md}html
        sed -i 's/\.md/\.html/' "$outfile"
    done
}

copy() {
    if [ -d ./wiki ] ; then
        rm -r wiki
    fi
    cp -r "$wiki" wiki
}

main() {
    check
    copy
    . bin/mkpage.sh
    mkdirs
    convert_all
    rm -r wiki
}

main "$@"
