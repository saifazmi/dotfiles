# Contributing

Notes for extending and maintaining this repo. This is a personal, single-maintainer
dotfiles repo rather than an open-source project accepting external PRs — these are
notes for future-me (or anyone poking around) on how the pieces fit together and how
to add to them.

## Repository Structure

### How GNU Stow Works

This repository uses **GNU Stow** for symlink management. Each subdirectory is a **stow package** containing configuration files organized as they should appear in your home directory.

**Example:** When you run `stow zsh`, it creates symlinks:

```bash
~/.zshrc → ~/dotfiles/zsh/.zshrc
```

**Benefits:**

- All configs version controlled in one place
- Changes in `~/dotfiles/` automatically reflect in `~/` (via symlinks)
- Easy to deploy to new machines
- Selective installation (e.g., skip GUI tools on servers)

### Directory Layout

```txt
dotfiles/
├── .editorconfig              # Editor formatting rules
├── .gitignore                 # Git ignore patterns
├── .pre-commit-config.yaml    # Pre-commit hooks (gitleaks)
├── .stowrc                    # Stow configuration
├── Brewfile                   # Homebrew packages (essential, always installed)
├── Brewfile.hardware          # Peripheral-bound apps/drivers (opt-in)
├── Brewfile.mas               # Mac App Store apps via mas (opt-in)
├── Brewfile.optional          # Nice-to-have apps (opt-in)
├── CONTRIBUTING.md            # This file
├── install.sh                 # Bootstrap script for new machines
├── Makefile                   # Dotfiles management commands
├── README.md                  # User-facing documentation
│
├── bat/
├── btop/
├── git/
├── htop/
├── iterm2/
├── lazygit/
├── nvim/
├── tmux/
├── vim/
├── yazi/
└── zsh/
```

All packages follow the **XDG Base Directory** specification (defined in [`./zsh/.zshenv`](/zsh/.zshenv)) with configs in `.config/` subdirectories.

## How `.stowrc` Works

The `.stowrc` file contains global configuration for stow:

- **Target:** Where symlinks are created (`$HOME`)
- **Verbosity:** Shows what stow is doing
- **Ignore patterns:** Files to skip (`.DS_Store`, `.swp`, `.bak`, etc.)

Stow also has [built-in ignore patterns](https://github.com/aspiers/stow/blob/master/default-ignore-list) for common files like `.git`, `README`, `LICENSE`, etc.

## Adding New Dotfiles

### 1. Create Package Directory

```bash
# Example: Adding ripgrep config
mkdir -p ripgrep/.config/ripgrep
```

### 2. Add Configuration Files

```bash
# Move your config file into the package
mv ~/.config/ripgrep/config ripgrep/.config/ripgrep/config
```

### 3. Update Makefile

Edit `Makefile` and add `ripgrep` to the `PACKAGES` variable:

```makefile
PACKAGES := bat btop git htop lazygit nvim ripgrep tmux vim yazi zsh
```

### 4. Test and Stow

```bash
make test-ripgrep    # Dry run
make stow-ripgrep    # Install
```

### 5. Commit Changes

```bash
git add ripgrep/
git commit -m "[ripgrep] add configuration"
git push
```

## Adding Homebrew Packages

Four Brewfiles, picked by how essential the package is and where it makes sense:

| File | Put it here when… | Installed by `make install` |
|---|---|---|
| `Brewfile` | Needed for a functioning setup on any machine | Always |
| `Brewfile.hardware` | Only useful with specific hardware attached (docks, Stream Deck, Logitech) | Asks `y/N` |
| `Brewfile.optional` | Nice to have, not needed to work | Asks `y/N` |
| `Brewfile.mas` | Mac App Store only — needs `mas` and an App Store sign-in | Asks `y/N` |

Keep each category alphabetised. Formulae from third-party taps need
`trusted: true` (e.g. `brew 'owner/tap/name', trusted: true`) — Homebrew
refuses to load untrusted taps on a fresh machine, and `brew bundle` reads
trust from the Brewfile. `make lint` checks that every file parses and every
name resolves, without installing anything.

## Updating Dotfiles

See the [README's Updating Dotfiles section](README.md#updating-dotfiles) for the quick version. The detail that matters for maintaining this repo: whether you need a restow depends on *what* you changed.

### On This Machine

Editing an existing file is live immediately — the symlink points straight at the repo, so there's nothing to restow:

```bash
nvim ~/.config/nvim/init.lua   # edit directly; changes reflect through the symlink
git add .
git commit -m "[nvim] update plugin configuration"
git push
```

Adding a **new file** to a package is different — Stow only knows about symlinks it's already created, so a new file needs an explicit restow to get linked:

```bash
make restow-nvim   # re-link after adding a new file to the nvim package
git add .
git commit -m "[nvim] add new plugin"
git push
```

### On Other Machines

```bash
cd ~/dotfiles
git pull
make restow  # re-links all packages, including any newly added files
```

## FAQ

### Why use `--ignore='PATTERN'` in .stowrc instead of .stow-local-ignore files?

**Short answer:** `.stowrc` applies globally to all packages, while `.stow-local-ignore` must be duplicated in every package directory.

**Details:**

- `.stow-local-ignore` files must be placed **inside each package directory** (e.g., `nvim/.stow-local-ignore`, `zsh/.stow-local-ignore`), not in the repository root
- With 10 packages, you'd need to maintain 10 separate ignore files with identical content
- Using `--ignore` patterns in `.stowrc` applies the same rules globally from one centralized location
- Easier to maintain: add a pattern once in `.stowrc` instead of updating 10 files
- See [stow issue #119](https://github.com/aspiers/stow/issues/119#issuecomment-3260242719) for technical details

**When to use .stow-local-ignore:** Only when a specific package needs unique ignore patterns different from the global rules.

### Why use a Makefile instead of `stow .` or `stow *`?

**Short answer:** Safety, convenience, and explicit control over what gets stowed.

**Problems with alternatives:**

- `stow .` - Tries to stow the current directory itself (incorrect usage)
- `stow *` - Includes unwanted items like `README.md`, `.git/`, `CLAUDE.md`, `Makefile`, `Icon`, etc.
- Pattern matching like `stow [a-z]*/` works but is cryptic and error-prone

**Benefits of the Makefile:**

- **Explicit package list** - Only stows exactly what's defined in `PACKAGES`
- **Safety features** - `make test` for dry runs before making changes
- **Convenience** - Single commands for common operations (`make stow`, `make restow`)
- **Help system** - `make help` shows all available commands
- **Individual control** - `make stow-nvim` to manage specific packages
- **Utilities** - Status checking and broken symlink cleanup
- **Better UX** - Color-coded output shows what's happening
- **Self-documenting** - Comments and help text explain each target

The Makefile serves as both a convenience tool and documentation of how to manage the dotfiles.
