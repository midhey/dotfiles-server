zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

autoload -Uz compinit
compinit -i -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

