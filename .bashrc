# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ "$color_prompt" = yes ]; then
  # old, verbose prompt: PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  PS1='\[\033[38;5;202m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]$(parse_git_branch)\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lmc="echo 'lists listening ports, preserving helpful header: lsof -i -P -n | grep -E \"COMMAND|LISTEN\"'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# gq (git quick) - Simple script that combines git add ., git commit -m "<msg>", and git push
# Usage: gq "<commit message>"
function gq() {
  if [ -z "$1" ]; then
    echo "Usage: gq 'commit message'"
    return 1
  fi

  git add .
  git commit -m "$1"
  git push
}

# eztree - Displays and copies directory trees
# Usage: eztree [directory]
# (uses current directory if none provided)
function eztree() { tree -C -I 'node_modules|.git|dist|build|coverage|venv|__pycache__|.mypy_cache|.pytest_cache|.idea|.vscode' "${1:-.}" | tee >(xclip -selection clipboard) && echo "tree copied to clipboard"; }

# in root of a python/ts project, this will count the lines of code
function linesofcode() {
  find . \( -name '*.py' -o -name '*.ts' \) -not -path '*/node_modules/*' -not -path '*/venv/*' | xargs wc -l
}

#source my secrets file (not here bc this is backed up to github)
[ -f ~/.secrets ] && source ~/.secrets

#this prints the big ubuntu and hw stats splash
neofetch

alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias python='python3'
alias venv='source .venv/bin/activate'
alias swgd='sudo wg-quick down wg0'
alias swgu='sudo wg-quick up wg0'
alias cdp='cd ~/coding/projects'
alias cdc='cd ~/cmu-mrsd/catalyst-robot/'
alias cds='cd ~/cmu-mrsd/2sem/'
alias cc='claude'
alias rsnw="~/wifi-reload.sh"
alias screenrecord='obs'
alias video='mpv'
# serve a static html site to 3000, useful for personal website
alias serve='python3 -m http.server 3000'

# open file with appropriate application, send to background and disown
o() {
  xdg-open "$@" &>/dev/null &
  disown
}

# this adds homebrew to the path env variable (all i use with homebrew rn is nvim)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
. "$HOME/.cargo/env"

alias pdf2gray='f(){ gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dProcessColorModel=/DeviceGray -sColorConversionStrategy=Gray -dOverrideICC -o "${1%.pdf}-gray.pdf" "$1"; }; f'
alias pdf2letter='f(){ gs -sDEVICE=pdfwrite -sPAPERSIZE=letter -dFIXEDMEDIA -dPDFFitPage -o "${1%.pdf}-letter.pdf" "$1"; }; f'

# fuzzy finder config -- picks fd as the find engine, and filters out deps folders
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --exclude .git --exclude node_modules --exclude venv --exclude .venv'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# super cool shortcut that drops you into fzf if you do cd without an argument
cd() {
  if [ $# -eq 0 ]; then
    local dir
    dir=$(fdfind -t d . | fzf) || return
    builtin cd "$dir"
  else
    builtin cd "$@"
  fi
}

# this is for setting up a workspace-scoped ROS environment
function rosenv() {
  # Find nearest ROS workspace (has src/ directory)
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/src" ]]; then
      # Source ROS 2 underlay
      source /opt/ros/jazzy/setup.bash

      # Source overlay if built
      if [[ -f "$dir/install/setup.bash" ]]; then
        source "$dir/install/setup.bash"
        echo "[rosenv] Sourced overlay: $dir"
      else
        echo "[rosenv] Workspace found but not built yet"
      fi
      return 0
    fi
    dir="$(dirname "$dir")"
  done

  echo "[rosenv] No ROS workspace found in path"
  return 1
}

alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'

# ---- bash history (this lets tmux windows all see same history) ----
shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%F %T '

# holy shit vim mode
set -o vi
