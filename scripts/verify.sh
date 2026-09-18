#!/bin/bash
# verify.sh — assert every stow package is correctly linked into the target.
#
# Two complementary checks per package:
#
#   1. Completeness — stow itself is the oracle. `stow -n` must have nothing
#      left to do and report no conflicts. This inherits stow's ignore list
#      (README, .DS_Store, *.bak via .stowrc) instead of reimplementing it.
#
#   2. Integrity — walk the package's footprint in the target. A symlink that
#      dangles, or that sits on a path this package owns but resolves somewhere
#      other than this package, is a fault. Stow never reports either: from its
#      point of view the work is already done.
#
# Runs under stock macOS /bin/bash (3.2) — a fresh machine has nothing newer.
#
# Usage: verify.sh [--repo DIR] [--target DIR] [--links-only] PACKAGE...
set -euo pipefail

usage() {
  echo "Usage: $(basename "$0") [--repo DIR] [--target DIR] [--links-only] PACKAGE..." >&2
  echo "  --repo DIR     dotfiles checkout (default: parent of this script)" >&2
  echo "  --target DIR   where symlinks live (default: \$HOME)" >&2
  echo "  --links-only   skip the 'brew bundle check' against Brewfile" >&2
  exit 2
}

REPO="$(cd "$(dirname "$0")/.." && pwd -P)"
TARGET="$(cd "$HOME" && pwd -P)"
LINKS_ONLY=0
PACKAGES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)       REPO="$(cd "$2" && pwd -P)"; shift 2 ;;
    --target)     TARGET="$(cd "$2" && pwd -P)"; shift 2 ;;
    --links-only) LINKS_ONLY=1; shift ;;
    -h|--help)    usage ;;
    -*)           echo "Unknown option: $1" >&2; usage ;;
    *)            PACKAGES+=("$1"); shift ;;
  esac
done
[[ ${#PACKAGES[@]} -gt 0 ]] || usage

# Colours only on a terminal — CI logs and test output stay clean.
if [[ -t 1 ]]; then
  GREEN=$'\033[0;32m'; RED=$'\033[0;31m'; NC=$'\033[0m'
else
  GREEN=''; RED=''; NC=''
fi

FAILED=0
PROBLEMS=''

problem() {
  PROBLEMS="${PROBLEMS}    $1"$'\n'
}

# Collapse '.' and '..' segments without touching the filesystem, so a
# dangling link's target can still be compared against the repo path.
# String-based on purpose: bash 3.2 collapses a quoted array slice into one
# word, which silently broke the array version of this.
normpath() {
  local IFS=/ seg out=''
  for seg in $1; do
    case "$seg" in
      ''|.) ;;
      ..)   out="${out%/*}" ;;
      *)    out="$out/$seg" ;;
    esac
  done
  printf '%s' "${out:-/}"
}

# Absolute, normalised path a symlink points at — even if it dangles.
link_dest() {
  local raw
  raw="$(readlink "$1")"
  [[ "$raw" = /* ]] || raw="$(dirname "$1")/$raw"
  normpath "$raw"
}

# --- check 1: completeness ---------------------------------------------------
# Anything stow still wants to do, or complains about, is a problem.
check_pending() {
  local pkg="$1" line
  while IFS= read -r line; do
    [[ -n "$line" ]] || continue
    case "$line" in
      "WARNING: in simulation mode"*|"All operations aborted."*) continue ;;
    esac
    problem "$line"
  done < <(cd "$REPO" && stow --target="$TARGET" --verbose=1 -n "$pkg" 2>&1 || true)
}

# --- check 2: integrity ------------------------------------------------------
# <pkg> <link>  — the link sits on a path this package owns.
check_owned_link() {
  local pkg="$1" link="$2" resolved
  if [[ ! -e "$link" ]]; then
    problem "broken link: ${link#"$TARGET"/} -> $(readlink "$link")"
  else
    resolved="$(cd "$(dirname "$link")" && readlink -f "$link")"
    [[ "$resolved" == "$REPO/$pkg"/* ]] \
      || problem "points outside package: ${link#"$TARGET"/} -> $resolved"
  fi
}

check_footprint() {
  local pkg="$1" pkgdir="$REPO/$1"
  local dir rel tdir entry name
  while IFS= read -r dir; do
    rel="${dir#"$pkgdir"}"; rel="${rel#/}"
    tdir="$TARGET${rel:+/$rel}"
    if [[ -L "$tdir" ]]; then
      # Folded directory link — owned by this package by construction.
      check_owned_link "$pkg" "$tdir"
    elif [[ -d "$tdir" ]]; then
      for entry in "$tdir"/* "$tdir"/.[!.]*; do
        [[ -L "$entry" ]] || continue
        name="${entry##*/}"
        if [[ -e "$pkgdir${rel:+/$rel}/$name" ]]; then
          check_owned_link "$pkg" "$entry"
        elif [[ ! -e "$entry" && "$(link_dest "$entry")" == "$pkgdir"/* ]]; then
          # Not in the package any more, yet still pointing into it: a rename
          # left this dangling.
          problem "broken link: ${entry#"$TARGET"/} -> $(readlink "$entry")"
        fi
      done
    fi
  done < <(find "$pkgdir" -type d)
}

# --- run ---------------------------------------------------------------------
for pkg in "${PACKAGES[@]}"; do
  PROBLEMS=''
  if [[ ! -d "$REPO/$pkg" ]]; then
    problem "no such package directory: $REPO/$pkg"
  else
    check_pending "$pkg"
    check_footprint "$pkg"
  fi
  if [[ -z "$PROBLEMS" ]]; then
    echo "${GREEN}✓${NC} $pkg"
  else
    echo "${RED}✗${NC} $pkg"
    printf '%s' "$PROBLEMS"
    FAILED=1
  fi
done

if [[ $LINKS_ONLY -eq 0 ]]; then
  # --no-upgrade: presence, not freshness — a newer bottle upstream isn't drift.
  if brew_out="$(brew bundle check --no-upgrade --file="$REPO/Brewfile" 2>&1)"; then
    echo "${GREEN}✓${NC} Brewfile"
  else
    echo "${RED}✗${NC} Brewfile"
    printf '%s\n' "$brew_out" | sed 's/^/    /'
    FAILED=1
  fi
fi

exit $FAILED
