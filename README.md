# Dotfiles

Personal configuration files managed with GNU Stow.

## Prerequisites

GNU Stow must be installed:

```bash
# Ubuntu/Debian
sudo apt install stow

# macOS
brew install stow

# Arch Linux
sudo pacman -S stow
```

## Quick Start

```bash
# Install all packages
make install

# Install specific packages
make install PKGS='nvim tmux zsh'

# View available packages
make list

# Check installation status
make status
```

## Repository Structure

Each subdirectory is a "package" that can be selectively installed:

```
dotfiles/
├── alacritty/     # Alacritty terminal config
├── nvim/          # Neovim configuration
├── opencode/      # OpenCode agent configs
├── tmux/          # Tmux configuration
├── zsh/           # Zsh shell config
└── Makefile       # Installation automation
```

## Usage

### List Available Packages
```bash
make list
```

### Install Packages

Install all packages:
```bash
make install
```

Install specific packages:
```bash
make install PKGS='nvim tmux'
```

If conflicts are detected (existing files at target locations), you'll be prompted to replace them:
```
Conflicts detected for package 'nvim':
  * existing target is not owned by stow: .config/nvim/init.lua

Replace all conflicting files? [y/N]:
```

### Uninstall Packages

Uninstall all packages:
```bash
make uninstall
```

Uninstall specific packages:
```bash
make uninstall PKGS='tmux'
```

### Update Packages

After adding or removing files in a package directory, re-stow to update symlinks:

```bash
# Update all packages
make update

# Update specific packages
make update PKGS='nvim'
```

### Check Status

See which packages are currently installed:
```bash
make status
```

Output example:
```
Package Status:
  [x] alacritty (installed)
  [x] nvim (installed)
  [ ] opencode (not installed)
  [x] tmux (installed)
  [x] zsh (installed)
```

## How It Works

GNU Stow creates symlinks from your home directory to files in this repository. For example:

```
~/alacritty.toml -> dotfiles/alacritty/.alacritty.toml
~/.config/nvim/ -> dotfiles/nvim/.config/nvim/
```

Changes made to files in the repository are immediately reflected in your home directory through the symlinks.

## Notes

- The Makefile automatically discovers packages (any subdirectory except hidden ones)
- Packages preserve directory structure from `$HOME` (e.g., `nvim/.config/nvim/` → `~/.config/nvim/`)
- Conflict detection prevents accidental overwrites
- Status checking works with both relative and absolute symlinks

