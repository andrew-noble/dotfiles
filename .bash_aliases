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
alias pdf2gray='f(){ gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dProcessColorModel=/DeviceGray -sColorConversionStrategy=Gray -dOverrideICC -o "${1%.pdf}-gray.pdf" "$1"; }; f'
alias pdf2letter='f(){ gs -sDEVICE=pdfwrite -sPAPERSIZE=letter -dFIXEDMEDIA -dPDFFitPage -o "${1%.pdf}-letter.pdf" "$1"; }; f'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lmc="echo 'lists listening ports, preserving helpful header: lsof -i -P -n | grep -E \"COMMAND|LISTEN\"'"
