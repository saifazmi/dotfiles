# Tmux Configuration

Terminal multiplexer configuration using [TPM](https://github.com/tmux-plugins/tpm) for plugin management with Catppuccin Mocha theming.

## Plugins

| Plugin | Description |
| ------ | ----------- |
| [catppuccin/tmux](https://github.com/catppuccin/tmux) | Catppuccin Mocha theme for status bar |
| [tmux-battery](https://github.com/tmux-plugins/tmux-battery) | Battery status (dependency for catppuccin/tmux) |
| [tmux-online-status](https://github.com/tmux-plugins/tmux-online-status) | Online/offline indicator |
| [tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url) | Search and open URLs from tmux using fzf |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless pane navigation with Ctrl-hjkl (shared with Neovim) |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Persist sessions across restarts |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save sessions every 15 minutes |

## Key Bindings

| Key | Action |
| --- | ------ |
| `Ctrl-a` | Prefix (remapped from `Ctrl-b`) |
| `\|` | Split pane horizontally |
| `-` | Split pane vertically |
| `r` | Reload config |
| `v` | Begin selection (copy mode) |
| `y` | Copy selection (copy mode) |
| `Ctrl-hjkl` | Navigate panes / Neovim splits |
| `K` | Clean TPM plugins |

## Files

```txt
tmux/
└── .config/
    └── tmux/
        ├── tmux.conf              # Main config (keybindings, options, plugins)
        └── tmux.catppuccin.conf   # Catppuccin theme + status bar layout
```
