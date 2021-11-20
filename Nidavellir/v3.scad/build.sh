#!/usr/bin/env bash

file="Nidavellir.scad"

buildPart() (
    set -x
    openscad -o "$1" "$file" -D 'justOnePart="'"$1"'"'
)

buildPart seats.stl
buildPart box.stl

openscad --imgsize=2000,2000 \
    --projection=perspective \
    --colorscheme Tomorrow \
    -o Nidavellir.png \
    NidavellirComplete.scad
