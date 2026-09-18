# Testing and QA — Design

Covers [SIZM-19](https://linear.app/sizm/issue/SIZM-19/testing-and-qa) and its
children: [SIZM-28](https://linear.app/sizm/issue/SIZM-28) (confirm local setup),
[SIZM-20](https://linear.app/sizm/issue/SIZM-20) (UTM VM fresh-install test), and
[SIZM-21](https://linear.app/sizm/issue/SIZM-21) (GitHub Action).

## Purpose

This repo has no automated verification of any kind. Nothing catches a package
added but left out of the Makefile, a symlink broken by a rename, a real file
silently shadowing one that should be linked, or a typo in a Brewfile. The only
current signal is `make status`, which infers state from `grep -q "^LINK:"` on
`stow -nv` output — that reports whether stow *wants* to do work, which is not
the same question as whether the machine is set up correctly.

The goal is a single definition of "correctly set up" that runs in three places:
on a working machine, inside a fresh VM, and in CI.

## Architecture

One verifier, three drivers. `scripts/verify.sh` owns the definition of correct.
SIZM-28 runs it on a real machine, SIZM-20's harness runs it inside a VM guest
over SSH, SIZM-21 runs it on a GitHub runner. The Brewfile restructure and the CI
tiers hang off that spine.

Rejected: per-context checks tuned to each environment (three things to keep in
sync, and "correct" ends up meaning three different things), and implementing
verification as Make recipes (needs loops, path arithmetic and `readlink -f`
comparisons; must also run standalone inside a guest where the repo may not be at
`$HOME/dotfiles`).

## Component 1 — The verifier

`scripts/verify.sh`, exposed as `make verify`. Walks `PACKAGES`; for every file
in each package, computes the target path under the stow target and asserts:

| Check | Failure it catches |
|---|---|
| Link resolves into this repo | Link points at `_old_dots_` or another checkout |
| Link target exists | Broken symlink left after a repo-side rename |
| No shadowing real file | A real `~/.zshrc` where a link belongs — stow skips it silently and `make stow` still exits 0 |
| Nothing in the package is unstowed | File added to a package but never restowed |

Interface:

```
make verify                       # links, plus `brew bundle check --file=Brewfile`
make verify-nvim                  # single package, links only
scripts/verify.sh --links-only    # skip the brew check (CI fast tier, nothing installed)
```

Exit 0 clean, exit 1 on any failure. One line per package (`✓ nvim` / `✗ tmux`)
with failing paths indented beneath, reusing the Makefile's colour variables.

`make verify` delegates to the script, consistent with how `install` already
shells out to `install.sh`.

The `iterm2` package needs no special handling: its target path
(`~/Library/Application Support/iTerm2/DynamicProfiles/`) is mirrored by the
package layout, so the generic "package-relative path under target" rule covers
it.

**Non-goals:** it verifies wiring, not content (not that your tmux config is
*good*); and it ignores `Brewfile.optional` / `.mas` / `.hardware`, which are
opt-in by design — their absence is not a failure.

**Testing:** built test-first against fixture package directories stowed into a
scratch target, with planted faults — broken link, shadowing real file, unstowed
new file, link into a different checkout — each asserted to exit 1 and name the
offending path.

## Component 2 — Shared prerequisites

Both CI and the VM harness need to drive existing scripts unattended. Three small
changes, no local behaviour change:

- `install.sh` is interactive — three `read -rp` prompts hang any unattended run.
  Add `DOTFILES_NONINTERACTIVE=1` (env var, not a flag; env survives `ssh host bash -s`).
  It takes each `[y/N]` default rather than answering yes — auto-yes would pull
  `Brewfile.optional` and `Brewfile.mas` into every unattended run.
- `install.sh` hardcodes `DOTFILES="$HOME/dotfiles"`; a CI checkout lives at
  `$GITHUB_WORKSPACE`. Change to `DOTFILES="${DOTFILES:-$HOME/dotfiles}"`.
- `Makefile` gains `STOW_TARGET ?= $(HOME)`, passed as `--target=$(STOW_TARGET)`,
  so CI can stow into a scratch directory through the normal `make` interface
  rather than bypassing it.

## Component 3 — `Brewfile.hardware`

Peripheral-bound casks are meaningless on a machine without those peripherals,
and they are the ones that hang an unattended VM run (no passwordless sudo in a
default guest, so pkg-based casks prompt for a password).

Moves out of `Brewfile`:

```
cask 'displaylink'          # DisplayLink dock/monitor driver
cask 'elgato-stream-deck'   # Stream Deck
cask 'logi-options+'        # Logitech peripherals
```

Stays: `1password` / `1password-cli` (install cleanly; only sign-in is manual).
Stays: `aldente`, `sensei` — currently under `# Hardware & drivers` but not
peripheral-bound; they work on any Mac laptop.

Note that GitHub's macOS runners *do* have passwordless sudo, so most pkg casks
install there. This split is justified by portability first; unblocking the VM
and cutting wall-clock time are the payoffs.

Forced changes: new `Brewfile.hardware` (header-comment style matching
`.optional` / `.mas`); `install.sh` gains a third `y/N` prompt placed *before*
optional/mas; `README.md`, `SOFTWARE.md`, `CONTRIBUTING.md`, `CLAUDE.md` and the
`Makefile` install help text all reference four Brewfiles.

## Component 4 — CI (SIZM-21)

Public repo, so macOS runner minutes are free; wall-clock time and flakiness are
the real constraints.

**`ci.yml` — fast tier.** Push to `master` and PRs, `runs-on: macos-latest`,
target 2–3 minutes:

1. `make lint` — `actionlint` on workflows; `shellcheck` on `install.sh` and
   `scripts/*.sh`; `scripts/check-brewfiles.sh`; `scripts/check-packages.sh`
2. `bats tests` — the verifier's own suite and the two check scripts' suites
3. `make stow STOW_TARGET=<scratch>` — every package into a scratch target,
   asserting exit 0 and zero conflicts
4. `make verify STOW_TARGET=<scratch> VERIFY_FLAGS=--links-only`

`check-brewfiles.sh`: `brew bundle list` parses each file, but it is
**syntax-only** — it accepts names that do not exist. So the script then runs
`brew info` over every formula and cask name collected from the three Homebrew
files, which does fail on unknown names. `Brewfile.mas` is parse-only (`mas`
names need an App Store session to resolve). Nothing is installed.

`check-packages.sh`: drift guard — `PACKAGES` in the Makefile must match the
package directories on disk in both directions. Dot-directories are never
packages; `ghostty/` is a known exception (package-shaped but deliberately
excluded).

**Learned from the first real runs (2026-09-19):**

- `brew info` does not auto-tap. Names like `hashicorp/tap/terraform` only
  resolved locally because the tap was already present. `check-brewfiles.sh`
  taps every tap the Brewfiles reference before resolving.
- All scripts pin `#!/bin/bash` and must stay correct on stock **bash 3.2** — a
  fresh Mac (runner or VM) has nothing newer. Quoted array slices collapse to
  one word on 3.2 and silently broke the verifier's `normpath`; it is now
  string-based. The bats suites run under 3.2 as a result, which is the guard.
- `workflow_dispatch` cannot start a workflow that exists only on a side
  branch, so throwaway validation pushes a copy of `ci.yml` with the branch
  added to `push.branches`. The committed `ci.yml` stays `[master]` only.

**`ci-full.yml` — full tier.** `workflow_dispatch` + weekly `schedule`.
`install.sh` end-to-end, then `make stow`, then full `make verify`. 30–60 min,
kept off the push path so a Homebrew-side outage never blocks a commit.

**On `act`:** SIZM-21 specifies validating with `act` before pushing. `act` runs
Docker Linux containers and cannot execute `runs-on: macos-*` at all. The
substitute is `actionlint` for static validation plus a throwaway branch push to
exercise the real runner. SIZM-21's description needs updating to match.

## Component 5 — UTM harness (SIZM-20)

**One-time manual prerequisite — the golden base VM.** The macOS install and
Setup Assistant cannot be scripted; this is built by hand once and then never
booted directly:

- macOS guest on Apple Virtualization, Setup Assistant completed, user `tester`
- Remote Login enabled, public key in `authorized_keys`
- `NOPASSWD` sudo for `tester` — stops pkg-based casks hanging on a password
- Deliberately **no** Xcode CLT and **no** Homebrew — installing those is what is
  under test
- Shut down clean, named `dotfiles-base`

Documented as a runbook in `docs/` so it is reproducible when the image goes
stale on a new macOS release.

**`scripts/vm-test.sh`.** Per run: `utmctl clone dotfiles-base` to a timestamped
throwaway; `utmctl start`; poll for SSH; deliver the repo; run
`DOTFILES_NONINTERACTIVE=1 ./install.sh`, `make stow`, `make verify`, streaming to a local
log; `utmctl stop` and `utmctl delete` the clone (`--keep` leaves it up for
post-mortem). Exit code is the guest's `make verify` exit code.

Source modes: `--working-tree` (default) rsyncs the working copy including
uncommitted changes — the mode that matters given the state
[SIZM-29](https://linear.app/sizm/issue/SIZM-29) describes; `--ref <sha>` clones
a pushed commit, matching what CI sees.

**Open question to settle before building:** how the harness finds the guest.
`utmctl ip-address` depends on a guest agent that Apple Virtualization macOS
guests do not run, so it is expected to return nothing. Fallback is mDNS — ssh to
`dotfiles-base.local`, which works because only one clone runs at a time and it
inherits the base's hostname. To be confirmed by a short probe before
implementation; if it fails, the harness design changes here and nowhere else.

**Guard rails:** refuse to run if the target name resolves to the base VM, so a
bug cannot destroy the golden image; assert no clone is already running, since
Apple's licence caps macOS guests at 2 per host.

**Cost:** each clone is a full macOS disk image and a run takes 30–60 minutes.
This is a release gate, not a per-commit check.

## Component 6 — SIZM-28

With the verifier in place this is `make verify` on the dev machine and the
personal laptop, then fixing what it reports. Running it against the current
messy working tree is also the best first test of the verifier — if it comes back
clean here, it is wrong. Expected findings include `zsh/.zsh/` and several new
nvim files that are untracked and likely never restowed.

## Build order

| # | Work | Depends on |
|---|---|---|
| 1 | Prereqs: `DOTFILES_NONINTERACTIVE`, `DOTFILES` override, `STOW_TARGET` | — |
| 2 | Verifier + its tests | 1 |
| 3 | SIZM-28 — run on both machines, fix drift | 2 |
| 4 | `Brewfile.hardware` split + doc updates | — (parallel) |
| 5 | SIZM-21 fast tier | 1, 2 |
| 6 | SIZM-21 full tier | 1, 4 |
| 7 | SIZM-20 VM harness | 1, 2, 4 |

Value lands at step 3: a real answer about both machines before any CI or VM work
exists.

This is too much for one implementation plan. Steps 1–3 form a coherent first
plan — the verifier spine, ending with both machines actually checked. Steps 4–7
follow as a second plan once the verifier has been proven against real drift.

## Linear changes

Proposed, pending approval. No status changes anywhere — per repo convention,
tickets are only marked Done by the user.

- Give SIZM-19 a description summarising this strategy (currently empty)
- Add three children: *prereqs*, *shared verifier*, *`Brewfile.hardware` split* —
  steps 1, 2 and 4 are currently unticketed, and step 2 is the largest single
  piece of work
- Update SIZM-21's description: `act` → `actionlint` plus throwaway-branch
  validation

## Non-goals

- Testing config *content* — only that wiring is correct
- Automating the golden base VM's creation (Setup Assistant is not scriptable)
- Running the full install on every push
- Any change to `ghostty/`'s excluded status
