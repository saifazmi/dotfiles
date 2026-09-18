#!/bin/bash
# check-packages.sh — the Makefile's PACKAGES list must match the package
# directories on disk, in both directions. Catches adding a package directory
# and forgetting the Makefile (or the reverse), which nothing else reports.
#
# Usage: check-packages.sh [--repo DIR]
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd -P)"
[[ "${1:-}" == "--repo" ]] && REPO="$(cd "$2" && pwd -P)"

# Top-level directories that are not stow packages. Dot-directories
# (.git, .github, .claude, ...) are skipped outright — packages are tool names.
NON_PACKAGE_DIRS="_old_dots_ docs scripts tests"
# Package-shaped but deliberately left out of PACKAGES (experimental).
EXCLUDED_PACKAGES="ghostty"

packages="$(sed -n 's/^PACKAGES[[:space:]]*:=[[:space:]]*//p' "$REPO/Makefile")"
[[ -n "$packages" ]] || { echo "PACKAGES not found in $REPO/Makefile" >&2; exit 2; }

in_list() { local x; for x in $2; do [[ "$x" == "$1" ]] && return 0; done; return 1; }

status=0
for pkg in $packages; do
  [[ -d "$REPO/$pkg" ]] || { echo "in PACKAGES but no directory on disk: $pkg"; status=1; }
done

shopt -s nullglob dotglob
for dir in "$REPO"/*/; do
  name="${dir%/}"; name="${name##*/}"
  [[ "$name" == .* ]] && continue
  in_list "$name" "$NON_PACKAGE_DIRS $EXCLUDED_PACKAGES" && continue
  in_list "$name" "$packages" || { echo "package directory not in PACKAGES: $name"; status=1; }
done

# shellcheck disable=SC2086  # word-splitting $packages is the point
[[ $status -eq 0 ]] && echo "✓ PACKAGES matches disk ($(set -- $packages; echo $#) packages)"
exit $status
