#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for file in "$ROOT"/bin/* "$ROOT"/scripts/* "$ROOT"/lib/*.sh; do
  [[ -f "$file" ]] || continue
  bash -n "$file"
done

if command -v zsh >/dev/null 2>&1; then
  zsh -n "$ROOT/dotfiles/zsh/.zshenv"
  zsh -n "$ROOT/dotfiles/zsh/.zprofile"
  zsh -n "$ROOT/dotfiles/zsh/.zshrc"
  zsh -n "$ROOT/dotfiles/zsh/.p10k.zsh"
  for file in "$ROOT"/dotfiles/zsh/conf.d/*.zsh; do
    [[ -f "$file" ]] || continue
    zsh -n "$file"
  done
else
  printf 'WARN: zsh is not installed; skipped zsh syntax checks\n' >&2
fi

printf 'Syntax checks passed\n'

