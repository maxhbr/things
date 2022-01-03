#!/usr/bin/env nix-shell
#! nix-shell -i bash -p parallel openscad

set -euo pipefail

getParts() {
    local scad="$1"
    openscad -o "${scad%.*}.ast" "$scad" 2>&1 >/dev/null | awk -F '[, "]' '{print $3}'
}

buildAll() {
    local scad="$1"
    local stl="${scad%.*}.stl"
    set -x
    openscad --hardwarnings \
        -o "$stl"\
        "$scad" \
        -D 'isStlExport=true'
}

buildPart() (
    set -euo pipefail
    local scad="$1"
    local stl="$2"
    local outDir="$(dirname "$scad")"
    set -x
    openscad --hardwarnings \
        -o "$outDir/$stl"\
        "$scad" \
        -D 'justOnePart="'"$stl"'"' \
        -D 'isStlExport=true'
)

export -f buildPart


scad="$(readlink -f ${1})"

buildAll "$scad" &
getParts "$scad" | parallel --progress buildPart "$scad" {} 1>&2

wait
times
