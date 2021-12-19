#!/usr/bin/env bash

set -euo pipefail

buildPart() (
    set -x
    openscad --hardwarnings \
        -o "$1"\
        "stuffholder.scad" \
        -D 'justOnePart="'"$1"'"'
)

buildPart stuffholder-v1.stl

wait
times
