# Custom Zsh Completions

This directory contains custom completion files for tools that don't provide their own.

## File Naming Convention

Completion files must start with an underscore: `_toolname`

Examples:
- `_kubectl`
- `_docker`
- `_mycustomtool`

## How to Add a Completion

### Option 1: Generate from Tool

```bash
# If tool supports generating completions
tool completion zsh > ~/.zsh/completions/_tool
```

### Option 2: Download from Source

```bash
# Download completion file from GitHub or elsewhere
curl -o ~/.zsh/completions/_tool https://raw.githubusercontent.com/user/repo/main/_tool
```

### Option 3: Write Custom

Create a file `_toolname` with zsh completion syntax. See existing files for examples.

## Automatic Loading

Files in this directory are automatically loaded because `~/.zsh/completions` is added to `fpath` in `.zshrc`.

No additional configuration needed in `.zshrc` - just add the file here!

## Stow Behavior

This directory is part of the `zsh` stow package and will be symlinked to `~/.zsh/completions` when stowed.
