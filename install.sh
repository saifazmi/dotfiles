#!/bin/bash
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

# Set DOTFILES_NONINTERACTIVE=1 to skip prompts and take each [y/N] default
# (i.e. essentials only). Used by CI and the VM harness.
ask() {
  if [[ "${DOTFILES_NONINTERACTIVE:-}" == "1" ]]; then
    reply=n
    return
  fi
  read -rp "$1" reply
}

# ── Xcode Command Line Tools ─────────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  until xcode-select -p &>/dev/null; do sleep 5; done
  echo "✓ Xcode CLT installed"
else
  echo "✓ Xcode CLT already installed"
fi

# ── Homebrew ─────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "✓ Homebrew installed"
else
  echo "✓ Homebrew already installed"
fi

# ── Packages via Brewfile ────────────────────────────────────────────────────
echo "Installing essential packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"
echo "✓ Essential packages installed"

# ── Hardware & drivers (optional) ────────────────────────────────────────────
ask "Install hardware-specific apps and drivers (DisplayLink, Stream Deck, Logitech)? [y/N] "
if [[ "$reply" =~ ^[Yy]$ ]]; then
  echo "Installing hardware apps from Brewfile.hardware..."
  brew bundle --file="$DOTFILES/Brewfile.hardware"
  echo "✓ Hardware apps installed"
else
  echo "Skipped hardware apps. Run 'brew bundle --file=Brewfile.hardware' later if you change your mind."
fi

# ── Nice-to-have apps (optional) ─────────────────────────────────────────────
ask "Install nice-to-have apps too? [y/N] "
if [[ "$reply" =~ ^[Yy]$ ]]; then
  echo "Installing nice-to-have apps from Brewfile.optional..."
  brew bundle --file="$DOTFILES/Brewfile.optional"
  echo "✓ Nice-to-have apps installed"
else
  echo "Skipped nice-to-have apps. Run 'brew bundle --file=Brewfile.optional' later if you change your mind."
fi

# ── Mac App Store apps (optional) ────────────────────────────────────────────
ask "Install Mac App Store apps too? Requires being signed into the App Store already. [y/N] "
if [[ "$reply" =~ ^[Yy]$ ]]; then
  echo "Installing App Store apps from Brewfile.mas..."
  brew bundle --file="$DOTFILES/Brewfile.mas"
  echo "✓ App Store apps installed"
else
  echo "Skipped App Store apps. Run 'brew bundle --file=Brewfile.mas' later if you change your mind."
fi

echo ""
echo "✓ Setup complete. Run 'make test' to preview dotfile symlinks, then 'make stow' to apply."
