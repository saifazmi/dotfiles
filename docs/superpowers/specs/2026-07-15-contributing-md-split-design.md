# CONTRIBUTING.md Split — Design

## Purpose

`README.md` has grown to ~490 lines by mixing two audiences: someone setting up
these dotfiles on a new machine, and the maintainer (Saif) extending/reorganizing
the repo later. This mixes "how do I use this" with "how do I maintain this,"
making the README harder to scan for first-time setup.

This is a personal, single-maintainer repo — not aiming for external contributors
or a formal PR process. `CONTRIBUTING.md` here means "notes for extending and
maintaining this repo," not a standard OSS contribution-process document.

## Scope

Split `README.md` into a trimmed, user-facing `README.md` plus a new
`CONTRIBUTING.md` holding maintainer/extension content. Also fix an existing
duplication issue surfaced while mapping the split (see below). Update
`CLAUDE.md`'s file listing to match.

Out of scope: resolving [SIZM-18](https://linear.app/sizm/issue/SIZM-18/readme-add-folds-where-required)
(README folding markers decision) — flagged as likely affected by this trim, but
left for a separate pass.

## Content Mapping

### New `CONTRIBUTING.md` (repo root)

1. Short intro — notes for extending/maintaining this repo
2. **Repository Structure** — how GNU Stow works + directory layout (moved as-is)
3. **How `.stowrc` Works** (moved as-is)
4. **Adding New Dotfiles** (moved as-is: create package → add config → update
   Makefile → test/stow → commit)
5. **Updating Dotfiles** (moved as-is: editing on current machine vs. pulling on
   other machines)
6. **FAQ** — both existing Q&As (`.stowrc` vs `.stow-local-ignore`; Makefile vs
   raw `stow *`) — these explain repo-design rationale, not usage

### Trimmed `README.md`

Stays user-facing. Keeps, in order: header, What's Inside, Features,
Prerequisites, Quick Start, Installation, Usage, Troubleshooting, Best
Practices, Security Notes, Theming, Resources, License, Acknowledgments.

**Installation** section is merged with the old **Migrating to a New Machine**
section, which was ~90% duplicate (clone → `make install` → `make test` →
`make stow`). The one net-new step it had — `pre-commit install` — is folded
into Installation as a final sub-step. **Migrating to a New Machine** is then
deleted entirely.

Add a one-line pointer (near Resources, or top-level) linking to
`CONTRIBUTING.md` for anyone wanting to add new dotfiles or understand repo
internals.

### `CLAUDE.md` update

Add `CONTRIBUTING.md` to the "Repository Root Files" listing so it stays
accurate.

## Non-goals

- No change to the actual Makefile targets, stow behavior, or any config package.
- No formal PR/branching process written into CONTRIBUTING.md — this repo
  doesn't have external contributors today.
- Not resolving SIZM-18 (folds in README/CONTRIBUTING) — separate decision.

## Testing / Verification

Doc-only change. Verification is manual read-through:
- Confirm no content was lost (diff old README against README + CONTRIBUTING
  combined).
- Confirm no dangling internal links (e.g. `#installation` anchor references)
  point to now-moved sections.
- Confirm Markdown renders correctly (headers, code fences, lists).
