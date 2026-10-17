#!/bin/sh
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
scratch=$(mktemp -d)
trap 'rm -rf "$scratch"' EXIT HUP INT TERM
cd "$repo"
export XDG_CACHE_HOME="$scratch/cache"
export XDG_STATE_HOME="$scratch/state"
export GHOST_TEST_ROOT="$repo"
export GHOST_TEST_TMP="$scratch"
nvim --headless -u NONE -i NONE -n -l tests/run.lua
