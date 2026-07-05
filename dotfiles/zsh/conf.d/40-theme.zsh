typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

if [[ -r "$HOME/.powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOME/.powerlevel10k/powerlevel10k.zsh-theme"
  [[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
else
  _dotfiles_git_prompt() {
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 0

    local branch
    branch="$(command git symbolic-ref --quiet --short HEAD 2>/dev/null ||
      command git rev-parse --short HEAD 2>/dev/null)" || return 0

    printf ' %%F{yellow}git:%s%%f' "$branch"
  }

  PROMPT='%F{green}%n@%m%f %F{blue}%~%f$(_dotfiles_git_prompt) %# '
fi

