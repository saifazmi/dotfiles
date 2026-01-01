# Dotfiles

Personal configuration files for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's Inside

This repository contains configuration files for the following tools:

- **[Neovim](https://neovim.io/)** - Modern Vim-based text editor with extensive plugin setup
- **[Zsh](https://www.zsh.org/)** - Shell configuration with Zinit, Oh My Posh, and integrations (fzf, zoxide, nvm)
- **[Tmux](https://github.com/tmux/tmux)** - Terminal multiplexer with plugins and Catppuccin theme
- **[Git](https://git-scm.com/)** - Version control with GPG signing enabled
- **[Yazi](https://github.com/sxyazi/yazi)** - Terminal file manager
- **[Lazygit](https://github.com/jesseduffield/lazygit)** - Terminal UI for git
- **[Bat](https://github.com/sharkdp/bat)** - Cat clone with syntax highlighting
- **[Btop](https://github.com/aristocratos/btop)** - System resource monitor
- **[Vim](https://www.vim.org/)** - Classic text editor configuration
- **[Htop](https://htop.dev/)** - Interactive process viewer

## Features

- 🎨 **Consistent theming** - Catppuccin Mocha across all tools
- 📦 **Modular structure** - Each tool isolated in its own package
- 🔗 **GNU Stow** - Symlink management for clean, version-controlled configs
- 🛠️ **Makefile** - Simple commands for managing all dotfiles
- 🔐 **Security** - GPG commit signing, gitleaks pre-commit hooks
- 🍎 **macOS optimized** - Tested on macOS with Apple Silicon

## Prerequisites

- **macOS** (tested on macOS Sonnet with Apple Silicon)
- **Homebrew** - [Install here](https://brew.sh/)
- **GNU Stow** - `brew install stow`
- **Git** - `brew install git`

## Quick Start

```bash
# Clone the repository
git clone git@github.com:saifazmi/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Preview what will be stowed (dry run)
make test

# Install all dotfiles
make stow

# Or install specific packages
make stow-nvim
make stow-zsh
```

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

## Usage

The included `Makefile` provides convenient commands for managing dotfiles:

### Main Operations

```bash
make help      # Show all available commands
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
make test-PACKAGE      # Test a specific package
```

**Examples:**
```bash
make stow-nvim         # Stow Neovim config
make restow-zsh        # Restow Zsh config (after editing)
make unstow-tmux       # Remove Tmux symlinks
make test-git          # Preview Git config stow
```

### Utilities

```bash
make status      # Show status of all packages
make clean       # Remove broken symlinks from home directory
```

### Git Operations

```bash
make git-status  # Show git status
make git-add     # Stage stow config files (.stowrc, Makefile)
make git-commit  # Commit stow configuration changes
```

## Repository Structure

```
dotfiles/
├── .stowrc                    # Stow configuration
├── .gitignore                 # Git ignore patterns
├── .pre-commit-config.yaml    # Pre-commit hooks (gitleaks)
├── Makefile                   # Dotfiles management commands
├── README.md                  # This file
│
├── bat/                       # Bat configuration
│   └── .config/bat/config
│
├── btop/                      # Btop configuration
│   └── .config/btop/
│
├── git/                       # Git configuration
│   ├── .gitconfig
│   └── .gitignore_global
│
├── htop/                      # Htop configuration
│   └── .config/htop/
│
├── lazygit/                   # Lazygit configuration
│   └── .config/lazygit/config.yml
│
├── nvim/                      # Neovim configuration
│   └── .config/nvim/
│       ├── init.lua
│       └── lua/sizm/
│
├── tmux/                      # Tmux configuration
│   └── .config/tmux/
│       ├── tmux.conf
│       └── tmux.catppuccin.conf
│
├── vim/                       # Vim configuration
│   └── .config/vim/vimrc
│
├── yazi/                      # Yazi configuration
│   └── .config/yazi/
│
└── zsh/                       # Zsh configuration
    ├── .zshrc
    ├── .zshenv
    ├── .zprofile
    └── .config/ohmyposh/config.toml
```

### How GNU Stow Works

Each directory (e.g., `nvim/`, `zsh/`) is a **stow package**. When you run `stow nvim`, it creates symlinks in your home directory that point back to files in this repository.

**Example:**
```bash
# Before stow
~/dotfiles/nvim/.config/nvim/init.lua  # File in repo

# After running: stow nvim
~/.config/nvim/init.lua → ~/dotfiles/nvim/.config/nvim/init.lua  # Symlink created
```

This means:
- ✅ All configs are version controlled in one place
- ✅ Changes in `~/dotfiles/` automatically reflect in `~/`
- ✅ Easy to deploy to new machines
- ✅ Can selectively install configs (e.g., skip GUI tools on servers)

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

## Updating Dotfiles

### On the Current Machine

After editing any config file:

```bash
# Option 1: Changes are live (symlinks point to repo)
# Just commit and push
git add .
git commit -m "[nvim] update plugin configuration"
git push

# Option 2: If you need to restow (e.g., added new files)
make restow-nvim
git add .
git commit -m "[nvim] add new plugin"
git push
```

### On Other Machines

```bash
cd ~/dotfiles
git pull
make restow  # Re-stow all packages
```

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

## How `.stowrc` Works

The `.stowrc` file contains global configuration for stow:

- **Target:** Where symlinks are created (`$HOME`)
- **Verbosity:** Shows what stow is doing
- **Ignore patterns:** Files to skip (`.DS_Store`, `.swp`, `.bak`, etc.)

Stow also has [built-in ignore patterns](https://github.com/aspiers/stow/blob/master/default-ignore-list) for common files like `.git`, `README`, `LICENSE`, etc.

## Migrating to a New Machine

```bash
# 1. Install prerequisites
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install stow git

# 2. Clone dotfiles
git clone git@github.com:saifazmi/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. Preview what will be installed
make test

# 4. Install all configs
make stow

# Or selectively install (e.g., server without GUI tools)
make stow-git stow-zsh stow-tmux

# 5. Install tools
brew install neovim tmux zsh yazi lazygit bat btop
```

## Best Practices

1. **Always test first:** Run `make test` before `make stow`
2. **Commit often:** Keep configs version controlled
3. **Use branches:** Test major changes in a branch first
4. **Document changes:** Write clear commit messages
5. **Backup first:** Before major changes, create a backup
6. **Selective stow:** On servers, only stow what you need

## Security Notes

- **GPG Signing:** Git commits are GPG-signed (key: `ADE6DE4A9C0FF8A5`)
- **Pre-commit Hooks:** Gitleaks scans for secrets before commits
- **No Secrets:** Never commit API keys, tokens, or passwords
- **Public Repo:** This repo is public - no private data

## Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Stow Default Ignore List](https://github.com/aspiers/stow/blob/master/default-ignore-list)
- [Dotfiles Guide](https://dotfiles.github.io/)
- [Catppuccin Theme](https://github.com/catppuccin)

## License

This is my personal configuration. Feel free to use, modify, or learn from it.

## Acknowledgments

Inspired by the dotfiles community and various configurations across GitHub.

---

**Note:** This setup is optimized for macOS. Some configurations may need adjustments for Linux or other systems.
