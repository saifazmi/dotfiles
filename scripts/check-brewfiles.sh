#!/bin/bash
# check-brewfiles.sh — every Brewfile must parse, and every formula and cask
# name must be something Homebrew knows about. `brew bundle list` alone is
# syntax-only: it happily lists names that do not exist. Nothing is installed.
#
# Usage: check-brewfiles.sh [FILE...]    (default: the repo's Brewfile*)
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd -P)"
if [[ $# -gt 0 ]]; then files=("$@"); else files=("$REPO"/Brewfile "$REPO"/Brewfile.*); fi

status=0
formulae=()
casks=()

for f in "${files[@]}"; do
  if ! out="$(brew bundle list --all --file="$f" 2>&1 >/dev/null)"; then
    echo "✗ ${f##*/} does not parse"
    printf '%s\n' "$out" | sed 's/^/    /'
    status=1
    continue
  fi
  echo "✓ ${f##*/} parses"
  # mas entries need an App Store session to resolve — parse-only.
  [[ "$f" == *.mas ]] && continue
  while IFS= read -r n; do [[ -n "$n" ]] && formulae+=("$n"); done < <(brew bundle list --formula --file="$f")
  while IFS= read -r n; do [[ -n "$n" ]] && casks+=("$n"); done < <(brew bundle list --cask --file="$f")
done

# `brew info` does not auto-tap, so tap everything the Brewfiles reference:
# declared `tap` lines plus the owner/repo prefix of any owner/repo/name entry.
# `brew tap` is idempotent; the Brewfile declaring a tap is what makes it trusted.
taps=()
for f in "${files[@]}"; do
  [[ "$f" == *.mas ]] && continue
  while IFS= read -r t; do [[ -n "$t" ]] && taps+=("$t"); done < <(brew bundle list --tap --file="$f" 2>/dev/null)
done
for n in ${formulae[@]+"${formulae[@]}"} ${casks[@]+"${casks[@]}"}; do
  [[ "$n" == */*/* ]] && taps+=("${n%/*}")
done
for t in $(printf '%s\n' ${taps[@]+"${taps[@]}"} | sort -u); do
  if brew tap "$t" >/dev/null 2>&1; then
    echo "✓ tap $t"
  else
    echo "✗ cannot tap $t"
    status=1
  fi
done

# resolve <formula|cask> NAME...  — `brew info` fails on any unknown name.
resolve() {
  local kind="$1"; shift
  [[ $# -gt 0 ]] || return 0
  if out="$(brew info --"$kind" --json=v2 "$@" 2>&1 >/dev/null)"; then
    echo "✓ $# $kind name(s) resolve"
  else
    echo "✗ unknown $kind name(s):"
    printf '%s\n' "$out" | sed 's/^/    /'
    status=1
  fi
}

# ${arr[@]+"${arr[@]}"} — empty-array-safe under `set -u` on bash 3.2
resolve formula ${formulae[@]+"${formulae[@]}"}
resolve cask ${casks[@]+"${casks[@]}"}
exit $status
