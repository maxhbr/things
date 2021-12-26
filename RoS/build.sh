#!/usr/bin/env nix-shell
#! nix-shell -i bash -p parallel

set -euo pipefail

buildPart() (
    set -x
    openscad --hardwarnings \
        -o "$1"\
        "RaidersOfScythia.scad" \
        -D 'justOnePart="'"$1"'"'
)

export -f buildPart

cat <<EOF | parallel --progress buildPart {} 1>&2
RaidersOfScythia-1a.stl
RaidersOfScythia-1b.stl
RaidersOfScythia-2a.stl
RaidersOfScythia-2b.stl
RaidersOfScythia-3.stl
RaidersOfScythia-4.stl
RaidersOfScythia-5.stl
RaidersOfScythia-6.stl
RaidersOfScythia-7.stl
RaidersOfScythia-8.stl
RaidersOfScythia-9.stl
RaidersOfScythia-10.stl
EOF

wait
times
