#!/usr/bin/env bash

set -euo pipefail

buildPart() (
    set -x
    openscad --hardwarnings \
        -o "$1"\
        "imperium:legends.scad" \
        -D 'justOnePart="'"$1"'"'
)

# render() {
#     openscad --hardwarnings \
#         --imgsize=3840,2160 \
#         --projection=perspective \
#         --colorscheme Tomorrow \
#         "$@" \
#         "imperium:legends.scad" \
#         -D 'highRes=true'
# }

# time render -o stuffholder.png --camera=4.36,41.71,64.3,55,0,25,839.47 &

buildPart "imperium_legends_decks.stl"
buildPart "imperium_legends_misc.stl"

wait
times
