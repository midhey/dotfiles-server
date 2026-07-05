#!/usr/bin/env bash

set -o pipefail

log() {
  printf '==> %s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*" >&2
}

err() {
  printf 'ERROR: %s\n' "$*" >&2
}

die() {
  err "$*"
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

repo_root() {
  local source_dir
  source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  printf '%s\n' "$source_dir"
}

timestamp() {
  date '+%Y%m%d%H%M%S'
}

ensure_dir() {
  mkdir -p "$1"
}

backup_path() {
  local path="$1"
  local backup_root="$2"

  [[ -e "$path" || -L "$path" ]] || return 0

  ensure_dir "$backup_root"
  mv "$path" "$backup_root/"
  log "Backed up $path to $backup_root/"
}

link_path() {
  local source="$1"
  local target="$2"
  local backup_root="$3"
  local parent

  parent="$(dirname "$target")"
  ensure_dir "$parent"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    log "Already linked $target"
    return 0
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    backup_path "$target" "$backup_root"
  fi

  ln -s "$source" "$target"
  log "Linked $target -> $source"
}

sudocmd() {
  if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    "$@"
  elif command_exists sudo; then
    sudo "$@"
  else
    warn "sudo is not available; cannot run: $*"
    return 127
  fi
}

