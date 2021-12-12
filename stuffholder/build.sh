#!/usr/bin/env bash

set -euo pipefail

openscad --hardwarnings \
    -o stuffholder.stl\
    stuffholder.scad

wait
times
