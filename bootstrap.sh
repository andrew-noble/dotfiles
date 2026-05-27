#!/bin/bash

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Bash
ln -sf "$DOTFILES/bashrc" ~/.bashrc
ln -sf "$DOTFILES/bash_aliases" ~/.bash_aliases

# Input
ln -sf "$DOTFILES/inputrc" ~/.inputrc

# Tmux (XDG path; tmux 3.1+ picks this up automatically)
mkdir -p ~/.config
ln -sf "$DOTFILES/config/tmux" ~/.config/tmux

# Ghostty
ln -sf "$DOTFILES/config/ghostty" ~/.config/ghostty

# Neovim
ln -sf "$DOTFILES/config/nvim" ~/.config/nvim

# Git (XDG config)
ln -sf "$DOTFILES/config/git" ~/.config/git

# Systemd user timer for auto-backup
mkdir -p ~/.config/systemd/user
ln -sf "$DOTFILES/config/systemd/user/dotfiles-backup.service" ~/.config/systemd/user/dotfiles-backup.service
ln -sf "$DOTFILES/config/systemd/user/dotfiles-backup.timer" ~/.config/systemd/user/dotfiles-backup.timer
systemctl --user enable --now dotfiles-backup.timer
