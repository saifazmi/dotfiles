# Theming Guide

This dotfiles repository uses **[Catppuccin Mocha](https://github.com/catppuccin/catppuccin)** as a unified color scheme across all tools for visual consistency.

## Philosophy

A consistent theme creates a cohesive development environment and reduces visual context switching. Catppuccin Mocha offers:

- Warm, pastel colors that are easy on the eyes
- Wide tool support across the ecosystem
- Active community and regular updates

## Theme Implementation Approaches

When adding Catppuccin theming to a tool, follow this decision tree:

### Decision Flowchart

```txt
Need to theme a tool?
│
├─ Does the tool have built-in Catppuccin support or plugin?
│  └─ YES → Use Option 1 (Built-in/Package Manager)
│
├─ Does catppuccin/<tool> repo exist on GitHub?
│  └─ YES → Use Option 2 (Download from Catppuccin Org)
│
└─ Neither exists?
   └─ Use Option 3 (Create Custom Theme)
      └─ Consider contributing it back to Catppuccin org!
```

### Option 1: Built-in/Package Manager Theme (Preferred)

**When to use:**

- The tool has native Catppuccin support (built-in theme or official plugin)
- Theme is installable via package manager (e.g., Homebrew, npm, lazy.nvim)
- Configuration is simple (one-line setting)

**Benefits:**

- Automatic updates with tool/package manager
- Officially maintained and tested
- Minimal configuration required
- No manual file management

**Examples from this repo:**

```bash
# Bat - Built-in packaged theme
bat/.config/bat/config:
  --theme="Catppuccin Mocha"

# Neovim - Plugin via lazy.nvim
require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin" }
})
vim.cmd.colorscheme("catppuccin-mocha")

# Tmux - Plugin via TPM (tpm)
# In tmux.conf: set -g @plugin 'catppuccin/tmux'
# In tmux.catppuccin.conf:
set -g @catppuccin_flavor "mocha"

# Vim - Plugin via Vundle
Plugin 'catppuccin/vim'
colorscheme catppuccin_mocha
```

### Option 2: Download from Catppuccin Organization (Common)

**When to use:**

- No built-in support, but Catppuccin org maintains a theme for the tool
- Theme exists at `github.com/catppuccin/<tool-name>`
- Tool requires theme files in specific format/location

**Process:**

1. Search [Catppuccin organization](https://github.com/catppuccin) for your tool
2. Find the official `catppuccin/<tool-name>` repository
3. Follow the repo's installation instructions
4. Download theme file(s) to appropriate directory in your dotfiles
   - most themes should work after this, if not then go to step 5.
5. (if required) Reference the theme in the tool's config file

**Benefits:**

- Community-maintained and updated
- Installation instructions provided
- Tested by many users
- Issues tracked on GitHub

**Examples from this repo:**

```bash
# Btop - Downloaded from catppuccin/btop
1. Visit: https://github.com/catppuccin/btop
2. Download: themes/catppuccin_mocha.theme
3. Place in: btop/.config/btop/themes/catppuccin_mocha.theme
4. Edit btop.conf
  - Config: color_theme = "$HOME/.config/btop/themes/catppuccin_mocha.theme"
```

### Option 3: Create Custom Theme (Last Resort)

**When to use:**

- No built-in support exists
- No official Catppuccin theme repository for the tool
- Need fine-grained control over specific colors
- Tool uses non-standard theme format

**Process:**

1. Check tool's theming documentation
2. Use [Catppuccin palette](https://github.com/catppuccin/catppuccin#-palette) for color values
3. Map Catppuccin's Mocha colors to tool's theme format
4. Test thoroughly with different file types/scenarios

**Challenges:**

- Manual maintenance required
- No automatic updates
- Need to understand tool's theme system
- May break with tool updates

**Examples from this repo:**

```bash
# Lazygit - Custom theme in config.yml
# gui.theme section with Catppuccin Mocha hex values:
gui:
  theme:
    activeBorderColor: ["#fab387", bold]
    inactiveBorderColor: ["#a6adc8"]
    selectedLineBgColor: ["#313244"]
    defaultFgColor: ["#cdd6f4"]
    # ... (full palette in lazygit/.config/lazygit/config.yml)

# Yazi - Custom theme mapping
yazi/.config/yazi/theme.toml
  - Manual Catppuccin Mocha color mapping
  - Fine-tuned for file type colors

# Oh My Posh - Custom config with palette
zsh/.config/ohmyposh/config.toml
  - Custom prompt segments using Catppuccin Mocha hex values
  - Full control over prompt appearance
```

## Catppuccin Mocha Color Reference

The full official Mocha palette:

| Color     | Hex       | Common Usage                    |
| --------- | --------- | -------------------------------- |
| Rosewater | `#f5e0dc` | Cursor, subtle highlights        |
| Flamingo  | `#f2cdcd` | Subtle highlights                |
| Pink      | `#f5c2e7` | Keywords                         |
| Mauve     | `#cba6f7` | Primary accent, active items     |
| Red       | `#f38ba8` | Errors, critical                 |
| Maroon    | `#eba0ac` | Secondary errors, escape codes   |
| Peach     | `#fab387` | Numbers, constants               |
| Yellow    | `#f9e2af` | Warnings                         |
| Green     | `#a6e3a1` | Success, strings                 |
| Teal      | `#94e2d5` | Operators                        |
| Sky       | `#89dceb` | Info, secondary accent           |
| Sapphire  | `#74c7ec` | Secondary info                   |
| Blue      | `#89b4fa` | Links, info                      |
| Lavender  | `#b4befe` | Secondary accent                 |
| Text      | `#cdd6f4` | Primary foreground text          |
| Subtext1  | `#bac2de` | Slightly dimmed text             |
| Subtext0  | `#a6adc8` | Dimmed text                      |
| Overlay2  | `#9399b2` | Comments, borders                |
| Overlay1  | `#7f849c` | Comments, borders                |
| Overlay0  | `#6c7086` | Comments, borders                |
| Surface2  | `#585b70` | UI elements, selections          |
| Surface1  | `#45475a` | UI elements, selections          |
| Surface0  | `#313244` | UI elements, selections          |
| Base      | `#1e1e2e` | Primary background               |
| Mantle    | `#181825` | Secondary background             |
| Crust     | `#11111b` | Tertiary background              |

**Source:** [catppuccin/catppuccin - Palette](https://github.com/catppuccin/catppuccin#-palette)

## Known Limitations

**htop** has no dedicated Catppuccin port, and its color schemes are hardcoded C enums in `CRT.c` — `htoprc`'s `color_scheme` field just selects a built-in scheme (`0`–`6`), with no user-configurable palette to hook into ([htop-dev/htop#1416](https://github.com/htop-dev/htop/issues/1416) is an open upstream request for this). In practice this doesn't matter: htop's default scheme renders through the terminal's ANSI palette, and since this repo's iTerm2 profile is already Catppuccin Mocha, htop inherits the theme for free — no per-tool config needed.

## Resources

- [Catppuccin GitHub Organization](https://github.com/catppuccin)
- [Catppuccin Color Palette](https://github.com/catppuccin/catppuccin#-palette)
- [Catppuccin Port Creation Guide](https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md)
