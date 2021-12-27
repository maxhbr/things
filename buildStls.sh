#!/usr/bin/env nix-shell
#! nix-shell -i bash -p parallel openscad

set -euo pipefail

scad="$(readlink -f ${1})"

getParts() {
    openscad -o "${scad%.*}.ast" "$scad" 2>&1 >/dev/null | awk -F '[, "]' '{print $3}'
}

buildPart() (
    set -euo pipefail
    scad="$1"
    stl="$2"
    outDir="$(dirname "$scad")"
    set -x
    openscad --hardwarnings \
        -o "$outDir/$stl"\
        "$scad" \
        -D 'justOnePart="'"$stl"'"'
)

export -f buildPart

getParts | parallel --progress buildPart "$scad" {} 1>&2

wait
times
