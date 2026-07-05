reload() {
  source "$HOME/.zshrc"
}

mkcd() {
  [[ $# -eq 1 ]] || {
    print -u2 'usage: mkcd <directory>'
    return 2
  }

  mkdir -p "$1" && cd "$1"
}

extract() {
  [[ $# -eq 1 ]] || {
    print -u2 'usage: extract <archive>'
    return 2
  }

  [[ -f "$1" ]] || {
    print -u2 "extract: not a file: $1"
    return 1
  }

  case "$1" in
    *.tar.bz2 | *.tbz2) tar xjf "$1" ;;
    *.tar.gz | *.tgz) tar xzf "$1" ;;
    *.tar.xz | *.txz) tar xJf "$1" ;;
    *.tar) tar xf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.gz) gunzip "$1" ;;
    *.zip) unzip "$1" ;;
    *.rar) unrar x "$1" ;;
    *.7z) 7z x "$1" ;;
    *)
      print -u2 "extract: unsupported archive: $1"
      return 1
      ;;
  esac
}

ports() {
  if command -v ss >/dev/null 2>&1; then
    ss -tulpn
  elif command -v netstat >/dev/null 2>&1; then
    netstat -tulpn
  elif command -v lsof >/dev/null 2>&1; then
    lsof -i -P -n
  else
    print -u2 'ports: ss, netstat, or lsof is required'
    return 127
  fi
}

path() {
  print -l ${(ps.:.)PATH}
}

ducks() {
  du -sh ./*(N) ./.[!.]*(N) 2>/dev/null | sort -h | tail -n 20
}

croot() {
  local root
  root="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    print -u2 'croot: not inside a git repository'
    return 1
  }

  cd "$root"
}

