# Zsh Configuration

Shell configuration managed via [Zinit](https://github.com/zdharma-continuum/zinit) with Oh My Posh prompt theming.

## Plugins

| Plugin | Description |
| ------ | ----------- |
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | Replace Zsh's default completion with fzf |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Fish-like syntax highlighting for Zsh |
| [zsh-completions](https://github.com/zsh-users/zsh-completions) | Additional completion definitions |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-like autosuggestions |

## Shell Integrations

| Tool | Description |
| ---- | ----------- |
| [zinit](https://github.com/zdharma-continuum/zinit) | Fast and flexible Zsh plugin manager |
| [oh my posh](https://ohmyposh.dev/) | Prompt theming engine (custom Catppuccin Mocha theme) |
| [fzf](https://junegunn.github.io/fzf/) | Command-line fuzzy finder |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart directory jumper (smarter `cd`) |
| [thefuck](https://github.com/nvbn/thefuck) | Corrects errors in previous console commands |

## Language & Package Managers

| Tool | Description |
| ---- | ----------- |
| [uv](https://docs.astral.sh/uv) | Ultra-fast Python version manager |
| [nvm](https://github.com/nvm-sh/nvm) | Node version manager |
| [bun](https://bun.sh/) | Fast JavaScript runtime and all-in-one toolkit |
| [pnpm](https://pnpm.io/) | Fast, disk space efficient package manager for Node.js |
| [rbenv](https://github.com/rbenv/rbenv#readme) | Ruby version manager |

## Files

```txt
zsh/
├── .zshenv          # XDG vars, exported early
├── .zprofile        # Login shell setup (PATH, Homebrew)
├── .zshrc           # Main config (plugins, aliases, integrations)
└── .config/
    └── ohmyposh/
        └── config.toml   # Prompt theme (Catppuccin Mocha)
```

## .zshrc Structure

Sections use folding markers (`{{{`/`}}}`) for editor folding:

1. `ZINIT_SETUP` - Plugin manager init
2. `ZSH_PLUGINS` - Core plugins
3. `OMZ_SNIPPETS` - Oh-My-Zsh snippets
4. `COMPLETION_INIT` - Completion system
5. `KEYBINDINGS` - Key mappings
6. `HISTORY` - History settings
7. `COMPLETION_STYLING` - Completion appearance
8. `ALIASES` - Command aliases
9. `SHELL_INTEGRATIONS` - fzf, zoxide
10. `EDITOR` - Editor preferences
11. `TOOL_CONFIGURATIONS` - GPG, thefuck, ngrok
12. `LANGUAGE_MANAGERS` - Ruby, Node.js, Java
13. `PROMPT` - Oh My Posh
