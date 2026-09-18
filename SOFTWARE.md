# Software Setup

`Brewfile` covers formulae and casks — `make install` handles it unconditionally.

Two more Homebrew files are **opt-in** — `install.sh` asks `y/N` for each, and
`DOTFILES_NONINTERACTIVE=1` skips them all:

- `Brewfile.hardware` — peripheral-bound apps and drivers (DisplayLink, Stream
  Deck, Logitech). Only useful on a machine with that hardware attached.
- `Brewfile.optional` — nice-to-have apps.

Run either manually any time with `brew bundle --file=<file>`.

Mac App Store apps live in a separate `Brewfile.mas` and are **opt-in**:
`install.sh` asks `y/N` before running `brew bundle --file=Brewfile.mas`. Sign
into the App Store first, or those entries silently fail. Run it manually any
time with:

```bash
brew bundle --file=Brewfile.mas
```

## App Store apps installed here but not scripted

These are on this machine but were left out of `Brewfile.mas` on purpose —
install manually from the App Store if a fresh machine needs them:

- Compressor
- Dark Noise
- Developer
- Elmedia Video Player
- Final Cut Pro
- Flighty
- Goodnotes
- HP Smart
- Keynote
- Kindle
- Motion
- Notability
- Numbers
- Pages
- Pixelmator Pro
- Portal

## App Store apps that can't be scripted at all

Audible and Readwise are iOS/iPadOS apps running on Mac via Apple's App Store
compatibility layer — `mas` only manages native Mac App Store apps, so these
have to be installed by hand:

- Audible
- Readwise

## Installed via native installer (not Homebrew)

- **[bun](https://bun.sh/)** — installed via its official install script, not Homebrew:
  ```bash
  curl -fsSL https://bun.sh/install | bash
  ```
