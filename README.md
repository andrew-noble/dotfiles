# dotfiles

Personal configs for bash, tmux, ghostty, and neovim.

Files are stored without leading dots so the repo is easy to navigate. `bootstrap.sh` creates the symlinks that put them where the system expects.

## Setup

```sh
./bootstrap.sh
```

Links created:

| repo | system |
|------|--------|
| `bashrc` | `~/.bashrc` |
| `bash_aliases` | `~/.bash_aliases` |
| `inputrc` | `~/.inputrc` |
| `config/tmux/` | `~/.config/tmux/` |
| `config/ghostty/` | `~/.config/ghostty/` |
| `config/nvim/` | `~/.config/nvim/` |
