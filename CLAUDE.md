# Claude Code Reference Guide

This document provides context for AI assistants (particularly Claude) working with this dotfiles repository.

## Repository Overview

**Purpose:** Personal dotfiles for macOS managed with GNU Stow
**Owner:** Saif Azmi
**Location:** `~/dotfiles/` (visible, not hidden)
**VCS:** Git with GPG signing enabled
**Package Manager:** GNU Stow for symlink management
**Target:** macOS with Apple Silicon

## MCP Integrations

- When using Linear MCP tools, always call `list_projects` first to get the correct project/team IDs before creating or updating issues
- If an MCP auth error occurs, retry the connection once before reporting failure — OAuth tokens may need refresh

## Core Philosophy

1. **XDG Compliance** - All configs follow XDG Base Directory spec
2. **Modular Packages** - Each tool isolated in its own stow package
3. **Folding Markers** - Consistent `{{{` `}}}` structure across all configs
4. **Catppuccin Mocha** - Unified theme across all tools
5. **Security First** - GPG signing, gitleaks pre-commit hooks, no secrets

## Directory Structure

### Stow Packages (11 total)

```
bat/      - Cat replacement with syntax highlighting
btop/     - System resource monitor
git/      - Version control (XDG: .config/git/)
htop/     - Interactive process viewer
iterm2/   - Terminal emulator profiles
lazygit/  - Terminal UI for git
nvim/     - Primary editor with extensive Lua config
tmux/     - Terminal multiplexer
vim/      - Fallback editor
yazi/     - Terminal file manager
zsh/      - Shell configuration
```

**All packages are XDG-compliant** - configs live in `.config/` subdirectories except where tool traditions differ (e.g., zsh rc files at root).

### Repository Root Files

```
.editorconfig              # Editor formatting rules
.gitignore                 # Git ignore patterns (macOS-specific)
.pre-commit-config.yaml    # Gitleaks secret scanning
.stowrc                    # Stow configuration (target, verbosity, ignore patterns)
Brewfile                   # Homebrew packages for bootstrap (essential, always installed)
Brewfile.hardware          # Peripheral-bound apps/drivers (opt-in prompt)
Brewfile.mas               # Mac App Store apps via mas (opt-in prompt)
Brewfile.optional          # Nice-to-have apps (opt-in prompt)
CLAUDE.md                  # This file - AI assistant context
CONTRIBUTING.md            # Maintainer notes: adding dotfiles, repo structure, FAQ
install.sh                 # Bootstrap script for new machines
Makefile                   # Dotfiles management commands
README.md                  # User-facing documentation
```

### Excluded from Stow

- `_old_dots_/` - Legacy configs (ignored via .stowrc)
- `ghostty/` - Experimental, not yet in PACKAGES or Brewfile
- `Icon` - macOS custom icon file (keeping for now)
- `.git/` - Git repository (built-in stow ignore)

## Key Conventions

### Folding Markers

All major config files use folding markers for organization:

**Zsh (.zshrc):**
```bash
# SECTION_NAME {{{
  # config here
#}}}
```

**Tmux (.config/tmux/tmux.conf):**
```bash
# SECTION_NAME {{{
  # config here
#}}}
```

**Vim (.config/vim/vimrc):**
```vim
" SECTION_NAME {{{
    " config here
" }}}
```

**Benefits:**
- Enables code folding in editors (`:set foldmethod=marker` in vim)
- Clear visual separation of sections
- Consistent across all configs

### .zshrc Organization

**Current sections (in order):**
1. ZINIT_SETUP - Plugin manager initialization
2. ZSH_PLUGINS - Core plugins (syntax-highlighting, completions, autosuggestions, fzf-tab)
3. OMZ_SNIPPETS - Oh-My-Zsh plugin snippets (gitignore, uv)
4. COMPLETION_INIT - Completion system initialization
5. KEYBINDINGS - Key mappings
6. HISTORY - History settings (well-commented)
7. COMPLETION_STYLING - Completion appearance
8. ALIASES - Command aliases
9. SHELL_INTEGRATIONS - fzf, zoxide
10. EDITOR - Editor preferences
11. TOOL_CONFIGURATIONS - GPG, thefuck, ngrok
12. LANGUAGE_MANAGERS - Ruby, JavaScript/Node.js, Java (with nested folds)
13. PROMPT - Oh-My-Posh

**Nested folding example (LANGUAGE_MANAGERS):**
```bash
# LANGUAGE_MANAGERS {{{
  ## Ruby {{{
    eval "$(rbenv init - zsh)"
  #}}}

  ## Javascript/Node.js {{{
    # nvm, pnpm, bun configs
  #}}}
#}}}
```

## Stow Configuration

### .stowrc

```bash
--target=$HOME              # Where symlinks are created
--verbose=1                 # Show operations
--ignore='PATTERN'          # Ignore patterns (6 total)
```

**Ignore patterns (minimal, only what's needed):**
- `\.DS_Store` - macOS metadata
- `\.swp$`, `\.swo$` - Vim swap files
- `\.bak$`, `\.tmp$` - Backup/temp files
- `\.orig$`, `\.rej$` - Patch artifacts

**Why minimal?** Stow has extensive built-in ignores (see [default-ignore-list](https://github.com/aspiers/stow/blob/master/default-ignore-list)) covering VCS, editors, docs.

### Important Notes

1. **Package-level ignore files don't work** - `.stow-local-ignore` must be in each package dir, not repo root. We use `.stowrc` for global patterns instead.
2. **Stow pattern behavior:**
   - `pattern` = matches anywhere
   - `^/pattern` = matches only at package root
3. **XDG vars set in .zshenv** - All 4 XDG variables properly configured

## Git Configuration

### GPG Signing

- **Enabled:** All commits GPG-signed
- **Key:** ADE6DE4A9C0FF8A5
- **User:** Saif Azmi <saifazmi.dev@gmail.com>

### Security

- **Pre-commit hook:** Gitleaks scans for secrets
- **Git history:** Cleaned with git-filter-repo (removed old API leak)
- **Important:** NEVER commit secrets, API keys, tokens

## Makefile Commands

**Main operations:**
```bash
make install   # Bootstrap a new machine (Xcode CLT + Homebrew + packages + stow)
make help      # Show all available commands
make test      # Dry run - preview changes
make stow      # Stow all packages
make restow    # Re-stow (useful after config changes)
make unstow    # Remove all symlinks
make status    # Check what's stowed
make clean     # Remove broken symlinks
make adopt     # Import existing $HOME files into packages (check git diff after)
```

**Individual packages:**
```bash
make stow-PACKAGE      # e.g., make stow-nvim
make restow-PACKAGE
make unstow-PACKAGE
make test-PACKAGE
make adopt-PACKAGE
```

## Tools Categorization

### Stow Packages (Have Config Files)

**Main Tools:**
- zsh, tmux, neovim, vim, git

**Utilities:**
- bat, yazi, lazygit, btop, htop

### Zsh-Integrated (No Dedicated Packages)

**Shell Integrations:**
- Zinit - Plugin manager
- Oh My Posh - Prompt theme (has config file: `zsh/.config/ohmyposh/config.toml`)
- fzf - Fuzzy finder (`eval "$(fzf --zsh)"`)
- zoxide - Smart cd (`eval "$(zoxide init --cmd cd zsh)"`)
- thefuck - Command correction (`eval $(thefuck --alias)`)

**Zsh Plugins (via Zinit):**
- fzf-tab - Replace default completion with fzf
- zsh-syntax-highlighting - Fish-like syntax highlighting
- zsh-completions - Additional completion definitions
- zsh-autosuggestions - Fish-like autosuggestions

**Language & Package Managers:**
- uv - Python version manager (`zinit snippet OMZP::uv`)
- nvm - Node version manager (sourced from Homebrew)
- bun - JavaScript runtime (sourced + PATH)
- pnpm - Node package manager (PATH setup)
- rbenv - Ruby version manager (`eval "$(rbenv init - zsh)"`)

**Dev Tools:**
- ngrok - Secure tunnels (`eval "$(ngrok completion)"`)

## Completion Management Strategy

### Current Approach (Established but Not Fully Implemented)

**Strategy:** Zinit-first for consistency and performance

1. **OMZ Snippets** - When OMZ has good completion
   ```bash
   zinit snippet OMZP::toolname
   ```

2. **Tool eval** - When tool provides `completion zsh` or `init zsh`
   ```bash
   eval "$(tool completion zsh)"
   # Or with zinit turbo mode (for performance):
   zinit ice lucid wait'0a' atload'eval "$(tool completion zsh)"'
   zinit light zdharma-continuum/null
   ```

3. **Remote snippet** - Tool has completion file on GitHub
   ```bash
   zinit ice lucid wait as'completion'
   zinit snippet https://url/to/_completion
   ```

4. **Custom completions** - Directory exists but not yet integrated
   - Location: `zsh/.zsh/completions/`
   - Files must start with `_` (e.g., `_kubectl`)
   - README.md documents the system
   - Example file provided: `_example`
   - **TODO:** Add to fpath in .zshrc when needed

### Note on Completions

The completion system was discussed but **not yet refactored**. Current state is functional but uses mixed approaches (direct eval, OMZ snippets, etc.). Plan exists to consolidate but is deferred.

## XDG Variables

Set in `.zshenv`:
```bash
XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"
XDG_DATA_HOME="$HOME/.local/share"
XDG_STATE_HOME="$HOME/.local/state"
```

**Used by:**
- Zinit (`ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"`)
- Oh-My-Posh config
- All tools in stow packages

## Common Operations

### Adding a New Dotfile Package

1. Create package directory with XDG structure:
   ```bash
   mkdir -p toolname/.config/toolname
   ```

2. Move config files:
   ```bash
   mv ~/.config/toolname/config toolname/.config/toolname/config
   ```

3. Update Makefile (add to PACKAGES variable)

4. Test and stow:
   ```bash
   make test-toolname
   make stow-toolname
   ```

5. Commit:
   ```bash
   git add toolname/
   git commit -m "[toolname] add configuration"
   ```

### Modifying Existing Configs

Since dotfiles are symlinked:
1. Edit file directly (changes reflect immediately via symlink)
2. Commit changes:
   ```bash
   git add <changed-file>
   git commit -m "[tool] description of change"
   ```

## Projects

### Dotfiles

- Uses GNU Stow and Makefiles — always check existing Makefile targets before adding new ones (`make help`)
- Test stow commands with `--simulate` (or `stow -nv`) before applying
- iterm2 is an exception to XDG compliance — see iTerm2 Package Notes section

## Troubleshooting

### Stow Conflicts

**Error:** "cannot stow ... already exists"

**Cause:** File/directory exists and isn't a symlink

**Solution:**
```bash
# Backup and remove
mv ~/.config/tool ~/.config/tool.backup
make stow-tool

# Or adopt existing files into repo
stow --adopt tool
```

### macOS Case Sensitivity Issues

- macOS filesystem is case-insensitive but case-preserving
- Git tracks both `File` and `file` as separate
- Can cause issues during rebases/history rewrites
- Solution: Avoid case-only renames

### Broken Symlinks

```bash
make clean  # Removes broken symlinks from ~ and ~/.config
```

## Important File Locations

### Current Machine
```
~/.config/git/      → ~/dotfiles/git/.config/git/
~/.config/nvim/     → ~/dotfiles/nvim/.config/nvim/
~/.config/tmux/     → ~/dotfiles/tmux/.config/tmux/
~/.zshrc            → ~/dotfiles/zsh/.zshrc
# etc...
```

### Repository
```
~/dotfiles/
├── Makefile                    # Main interface for stow operations
├── .stowrc                     # Stow behavior configuration
├── README.md                   # User documentation
├── CLAUDE.md                   # This file
└── {tool}/                     # Individual tool packages
    └── .config/{tool}/         # XDG-compliant structure
```

## Commit Message Convention

Format: `[tool] type: description`

**Examples:**
```
[nvim] feature: add new plugin for LSP
[zsh] refactor: reorganize completion section
[tmux] fix: correct keybinding for pane resize
[dotfiles] docs: update README with new tools
[git] feature: enable GPG signing
```

**Types:** feature, fix, refactor, style, docs, chore

## What NOT to Do

1. ❌ Don't commit secrets, API keys, tokens
2. ❌ Don't rename `dotfiles/` to `.dotfiles/` (decision: keep visible)
3. ❌ Don't add files to package roots (they'll get stowed to ~/)
4. ❌ Don't use `git commit --amend` on pushed commits
5. ❌ Don't force push to main without good reason
6. ❌ Don't skip pre-commit hooks (they catch secrets)
7. ❌ Don't create `.stow-local-ignore` in repo root (doesn't work)
8. ❌ Don't break XDG compliance (keep configs in .config/)

## Theming Strategy

All tools use **Catppuccin Mocha** theme. Decision tree for adding themes to new tools:

### 1. Built-in / Package Manager
Check if the tool has built-in Catppuccin support or if it's available via package manager (Homebrew, etc.). This is the easiest approach.

### 2. Catppuccin Organization Repos
Search [github.com/catppuccin](https://github.com/catppuccin) for maintained theme files. Download and place in appropriate config location.

### 3. Create Custom Theme
If no theme exists, create one manually using the Catppuccin Mocha color palette:
- Base: `#1e1e2e`, Surface: `#313244`, Text: `#cdd6f4`
- See README Theming section for full color reference

### Yazi-Specific Notes

**Version:** v0.3.3 (v25.12.29) - Released 2025-12-29
**Theme file:** `yazi/.config/yazi/theme.toml`
**Syntax theme:** `yazi/.config/yazi/Catppuccin-mocha.tmTheme` (from [catppuccin/bat](https://github.com/catppuccin/bat))

## Pre-Commit Hooks

### Setup on New Machine

```bash
# Install pre-commit
brew install pre-commit

# Install hooks (from repo root)
pre-commit install

# Verify
pre-commit run --all-files
```

### Configuration

Located in `.pre-commit-config.yaml`:
- **Gitleaks** - Scans for secrets before each commit
- Runs automatically on `git commit`
- Can be bypassed with `--no-verify` (not recommended)

## Future Considerations

### Potential Additions

1. **Completion refactor** - Consolidate to zinit-first approach with turbo mode
2. **Custom completions** - Integrate `zsh/.zsh/completions/` into fpath
3. **cat → bat alias** - Discussed but deferred (use `bat --style=plain --paging=never`)

## Quick Reference

**Test before stow:**
```bash
make test
```

**Stow everything:**
```bash
make stow
```

**Check status:**
```bash
make status
```

**Edit configs:**
```bash
nvim ~/.zshrc     # Symlink, changes go to repo
```

**Commit changes:**
```bash
git add .
git commit -m "[tool] description"
git push
```

**On new machine:**
```bash
git clone git@github.com:saifazmi/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install   # handles Xcode CLT, Homebrew, brew bundle (NOT stow — run make test then make stow separately)
```

## Makefile / Shell Notes

- Use `printf` instead of `echo -n` in Makefile shell loops — `echo -n` prints literal `-n` in macOS `/bin/sh`
- `stow -nv pkg` outputs `LINK: ...` lines for pending operations; no `LINK:` output = package is fully stowed
- `stow --adopt` moves existing `$HOME` files into the package dir (overwrites pkg files silently) — always check `git diff` after running
- `ghostty` is experimental — excluded from PACKAGES and Brewfile; `iterm2` is the active terminal cask
- `zinit` is not in Brewfile — it self-bootstraps via `.zshrc` on first shell launch (no manual install needed)

## Linear Notes

- When writing Linear comments or descriptions with newlines, use actual newlines in the string — do not use `\n` escape sequences, they render as literal `\n` text in the ticket
- Dotfiles project slug: `dotfiles-stow-v1`
- Update issue descriptions with work done
- Move ticket status as work progresses: In Progress when starting, Done when complete and verified (policy set 2026-09-18)
- Use `mcp__claude_ai_Linear__save_issue` with `id` field to update existing tickets

## iTerm2 Package Notes

- Not XDG-compliant — stow path mirrors `~/Library/Application Support/iTerm2/DynamicProfiles/`
- DynamicProfiles JSON must have `{ "Profiles": [...] }` at root (not a bare profile object)
- iTerm2 auto-reloads DynamicProfiles directory live — no restart needed after stow

## install.sh Scope

- Intentionally stops before stow: Xcode CLT → Homebrew → `brew bundle` only
- Essentials (`Brewfile`) install unconditionally, then three opt-in `y/N` prompts in order: `Brewfile.hardware`, `Brewfile.optional`, `Brewfile.mas`
- `DOTFILES_NONINTERACTIVE=1` skips every prompt and takes the default (essentials only) — used by CI and the VM harness
- `DOTFILES` env var overrides the checkout location (default `$HOME/dotfiles`)
- Users run `make test` then `make stow` manually — preserves dry-run workflow
- Do NOT add stow back to install.sh

## Commit Policy

- Never commit without explicit user approval — user always reviews diffs first

