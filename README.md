# dotfiles-server

## Русский

Минимальные серверные dotfiles для deploy/admin-сессий.

Это не полноценная dev-среда и не локальный desktop-конфиг. Идея проще: быстро
зайти на сервер, развернуть проект, посмотреть файлы/логи/порты, поработать с
Git/Docker и выйти.

Конфиг намеренно не использует Oh My Zsh. Вместо него:

- native `zsh`;
- модульная структура `~/.config/zsh/conf.d`;
- прямое подключение Powerlevel10k, если он установлен;
- простой fallback prompt, если Powerlevel10k отсутствует;
- graceful fallback для optional tools.

### Установка

```bash
git clone <repo-url> ~/.dotfiles-server
~/.dotfiles-server/bin/bootstrap
```

`bootstrap` делает best-effort установку пакетов и zsh-плагинов, затем линкует
dotfiles в `$HOME`.

Если нужно только перелинковать конфиги без установки пакетов и плагинов:

```bash
~/.dotfiles-server/bin/link
```

Проверить установку:

```bash
~/.dotfiles-server/bin/doctor
```

### Что настраивается

- `zsh` loader и модульный конфиг в `~/.config/zsh/conf.d`;
- Powerlevel10k без Oh My Zsh;
- `zsh-autosuggestions` и `zsh-syntax-highlighting`, если установлены;
- history, completion, aliases, functions;
- локальные overrides;
- Git config и global ignore;
- Docker helpers для deploy/admin-задач;
- runtime path detection для уже установленных `nvm`, Composer, Go, Cargo и
  local bin directories.

### Что не входит

- Oh My Zsh;
- tmux;
- GitHub CLI;
- GitLab CLI;
- автозапуск tmux или других программ;
- hardcoded macOS/IDE/Python paths;
- установка Node/PHP/Python/Rust/Go runtime'ов.

### Локальные настройки

Для приватных или host-specific настроек используй:

```bash
~/.zshrc.local
```

Также можно хранить локальные zsh-файлы здесь:

```bash
~/.config/zsh/local/*.zsh
```

Репозиторий не должен хранить секреты, SSH-ключи, токены или приватные настройки
конкретных серверов.

### Backup

Если при линковке уже существуют файлы вроде `.zshrc`, `.zshenv`, `.zprofile`,
`.p10k.zsh` или git config, они не удаляются. Скрипт переносит их в:

```bash
~/.dotfiles-backup/<timestamp>/
```

Повторный запуск `bin/link` идемпотентен: уже корректные symlink'и не
пересоздаются.

### Login shell

`bootstrap` не меняет login shell автоматически. Это намеренно: на серверах
лучше не делать такой побочный эффект молча.

Если `bin/doctor` показывает, что login shell не `zsh`, поменяй его вручную
после проверки политики сервера:

```bash
chsh -s "$(command -v zsh)"
```

### Релизы

Релизы управляются через Release Please и Conventional Commits.

Примеры commit messages:

```text
feat: add docker helpers
fix: keep zsh startup working without optional tools
docs: update install guide
ci: add release workflow
```

При push в `master` или `main` GitHub Actions запускает Release Please. Он
создает или обновляет release PR с changelog и version manifest. После merge
release PR workflow создает GitHub Release, tag и архив:

```text
dist/dotfiles-server-vX.Y.Z.tar.gz
```

Архив также загружается как workflow artifact.

Если workflow падает с ошибкой `GitHub Actions is not permitted to create or
approve pull requests`, включи разрешение в настройках репозитория:

```text
Settings -> Actions -> General -> Workflow permissions
```

Нужно выбрать `Read and write permissions` и включить `Allow GitHub Actions to
create and approve pull requests`.

Если это запрещено на уровне организации, создай fine-grained PAT или GitHub App
token с доступом к repository contents и pull requests, затем сохрани его в
repository secret:

```text
RELEASE_PLEASE_TOKEN
```

---

## English

Minimal server dotfiles for deploy/admin sessions.

This is not a full development environment or a desktop shell setup. The goal is
simple: SSH into a server, deploy something, inspect files/logs/ports, use
Git/Docker, and leave.

This setup intentionally does not use Oh My Zsh. Instead, it uses:

- native `zsh`;
- modular config in `~/.config/zsh/conf.d`;
- direct Powerlevel10k loading when installed;
- a simple fallback prompt when Powerlevel10k is missing;
- graceful fallbacks for optional tools.

### Install

```bash
git clone <repo-url> ~/.dotfiles-server
~/.dotfiles-server/bin/bootstrap
```

`bootstrap` installs packages and zsh plugins best-effort, then links dotfiles
into `$HOME`.

To link dotfiles only, without package or plugin installation:

```bash
~/.dotfiles-server/bin/link
```

Check the installation:

```bash
~/.dotfiles-server/bin/doctor
```

### What it configures

- zsh loader and modular config in `~/.config/zsh/conf.d`;
- Powerlevel10k without Oh My Zsh;
- `zsh-autosuggestions` and `zsh-syntax-highlighting` when installed;
- history, completion, aliases, functions;
- local overrides;
- Git config and global ignore;
- Docker helpers for deploy/admin workflows;
- runtime path detection for existing `nvm`, Composer, Go, Cargo, and local bin
  directories.

### What is not included

- Oh My Zsh;
- tmux;
- GitHub CLI;
- GitLab CLI;
- automatic startup of tmux or other programs;
- hardcoded macOS/IDE/Python paths;
- installation of Node/PHP/Python/Rust/Go runtimes.

### Local overrides

Use this file for private or host-specific settings:

```bash
~/.zshrc.local
```

You can also keep local zsh files here:

```bash
~/.config/zsh/local/*.zsh
```

This repository must not store secrets, SSH keys, tokens, or private
server-specific configuration.

### Backup

If files such as `.zshrc`, `.zshenv`, `.zprofile`, `.p10k.zsh`, or Git config
already exist during linking, they are not deleted. The script moves them to:

```bash
~/.dotfiles-backup/<timestamp>/
```

Running `bin/link` repeatedly is idempotent: already-correct symlinks are left
as-is.

### Login shell

`bootstrap` does not change your login shell automatically. This is intentional:
on servers, that side effect should not happen silently.

If `bin/doctor` reports that your login shell is not `zsh`, change it manually
after checking the server policy:

```bash
chsh -s "$(command -v zsh)"
```

### Releases

Releases are managed by Release Please and Conventional Commits.

Example commit messages:

```text
feat: add docker helpers
fix: keep zsh startup working without optional tools
docs: update install guide
ci: add release workflow
```

On pushes to `master` or `main`, GitHub Actions runs Release Please. It creates
or updates a release PR with the changelog and version manifest. After the
release PR is merged, the workflow creates a GitHub Release, tag, and archive:

```text
dist/dotfiles-server-vX.Y.Z.tar.gz
```

The archive is also uploaded as a workflow artifact.

If the workflow fails with `GitHub Actions is not permitted to create or approve
pull requests`, enable the repository setting:

```text
Settings -> Actions -> General -> Workflow permissions
```

Select `Read and write permissions` and enable `Allow GitHub Actions to create
and approve pull requests`.

If this is blocked by organization policy, create a fine-grained PAT or GitHub
App token with access to repository contents and pull requests, then save it as
this repository secret:

```text
RELEASE_PLEASE_TOKEN
```
