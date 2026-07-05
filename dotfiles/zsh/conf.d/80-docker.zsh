alias d='docker'
alias dimg='docker images'

dps() {
  docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Image}}' "$@"
}

dlog() {
  [[ $# -ge 1 ]] || {
    print -u2 'usage: dlog <container> [docker logs args...]'
    return 2
  }

  docker logs --tail=200 -f "$@"
}

dex() {
  [[ $# -ge 1 ]] || {
    print -u2 'usage: dex <container> [command...]'
    return 2
  }

  local container="$1"
  shift

  if [[ $# -gt 0 ]]; then
    docker exec -it "$container" "$@"
  elif docker exec "$container" command -v bash >/dev/null 2>&1; then
    docker exec -it "$container" bash
  else
    docker exec -it "$container" sh
  fi
}

dc() {
  if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
    docker compose "$@"
  elif command -v docker-compose >/dev/null 2>&1; then
    docker-compose "$@"
  else
    print -u2 'dc: docker compose is not available'
    return 127
  fi
}

dcu() {
  dc up -d "$@"
}

dcd() {
  dc down "$@"
}

dcr() {
  dc restart "$@"
}

dcl() {
  dc logs -f --tail=200 "$@"
}

