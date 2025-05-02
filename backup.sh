#!/bin/bash
cd ~/dotfiles
if [ -n "$(git status --porcelain)" ]; then
  git add .
  git commit -m "Auto backup: $(date)"
  git push
fi
