#!/usr/bin/env bats
# Tests for scripts/check-brewfiles.sh — every Brewfile must parse, and every
# formula/cask name must resolve to something Homebrew knows about.
# `brew bundle list` alone is syntax-only; it accepts nonexistent names.

CHECK="$BATS_TEST_DIRNAME/../scripts/check-brewfiles.sh"

setup() {
  DIR="$BATS_TEST_TMPDIR/bf"
  mkdir -p "$DIR"
}

@test "passes on real formula and cask names" {
  printf "brew 'git'\ncask 'iterm2'\n" > "$DIR/Brewfile"
  run "$CHECK" "$DIR/Brewfile"
  [ "$status" -eq 0 ]
}

@test "fails on a cask name Homebrew does not know" {
  printf "brew 'git'\ncask 'definitely-not-a-real-cask-xyz-123'\n" > "$DIR/Brewfile"
  run "$CHECK" "$DIR/Brewfile"
  [ "$status" -eq 1 ]
  [[ "$output" == *"definitely-not-a-real-cask-xyz-123"* ]]
}

@test "fails on a file that does not parse" {
  printf "brew 'git'\nthis is not a brewfile line\n" > "$DIR/Brewfile"
  run "$CHECK" "$DIR/Brewfile"
  [ "$status" -eq 1 ]
}

@test "mas files are parse-only" {
  printf 'mas "Xcode", id: 497799835\n' > "$DIR/Brewfile.mas"
  run "$CHECK" "$DIR/Brewfile.mas"
  [ "$status" -eq 0 ]
}

@test "resolves a tap-qualified formula by tapping first" {
  # Only meaningful on a machine without the tap (CI); locally it is already tapped.
  printf "brew 'hashicorp/tap/terraform'\n" > "$DIR/Brewfile"
  run "$CHECK" "$DIR/Brewfile"
  [ "$status" -eq 0 ]
  [[ "$output" == *"hashicorp/tap"* ]]
}
