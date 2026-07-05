#!/usr/bin/env bash

detect_package_manager() {
  if command_exists apt-get; then
    printf 'apt\n'
  elif command_exists dnf; then
    printf 'dnf\n'
  elif command_exists yum; then
    printf 'yum\n'
  elif command_exists pacman; then
    printf 'pacman\n'
  elif command_exists apk; then
    printf 'apk\n'
  else
    printf 'unknown\n'
  fi
}

packages_for_manager() {
  local manager="$1"

  case "$manager" in
    apt)
      printf '%s\n' \
        zsh git curl ca-certificates fzf ripgrep zoxide eza bat fd-find \
        docker.io docker-compose-plugin
      ;;
    dnf | yum)
      printf '%s\n' \
        zsh git curl ca-certificates fzf ripgrep zoxide eza bat fd-find \
        docker docker-compose-plugin
      ;;
    pacman)
      printf '%s\n' \
        zsh git curl ca-certificates fzf ripgrep zoxide eza bat fd \
        docker docker-compose
      ;;
    apk)
      printf '%s\n' \
        zsh git curl ca-certificates fzf ripgrep zoxide eza bat fd \
        docker docker-compose
      ;;
    *)
      return 1
      ;;
  esac
}

install_one_package() {
  local manager="$1"
  local package="$2"

  case "$manager" in
    apt)
      sudocmd apt-get install -y "$package"
      ;;
    dnf)
      sudocmd dnf install -y "$package"
      ;;
    yum)
      sudocmd yum install -y "$package"
      ;;
    pacman)
      sudocmd pacman -S --needed --noconfirm "$package"
      ;;
    apk)
      sudocmd apk add "$package"
      ;;
    *)
      return 1
      ;;
  esac
}

install_packages_best_effort() {
  local manager
  local package

  manager="$(detect_package_manager)"
  if [[ "$manager" == unknown ]]; then
    warn "No supported package manager found; skipping packages"
    return 0
  fi

  log "Detected package manager: $manager"

  if [[ "$manager" == apt ]]; then
    sudocmd apt-get update || warn "apt-get update failed"
  fi

  while IFS= read -r package; do
    [[ -n "$package" ]] || continue
    log "Installing package best-effort: $package"
    install_one_package "$manager" "$package" || warn "Could not install $package"
  done < <(packages_for_manager "$manager")
}

