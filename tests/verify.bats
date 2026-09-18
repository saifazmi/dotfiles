#!/usr/bin/env bats
# Tests for scripts/verify.sh — the single definition of "correctly stowed".
#
# Each test builds a throwaway repo with one fixture package, stows it into a
# scratch target using the real .stowrc (so ignore semantics match production),
# then plants exactly one fault and asserts the verifier names it.

REAL_REPO="$BATS_TEST_DIRNAME/.."
VERIFY="$REAL_REPO/scripts/verify.sh"

setup() {
  REPO="$BATS_TEST_TMPDIR/repo"
  TARGET="$BATS_TEST_TMPDIR/home"
  mkdir -p "$REPO" "$TARGET"
  cp "$REAL_REPO/.stowrc" "$REPO/.stowrc"
}

# make_pkg <pkg> <relative-file>...  — create files inside a fixture package
make_pkg() {
  local pkg="$1"; shift
  for f in "$@"; do
    mkdir -p "$REPO/$pkg/$(dirname "$f")"
    echo "content" > "$REPO/$pkg/$f"
  done
}

stow_pkg() {
  (cd "$REPO" && stow --target="$TARGET" "$1")
}

verify() {
  run "$VERIFY" --repo "$REPO" --target "$TARGET" --links-only "$@"
}

@test "clean stow passes" {
  make_pkg demo .config/demo/conf .demorc
  stow_pkg demo
  verify demo
  [ "$status" -eq 0 ]
  [[ "$output" == *"✓ demo"* ]]
}

@test "reports a file added to a package but never stowed" {
  make_pkg demo .demorc
  stow_pkg demo
  make_pkg demo .demo-new
  verify demo
  [ "$status" -eq 1 ]
  [[ "$output" == *"✗ demo"* ]]
  [[ "$output" == *".demo-new"* ]]
}

@test "reports a real file shadowing a package file" {
  make_pkg demo .demorc
  echo "local edit" > "$TARGET/.demorc"
  verify demo
  [ "$status" -eq 1 ]
  [[ "$output" == *".demorc"* ]]
}

@test "reports a broken link in the package footprint" {
  make_pkg demo .config/demo/conf .config/demo/old
  # pre-create the dir so stow links each file rather than folding the dir
  mkdir -p "$TARGET/.config/demo"
  stow_pkg demo
  rm "$REPO/demo/.config/demo/old"    # renamed away in the repo; link now dangles
  verify demo
  [ "$status" -eq 1 ]
  [[ "$output" == *"broken link"* ]]
  [[ "$output" == *".config/demo/old"* ]]
}

@test "reports a link that resolves outside the package" {
  make_pkg demo .config/demo/conf
  mkdir -p "$REPO/_old_dots_/demo"
  echo "stale" > "$REPO/_old_dots_/demo/conf"
  mkdir -p "$TARGET/.config"
  ln -s "$REPO/_old_dots_/demo" "$TARGET/.config/demo"
  verify demo
  [ "$status" -eq 1 ]
  [[ "$output" == *".config/demo"* ]]
}

@test "ignores files stow ignores" {
  make_pkg demo .demorc .config/demo/conf
  stow_pkg demo
  # ignored files beside already-stowed ones, as in the real repo
  make_pkg demo .DS_Store README.md .config/demo/conf.bak
  verify demo
  [ "$status" -eq 0 ]
}

@test "verifies only the named packages" {
  make_pkg demo .demorc
  make_pkg other .otherrc
  stow_pkg demo
  verify demo
  [ "$status" -eq 0 ]
  [[ "$output" != *"other"* ]]
}

@test "fails with usage when no packages are given" {
  verify
  [ "$status" -ne 0 ]
  [[ "$output" == *"sage"* ]]
}

@test "brew check runs unless --links-only is given" {
  make_pkg demo .demorc
  stow_pkg demo
  run "$VERIFY" --repo "$REPO" --target "$TARGET" demo
  [ "$status" -eq 1 ]
  [[ "$output" == *"Brewfile"* ]]
}
