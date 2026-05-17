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
