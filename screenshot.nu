#!/usr/bin/env nu

slurp | grim -g $in - | wl-copy
