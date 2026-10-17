#!/bin/sh
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
scratch=$(mktemp -d)
cleanup() {
  # Short-lived plugin subprocesses may still be closing their log files.
  for attempt in 1 2 3; do
    if rm -rf "$scratch" 2>/dev/null; then return; fi
    sleep 0.1
  done
  rm -rf "$scratch"
}
trap cleanup EXIT HUP INT TERM
cd "$repo"
export XDG_CACHE_HOME="$scratch/cache"
export XDG_STATE_HOME="$scratch/state"
export GHOST_TEST_ROOT="$repo"
export GHOST_TEST_TMP="$scratch"
nvim --headless -u NONE -i NONE -n -l tests/run.lua
