path_add() {
  local dir="$1"
  [[ -d "$dir" ]] || return 0

  case ":$PATH:" in
    *":$dir:"*) ;;
    *) export PATH="$dir:$PATH" ;;
  esac
}

fpath_add() {
  local dir="$1"
  [[ -d "$dir" ]] || return 0

  local existing
  for existing in "${fpath[@]}"; do
    [[ "$existing" == "$dir" ]] && return 0
  done

  fpath=("$dir" "${fpath[@]}")
}

if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
  export VISUAL=nvim
elif command -v vim >/dev/null 2>&1; then
  export EDITOR=vim
  export VISUAL=vim
else
  export EDITOR=nano
  export VISUAL=nano
fi

if [[ -z "$TMUX" ]]; then
  export TERM="${TERM:-xterm-256color}"
fi

export LANG="${LANG:-en_US.UTF-8}"

