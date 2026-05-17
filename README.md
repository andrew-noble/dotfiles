# dotfiles

This is a place where I back up my personal configurations for many common linux tools.

## bootstrap.sh Symlink Setup Script

This script sets up symlinks from your home directory to the configuration files stored in ~/dotfiles-backup, so your dotfiles can be tracked in git while still being used normally by the system.

It links configs for:

- bash (~/.bashrc)
- tmux
- i3
- i3blocks
- ghostty
- neovim

Uses ln -sf to overwrite existing files/links, so it can be re-run safely.
