#!/usr/bin/env bash

buildPart() (
    set -x
    openscad -o "$1"\
        "Nidavellir.scad" \
        -D 'justOnePart="'"$1"'"'
)

render() {
    openscad --imgsize=3840,2160 \
        --projection=perspective \
        --colorscheme Tomorrow \
        "$@" \
        NidavellirComplete.scad \
        -D 'highRes=true'
}

time buildPart Nidavellir-Bank.stl &
time buildPart Nidavellir-BankLid.stl &
time render -o Nidavellir.png --camera=47.4,-20.6,113.35,55,0,19.4,932.74 &
time render -o Nidavellir-1.png --camera=250,93,4,73,0,351,495 &
time render -o Nidavellir-2.png --camera=-22.35,75.49,-46.77,57.1,0,145.1,679.97 &
time render -o Nidavellir-3.png --camera=-22.35,75.49,-46.77,48.7,0,202.5,679.97 &

wait
times
