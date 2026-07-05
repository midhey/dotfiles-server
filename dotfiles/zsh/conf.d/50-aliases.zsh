alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias grep='grep --color=auto'
alias dfh='df -h'
alias duh='du -h'
alias psg='ps aux | grep -i'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --color=auto'
  alias ll='eza -lah --git --icons --color=always'
  alias la='eza -la --git --icons --color=always'
  alias lt='eza -lah --git --icons --color=always'
  alias ltree='eza --tree --level=2 --icons --git'
else
  alias ll='ls -lah'
  alias la='ls -la'
  alias lt='ls -lah'
  alias ltree='find . -maxdepth 2 -print'
fi

if ! command -v bat >/dev/null 2>&1 && command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
fi

if command -v rg >/dev/null 2>&1; then
  alias search='rg'
fi

if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi

