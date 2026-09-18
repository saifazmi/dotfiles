#!/usr/bin/env bats
# Tests for scripts/check-packages.sh — the Makefile's PACKAGES list must match
# the package directories actually on disk, in both directions.

CHECK="$BATS_TEST_DIRNAME/../scripts/check-packages.sh"

setup() {
  REPO="$BATS_TEST_TMPDIR/repo"
  mkdir -p "$REPO"
}

# make_repo "<PACKAGES value>" <dir>...
make_repo() {
  printf 'PACKAGES := %s\n' "$1" > "$REPO/Makefile"; shift
  for d in "$@"; do mkdir -p "$REPO/$d"; done
}

@test "passes when PACKAGES matches the directories on disk" {
  make_repo "bat zsh" bat zsh
  run "$CHECK" --repo "$REPO"
  [ "$status" -eq 0 ]
}

@test "reports a package directory missing from PACKAGES" {
  make_repo "bat" bat zsh
  run "$CHECK" --repo "$REPO"
  [ "$status" -eq 1 ]
  [[ "$output" == *"zsh"* ]]
}

@test "reports a PACKAGES entry with no directory on disk" {
  make_repo "bat zsh" bat
  run "$CHECK" --repo "$REPO"
  [ "$status" -eq 1 ]
  [[ "$output" == *"zsh"* ]]
}

@test "ignores non-package directories and the known excluded package" {
  make_repo "bat" bat docs scripts tests _old_dots_ ghostty .git .github
  run "$CHECK" --repo "$REPO"
  [ "$status" -eq 0 ]
}
