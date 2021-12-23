#!/usr/bin/env bash

set -euo pipefail

buildPart() (
    set -x
    openscad --hardwarnings \
        -o "$1"\
        "stuffholder.scad" \
        -D 'justOnePart="'"$1"'"'
)

buildPart "stuffholder-v1a.stl"
buildPart "stuffholder-v1b.stl"
buildPart "stuffholder-v1c.stl"
buildPart "stuffholder-boxes.stl"

wait
times
