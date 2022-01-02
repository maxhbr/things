#!/usr/bin/env bash

set -euo pipefail

buildPart() (
    set -x
    openscad --hardwarnings \
        -o "$1"\
        "stuffholder.scad" \
        -D 'justOnePart="'"$1"'"'
)

render() {
    openscad --hardwarnings \
        --imgsize=3840,2160 \
        --projection=perspective \
        --colorscheme Tomorrow \
        "$@" \
        "stuffholder.scad" \
        -D 'highRes=true'
}

time render -o stuffholder.png --camera=4.36,41.71,64.3,55,0,25,839.47 &

buildPart "stuffholder-v1a.stl"
buildPart "stuffholder-v1b.stl"
buildPart "stuffholder-v1c.stl"
buildPart "stuffholder-boxes.stl"

wait
times
