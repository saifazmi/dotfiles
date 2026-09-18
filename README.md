# Dotfiles

Personal configuration files for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Inside

This repository contains configuration files for the following tools:

### Main Tools

- **[zsh](https://www.zsh.org/)** - Shell configuration with Zinit, Oh My Posh, and integrations - see [zsh/README.md](zsh/README.md)
- **[tmux](https://github.com/tmux/tmux)** - Terminal multiplexer with plugins and Catppuccin theme - see [tmux/README.md](tmux/README.md)
- **[neovim](https://neovim.io/)** - Modern Vim-based text editor with extensive plugin setup
- **[vim](https://www.vim.org/)** - Classic text editor configuration
- **[git](https://git-scm.com/)** - Version control with GPG signing enabled

### Utilities

- **[iterm2](https://iterm2.com/)** - Terminal emulator
- **[bat](https://github.com/sharkdp/bat)** - Cat clone with syntax highlighting
- **[yazi](https://github.com/sxyazi/yazi)** - Terminal file manager
- **[lazygit](https://github.com/jesseduffield/lazygit)** - Terminal UI for git
- **[btop](https://github.com/aristocratos/btop)** - System resource monitor
- **[htop](https://htop.dev/)** - Interactive process viewer

### Shell Integrations

- **[zinit](https://github.com/zdharma-continuum/zinit)** - Fast and flexible Zsh plugin manager
- **[oh my posh](https://ohmyposh.dev/)** - Prompt theming engine for Zsh (custom theme w/ Catppuccin Mocha palette)
- **[fzf](https://junegunn.github.io/fzf/)** - Command-line fuzzy finder
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - Smart directory jumper (smarter cd command)
- **[thefuck](https://github.com/nvbn/thefuck)** - Corrects errors in previous console commands

### Language & Package Managers

- **[uv](https://docs.astral.sh/uv)** - Ultra-fast Python version manager (configured via Zsh config)
- **[nvm](https://github.com/nvm-sh/nvm)** - Node version manager (configured via Zsh config)
- **[bun](https://bun.sh/)** - Fast JavaScript runtime and all-in-one toolkit (configured via Zsh config)
- **[pnpm](https://pnpm.io/)** - Fast, disk space efficient package manager for Node.js (configured via Zsh config)
- **[rbenv](https://github.com/rbenv/rbenv#readme)** - Ruby version manager (configured via Zsh config)

### Dev Tools

- **[ngrok](https://ngrok.com/)** - Secure tunnels to localhost

## Features

- 🔗 **GNU Stow** - Symlink management for clean, version-controlled configs
- 🛠️ **Makefile** - Simple commands for managing all dotfiles
- 📁 **XDG compliant** - All configs follow XDG Base Directory specification
- 📦 **Modular structure** - Each tool isolated in its own package
- 🎨 **Consistent theming** - Catppuccin Mocha across all tools
- 🪭 **Folding markers** - Consistent `{{{` `}}}` structure for organized, foldable configs
- 🔐 **Security** - GPG commit signing, gitleaks pre-commit hooks
- 🍎 **macOS optimized** - Tested on macOS with Apple Silicon

## Prerequisites

- **macOS**
- **Git** - to clone the repo (pre-installed on macOS via Xcode CLT)

Everything else (Homebrew, GNU Stow, all packages) is handled by `make install`. It installs the essentials from `Brewfile` unconditionally, then asks three separate `y/N` questions: whether to install hardware-specific apps and drivers (`Brewfile.hardware` — DisplayLink, Stream Deck, Logitech; only useful with that hardware attached), whether to also install nice-to-have apps (`Brewfile.optional`), and whether to install a hand-picked set of Mac App Store apps via `mas` (`Brewfile.mas`, requires being signed into the App Store first or those entries silently fail). The rest of the App Store apps on this machine, plus a couple that can't be scripted at all, are listed in [SOFTWARE.md](SOFTWARE.md) — install those manually if you need them.

## Quick Start

```bash
git clone git@github.com:saifazmi/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install    # Bootstrap: Xcode CLT → Homebrew → packages (via Brewfile)
make test       # Preview symlinks (dry run)
make stow       # Apply dotfiles
```

For detailed installation steps and options, see [Installation](#installation) below.

## Installation

### 1. Clone the Repository

```bash
git clone git@github.com:saifazmi/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Preview Changes

Always test before stowing to see what will happen:

```bash
make test
```

This runs `stow -n` (dry run) and shows you what symlinks would be created without actually making any changes.

### 3. Install Dotfiles

**Option A: Install everything**

```bash
make stow
```

**Option B: Install specific packages**

```bash
make stow-nvim    # Install just Neovim config
make stow-zsh     # Install just Zsh config
make stow-tmux    # Install just Tmux config
```

**Option C: Manual stow**

```bash
stow nvim zsh tmux git
```

### 4. Verify Installation

```bash
make status       # Check which packages are stowed
ls -la ~/.config  # Verify symlinks created
```

### 5. Set Up Pre-Commit Hooks

This repository uses [pre-commit](https://pre-commit.com/) to run [Gitleaks](https://github.com/gitleaks/gitleaks) before each commit to prevent secrets from being committed.

**On a new machine, you need to:**

1. **Install pre-commit:**

   ```bash
   # Via Homebrew (recommended)
   brew install pre-commit

   # Or via pip
   pip install pre-commit
   ```

2. **Install the git hooks:**

   ```bash
   cd ~/dotfiles
   pre-commit install
   ```

   This creates the git hook scripts in `.git/hooks/` that will run before each commit.

3. **Verify installation (optional):**
   ```bash
   pre-commit run --all-files
   ```
   This runs all hooks against all files to ensure everything works correctly.

**What happens on commit:**

- Before your commit is created, Gitleaks scans all staged files for potential secrets
- If secrets are detected, the commit is blocked and you'll see which files have issues
- Fix the issues, stage the changes, and try committing again
- If no secrets are found, the commit proceeds normally

**Troubleshooting:**

```bash
# Update pre-commit hooks to latest versions
pre-commit autoupdate

# Clear pre-commit cache (if hooks misbehave)
pre-commit clean

# Skip hooks for a specific commit (use with caution!)
git commit --no-verify -m "message"
```

**Note:** The `.pre-commit-config.yaml` file in the repository root defines which hooks run. Currently configured: Gitleaks v8.30.0.

## Usage

The included `Makefile` provides convenient commands for managing dotfiles:

### Main Operations

```bash
make help      # Show all available commands
make install   # Bootstrap a new machine (Xcode CLT + Homebrew + packages via Brewfile)
make stow      # Stow all packages
make restow    # Restow all packages (useful after changes)
make unstow    # Unstow all packages (remove symlinks)
make test      # Dry run - show what would be stowed
```

### Individual Package Operations

```bash
make stow-PACKAGE      # Stow a specific package
make restow-PACKAGE    # Restow a specific package
make unstow-PACKAGE    # Unstow a specific package
make test-PACKAGE      # Test a specific package (dry run)
make adopt-PACKAGE     # Import existing $HOME files into a package (review git diff after)
```

**Examples:**

```bash
make stow-nvim         # Stow Neovim config
make restow-zsh        # Restow Zsh config (after editing)
make unstow-tmux       # Remove Tmux symlinks
make test-git          # Preview Git config stow
make adopt-nvim        # Import existing ~/.config/nvim into the nvim package
```

### Utilities

```bash
make status      # Show status of all packages
make clean       # Remove broken symlinks from home directory
make adopt       # Adopt all packages (import existing $HOME files - review git diff after)
```

## Updating Dotfiles

### On This Machine

Since dotfiles are symlinked via Stow, edits to any config file take effect immediately — no restow needed.

```bash
nvim ~/.config/nvim/init.lua   # edit directly; changes reflect through the symlink
```

If you added a **new file** to a package, restow that package so Stow creates the new symlink:

```bash
make restow-nvim   # re-link after adding a new file to the nvim package
```

Then commit and push as usual:

```bash
git add .
git commit -m "[nvim] description of change"
git push
```

### On Other Machines

Pull the latest changes and restow to pick up any new symlinks:

```bash
git pull
make restow       # re-links all packages, including any newly added files
```

For the full walkthrough (including when a restow is actually needed), see [CONTRIBUTING.md](CONTRIBUTING.md#updating-dotfiles).

## Troubleshooting

### Conflicts During Stow

**Error:** `cannot stow ... already exists`

**Solution:** The file/directory already exists and isn't a symlink.

```bash
# Option 1: Backup and remove the conflicting file
mv ~/.config/nvim ~/.config/nvim.backup
make stow-nvim

# Option 2: Use --adopt to import existing files into repo
stow --adopt nvim
```

### Broken Symlinks

Clean up broken symlinks:

```bash
make clean
```

### Check What's Stowed

```bash
make status  # Shows status of all packages
```

### Unstow Everything

```bash
make unstow  # Removes all stowed symlinks
```

### Verify Symlinks

```bash
ls -la ~/.config/nvim  # Should show symlink arrow (→)
```

## Theming

This repository uses **[Catppuccin Mocha](https://github.com/catppuccin/catppuccin)** as the unified color scheme across all tools. A consistent theme creates a cohesive development environment and reduces visual context switching.

For detailed theming guidelines, implementation approaches, and the full color palette, see **[THEMING.md](THEMING.md)**.

## Best Practices

1. **Always test first:** Run `make test` before `make stow`
2. **Commit often:** Keep configs version controlled
3. **Use branches:** Test major changes in a branch first
4. **Document changes:** Write clear commit messages using the format: `[tool] type: description`
   - Examples: `[nvim] feature: add LSP config`, `[zsh] fix: correct history settings`, `[tmux] refactor: reorganize keybindings`
   - Types: `feature`, `fix`, `refactor`, `docs`, `style`, `chore`
     - see [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) & [Angular Commit Guidelines](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#type)
5. **Backup first:** Before major changes, create a backup
6. **Selective stow:** On servers, only stow what you need

## Security Notes

- **GPG Signing:** Git commits are GPG-signed (key: `ADE6DE4A9C0FF8A5`)
- **Pre-commit Hooks:** Gitleaks scans for secrets before commits
- **No Secrets:** Never commit API keys, tokens, or passwords
- **Public Repo:** This repo is public - no private data

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for notes on adding new dotfiles, repository structure, and design rationale (FAQ).

## Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Stow Default Ignore List](https://github.com/aspiers/stow/blob/master/default-ignore-list)
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
- [Dotfiles Guide](https://dotfiles.github.io/)
- [Catppuccin Theme](https://github.com/catppuccin)

## License

MIT — see [LICENSE](LICENSE). This is my personal configuration; feel free to use, modify, or learn from it.

## Acknowledgments

Inspired by the dotfiles community and various configurations across GitHub.

---

**Note:** This setup is optimized for macOS. Some configurations may need adjustments for Linux or other systems.
